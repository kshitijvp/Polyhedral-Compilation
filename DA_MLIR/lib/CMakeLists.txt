add_mlir_library(AffineDepCheck
  AffineDepCheck.cpp

  ADDITIONAL_HEADER_DIRS
  ${PROJECT_SOURCE_DIR}/include

  LINK_LIBS PUBLIC
  MLIRAffineAnalysis
  MLIRAffineDialect
  MLIRFuncDialect
  MLIRIR
  MLIRPass
  MLIRSupport
)