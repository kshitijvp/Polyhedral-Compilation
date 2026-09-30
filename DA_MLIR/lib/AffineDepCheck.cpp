//===- AffineDepCheck.cpp - Check dependencies between affine accesses --===//
//
// A standalone pass that walks a func::FuncOp, collects all affine.load
// and affine.store operations, and reports pairwise data dependencies
// between accesses to the same memref using MLIR's affine dependence
// analysis.
//
//===----------------------------------------------------------------------===//

#include "AffineDepCheck.h"
#include "mlir/Dialect/Affine/Analysis/AffineAnalysis.h"
#include "mlir/Dialect/Affine/Analysis/Utils.h"
#include "mlir/Dialect/Affine/LoopUtils.h"
#include "mlir/IR/PatternMatch.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"
#include "mlir/Dialect/Affine/IR/AffineOps.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/Pass/Pass.h"
#include "mlir/Pass/PassRegistry.h"
#include "llvm/Support/raw_ostream.h"
#include "mlir/IR/AsmState.h"

using namespace llvm;
using namespace mlir;
using namespace mlir::affine;

namespace mlir {

using mlir::affine::AffineForOp;
using mlir::affine::loopUnrollFull;

static void printAccess(Operation *op, AsmState &state, raw_ostream &os) {
  Value memref;
  if (auto rd = dyn_cast<affine::AffineReadOpInterface>(op))
    memref = rd.getMemRef();
  else if (auto wr = dyn_cast<affine::AffineWriteOpInterface>(op))
    memref = wr.getMemRef();
  else
    return;

  std::string name;                       // will hold "%alloc"
  { llvm::raw_string_ostream ns(name); memref.printAsOperand(ns, state); }

  std::string text;                       // will hold the whole line
  { llvm::raw_string_ostream ts(text); op->print(ts, state); }

  size_t begin = text.find(name + "[");   // find "%alloc["
  size_t end = text.find(']', begin);     // find the closing "]"
  os << StringRef(text).slice(begin, end + 1) << "\n";
}

void AffineDepCheck::runOnOperation() {
  func::FuncOp func = getOperation();
  SmallVector<Operation*, 8> accesses;
  AsmState state(func);
  func.walk([&](Operation *nestedOp) {
    if (!isa<affine::AffineLoadOp, affine::AffineStoreOp>(nestedOp)) return;

    if (!nestedOp->getParentOfType<affine::AffineForOp>()) return;

    accesses.push_back(nestedOp);
  });

  for (int i = 0; i < accesses.size(); i++) {
    for (int j = i + 1; j < accesses.size(); j++) {
      MemRefAccess srcAccess(accesses[i]);
      MemRefAccess dstAccess(accesses[j]);
      unsigned numCommonLoops = getNumCommonSurroundingLoops(*srcAccess.opInst, *dstAccess.opInst);
      for (int depth = 1; depth <= numCommonLoops + 1; depth++) {
        FlatAffineValueConstraints dependenceConstraints;
        SmallVector<DependenceComponent, 2> depComps;
        DependenceResult result = checkMemrefAccessDependence(
            srcAccess, dstAccess, depth, &dependenceConstraints,
            &depComps);

        if (hasDependence(result)) {
            llvm::outs() << "\nDependence found:\n";
            llvm::outs() << "  src: " << "\n";
            if (isa<affine::AffineStoreOp>(srcAccess.opInst))
              printAccess(dyn_cast<affine::AffineStoreOp>(srcAccess.opInst), state, llvm::outs());
            else if (isa<affine::AffineLoadOp>(srcAccess.opInst))
              printAccess(dyn_cast<affine::AffineLoadOp>(srcAccess.opInst), state, llvm::outs());
            llvm::outs() << "  dst: " << "\n";
            if (isa<affine::AffineStoreOp>(dstAccess.opInst))
              printAccess(dyn_cast<affine::AffineStoreOp>(dstAccess.opInst), state, llvm::outs());
            else if (isa<affine::AffineLoadOp>(dstAccess.opInst))
              printAccess(dyn_cast<affine::AffineLoadOp>(dstAccess.opInst), state, llvm::outs());
            llvm::outs() << "  depth: " << depth << "\n";
        }
      }
    }
  }
}

} //namespace mlir
