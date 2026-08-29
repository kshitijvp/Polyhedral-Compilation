//=============================================================================
// FILE:
//    DependenceAnalysis.cpp
//
// DESCRIPTION:
//      Prints all the Dependencies (RAW, WAW, WAR) within function loops.
//
// USAGE:
//    New PM
//      opt -load-pass-plugin=libDependenceAnalysis.so -passes="Dependence-Analysis" `\`
//        -disable-output <input-llvm-file>
//
//
// IIT Dharwad
//=============================================================================

#include "llvm/Passes/PassBuilder.h"
#include "llvm/Plugins/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Support/GenericLoopInfo.h"
#include "llvm/Analysis/LoopInfo.h"
#include "llvm/Analysis/DependenceAnalysis.h"

using namespace llvm;
using namespace std;

//-----------------------------------------------------------------------------
// DependenceAnalysis implementation
//-----------------------------------------------------------------------------
// No need to expose the internals of the pass to the outside world - keep
// everything in an anonymous namespace.
namespace {
// New PM implementation
struct checkDependence : PassInfoMixin<checkDependence> {
  string getVarName(Value *V) {
    if (auto *AI = dyn_cast<AllocaInst>(V)) {
      if (AI->hasName())
        return AI->getName().str();
    }

    if (auto *GV = dyn_cast<GlobalVariable>(V)) {
      if (GV->hasName())
        return GV->getName().str();
    }

    if (V->hasName())
      return V->getName().str();
  }
  string exprToString(Value *V) {
    if (auto *LI = dyn_cast<LoadInst>(V))
      return exprToString(LI->getPointerOperand());
    if (auto *SI = dyn_cast<SExtInst>(V))
      return exprToString(SI->getOperand(0));
    if (auto *ZI = dyn_cast<ZExtInst>(V))
      return exprToString(ZI->getOperand(0));
    if (auto *TI = dyn_cast<TruncInst>(V))
      return exprToString(TI->getOperand(0));

    if (auto *BO = dyn_cast<BinaryOperator>(V)) {
      std::string Op;
      switch (BO->getOpcode()) {
        case Instruction::Add: Op = "+"; break;
        case Instruction::Sub: Op = "-"; break;
        case Instruction::Mul: Op = "*"; break;
        case Instruction::SDiv:
        case Instruction::UDiv: Op = "/"; break;
        default: Op = "?"; break;
      }
      return "(" + exprToString(BO->getOperand(0)) + Op +
                  exprToString(BO->getOperand(1)) + ")";
    }

    if (auto *AI = dyn_cast<AllocaInst>(V))
      return getVarName(AI);
    if (auto *C = dyn_cast<ConstantInt>(V))
      return to_string(C->getSExtValue());
    return "?";
  }
  string processGEP(Value *V) {
    vector<string> Indices;
    Value *Cur = V;
    while (auto *GEP = dyn_cast<GetElementPtrInst>(Cur)) {
      Value *IdxOperand = GEP->getOperand(GEP->getNumOperands() - 1);
      Indices.push_back(exprToString(IdxOperand));
      Cur = GEP->getPointerOperand();
    }
    string Base = getVarName(Cur);
    for (int i = Indices.size() - 1; i >= 0; i--) {
      Base += '[' + Indices[i] + ']';
    }
    return Base;
  }
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &FAM) {
    LoopInfo &LI = FAM.getResult<LoopAnalysis>(F);
    DependenceInfo &DI = FAM.getResult<DependenceAnalysis>(F);
    vector<Instruction*> MemInst;
    for (BasicBlock &BB : F) {
      if (!LI.getLoopFor(&BB))
        continue;
      for (Instruction &I : BB) {
        if (isa<LoadInst>(&I) || isa<StoreInst>(&I)) {
          if (LoadInst *LoI = dyn_cast<LoadInst>(&I)) {
            if (isa<GetElementPtrInst>(LoI->getPointerOperand()))
              MemInst.push_back(LoI);
          }
          else if (StoreInst *SI = dyn_cast<StoreInst>(&I)) {
            if (isa<GetElementPtrInst>(SI->getPointerOperand()))
              MemInst.push_back(SI);
          }
        }
      }
    }

    for (int i = 0; i < MemInst.size(); i++) {
      for (int j = i + 1; j < MemInst.size(); j++) {
        if (auto Dep = DI.depends(MemInst[i], MemInst[j], false)) {
            unsigned line1, line2;
            if (DILocation *Loc = MemInst[i]->getDebugLoc())
              line1 = Loc->getLine();
            if (DILocation *Loc = MemInst[j]->getDebugLoc())
              line2 = Loc->getLine();
            if (Dep->isFlow()) {
              errs() << "RAW\n";
              errs() << processGEP((dyn_cast<LoadInst>(MemInst[j]))->getPointerOperand()) << " -> ";
              errs() << processGEP((dyn_cast<StoreInst>(MemInst[i]))->getPointerOperand()) << "\n";
              errs() << "Line " << line2 << "->" << " Line " << line1 << "\n"; 
            }
            else if (Dep->isAnti()) {
              errs() << "WAR\n";
              errs() << processGEP((dyn_cast<StoreInst>(MemInst[j]))->getPointerOperand()) << " -> ";
              errs() << processGEP((dyn_cast<LoadInst>(MemInst[i]))->getPointerOperand()) << "\n";
              errs() << "Line " << line2 << "->" << " Line " << line1 << "\n";
            }
            else if (Dep->isOutput()) {
              errs() << "WAW\n";
              errs() << processGEP((dyn_cast<StoreInst>(MemInst[j]))->getPointerOperand()) << " -> ";
              errs() << processGEP((dyn_cast<StoreInst>(MemInst[i]))->getPointerOperand()) << "\n";
              errs() << "Line " << line2 << "->" << " Line " << line1 << "\n";
            }
            else if (Dep->isConfused()) {
              errs() << "Confused\n";
              MemInst[i]->dump();
              MemInst[j]->dump();
              errs() << line1 << "<-" << line2;
            }
        }
      }
    }

    return PreservedAnalyses::all();
  }

  // Without isRequired returning true, this pass will be skipped for functions
  // decorated with the optnone LLVM attribute. Note that clang -O0 decorates
  // all functions with optnone.
  static bool isRequired() { return true; }
};
} // namespace

//-----------------------------------------------------------------------------
// New PM Registration
//-----------------------------------------------------------------------------
llvm::PassPluginLibraryInfo getDependenceAnalysisPluginInfo() {
  return {LLVM_PLUGIN_API_VERSION, "checkDependence", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                   ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "check-dependence") {
                    FPM.addPass(checkDependence());
                    return true;
                  }
                  return false;
                });
          }};
}

// This is the core interface for pass plugins. It guarantees that 'opt' will
// be able to recognize HelloWorld when added to the pass pipeline on the
// command line, i.e. via '-passes=hello-world'
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getDependenceAnalysisPluginInfo();
}