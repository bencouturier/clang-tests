#include <iostream>
#include <string>

#include "clang/AST/AST.h"
#include "clang/Frontend/FrontendActions.h"
#include "clang/Frontend/CompilerInstance.h"
#include "clang/Tooling/CommonOptionsParser.h"
#include "clang/Tooling/Tooling.h"
#include "clang/ASTMatchers/ASTMatchers.h"
#include "clang/ASTMatchers/ASTMatchFinder.h"

#include "llvm/Support/raw_ostream.h"

using namespace clang;
using namespace clang::driver;
using namespace clang::tooling;
using namespace clang::ast_matchers;

static llvm::cl::OptionCategory ToolingSampleCategory("Matcher test");

// Loop matcher for loop example
StatementMatcher CallMatcher =
  memberCallExpr(hasName("toto")).bind("call");

class Callrinter : public MatchFinder::MatchCallback {
public :
  virtual void run(const MatchFinder::MatchResult &Result) {
    if (const CXXMemberCallExpr *s = Result.Nodes.getNodeAs<clang::CXXMemberCallExp>("call"))
      s->dump();
  }
};

int main(int argc, const char **argv) {
  CommonOptionsParser op(argc, argv, ToolingSampleCategory);
  ClangTool Tool(op.getCompilations(), op.getSourcePathList());

  CallPrinter Printer;
  MatchFinder Finder;
  Finder.addMatcher(CallMatcher, &Printer);

  return Tool.run(newFrontendActionFactory(&Finder).get());

}
