Test utils using the llvm parser
======================================

Example use of the AST matcher
-----------------------------

See src/loop_matcher.cpp

After "make", to test, run:
./loop_convert test/test2.cpp --


It should return something like:


ForStmt 0x2d71838
|-DeclStmt 0x2d25ca0
| `-VarDecl 0x2d25c20  used i 'int' cinit
|   `-IntegerLiteral 0x2d25c80 'int' 0
|-<<<NULL>>>
|-BinaryOperator 0x2d25d18 '_Bool' '<'
| |-ImplicitCastExpr 0x2d25d00 'int' <LValueToRValue>
| | `-DeclRefExpr 0x2d25cb8 'int' lvalue Var 0x2d25c20 'i' 'int'
| `-IntegerLiteral 0x2d25ce0 'int' 10
|-UnaryOperator 0x2d25d68 'int' postfix '++'
| `-DeclRefExpr 0x2d25d40 'int' lvalue Var 0x2d25c20 'i' 'int'
`-CompoundStmt 0x2d71818
  `-UnaryOperator 0x2d717f8 'int' postfix '++'
    `-DeclRefExpr 0x2d717d0 'int' lvalue Var 0x2d25b78 'ret' 'int'


AST Visitor example
-----------------------------

./visitor test/test.cpp ---

Should return:
CXXMethodDecl 0x4185740 </home/lben/tools/clang-tests/test/test.cpp:5:4, line:7:3> line:5:11 used toto 'double (int, float, double)'
|-ParmVarDecl 0x4134af8 <col:16, col:20> col:20 used i 'int'
|-ParmVarDecl 0x4134b68 <col:23, col:29> col:29 used k 'float'
|-ParmVarDecl 0x4134bd8 <col:32, col:39> col:39 used l 'double'
`-CompoundStmt 0x4185980 <col:42, line:7:3>
  `-ReturnStmt 0x4185968 <line:6:5, col:20>
    `-BinaryOperator 0x4185940 <col:12, col:20> 'double' '*'
      |-ImplicitCastExpr 0x4185928 <col:12, col:16> 'double' <FloatingCast>
      | `-BinaryOperator 0x41858c0 <col:12, col:16> 'float' '*'
      |   |-ImplicitCastExpr 0x41858a8 <col:12> 'float' <IntegralToFloating>
      |   | `-ImplicitCastExpr 0x4185878 <col:12> 'int' <LValueToRValue>
      |   |   `-DeclRefExpr 0x4185828 <col:12> 'int' lvalue ParmVar 0x4134af8 'i' 'int'
      |   `-ImplicitCastExpr 0x4185890 <col:16> 'float' <LValueToRValue>
      |     `-DeclRefExpr 0x4185850 <col:16> 'float' lvalue ParmVar 0x4134b68 'k' 'float'
      `-ImplicitCastExpr 0x4185910 <col:20> 'double' <LValueToRValue>
        `-DeclRefExpr 0x41858e8 <col:20> 'double' lvalue ParmVar 0x4134bd8 'l' 'double'

