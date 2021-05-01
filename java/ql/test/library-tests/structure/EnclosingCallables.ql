import default

string printableEnclosingCallable(Expr e) {
  result = e.getEnclosingCallable().getName()
  or
  not exists(e.getEnclosingCallable()) and result = "--none--"
}

from Expr e
where e.getCompilationUnit().getName() = "A"
select e, printableEnclosingCallable(e)
