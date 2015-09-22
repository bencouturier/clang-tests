Test utils using the llvm parser
======================================

Example use of the AST matcher
-----------------------------

See src/loop_matcher.cpp

After "make", to test, run:
./loop_convert test/test2.cpp


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


