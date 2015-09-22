
# To hardcode teh version of cl ang
#LLVM_BUILD_PATH :=/afs/cern.ch/sw/lcg/external/llvm/3.7/x86_64-slc6
#LVM_BIN_PATH := $(LLVM_BUILD_PATH)/bin

# To look it up from the binary
CLANGBIN := $(shell which clang++)
LLVM_BIN_PATH := $(shell dirname $(CLANGBIN))
LLVM_BUILD_PATH= $(shell dirname $(LLVM_BIN_PATH))

$(info Using clang from: $(CLANGBIN))

PLUGIN_CXXFLAGS := -fpic
LLVM_CXXFLAGS := `$(LLVM_BIN_PATH)/llvm-config --cxxflags`
LLVM_LDFLAGS := `$(LLVM_BIN_PATH)/llvm-config --ldflags --libs --system-libs`
CLANG_INCLUDES := -I$(LLVM_SRC_PATH)/tools/clang/include -I$(LLVM_BUILD_PATH)/tools/clang/include
CLANG_LIBS := \
	-Wl,--start-group \
	-lclangAST \
	-lclangAnalysis \
	-lclangBasic \
	-lclangDriver \
	-lclangEdit \
	-lclangFrontend \
	-lclangFrontendTool \
	-lclangLex \
	-lclangParse \
	-lclangSema \
	-lclangEdit \
	-lclangASTMatchers \
	-lclangRewrite \
	-lclangRewriteFrontend \
	-lclangStaticAnalyzerFrontend \
	-lclangStaticAnalyzerCheckers \
	-lclangStaticAnalyzerCore \
	-lclangSerialization \
	-lclangToolingCore \
	-lclangTooling \
	-Wl,--end-group

CXX := g++
CXXFLAGS:= -fno-rtti -O0 -g 
EXEC:= loop_matcher visitor call_matcher

all: $(EXEC) 

call_matcher: src/call_matcher.cpp
	$(CXX) $(CXXFLAGS) $(LLVM_CXXFLAGS) $(CLANG_INCLUDES) $^ $(CLANG_LIBS) $(LLVM_LDFLAGS) -o $@

loop_matcher: src/loop_matcher.cpp
	$(CXX) $(CXXFLAGS) $(LLVM_CXXFLAGS) $(CLANG_INCLUDES) $^ $(CLANG_LIBS) $(LLVM_LDFLAGS) -o $@


visitor: src/visitor.cpp
	$(CXX) $(CXXFLAGS) $(LLVM_CXXFLAGS) $(CLANG_INCLUDES) $^ $(CLANG_LIBS) $(LLVM_LDFLAGS) -o $@

clean:
	rm -f $(EXEC)
