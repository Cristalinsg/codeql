/**
 * @name TypeIsInPackage
 */

import default

from RefType tp
where tp.fromSource() and tp.getCompilationUnit().getName() = "A"
select tp, tp.getPackage()
