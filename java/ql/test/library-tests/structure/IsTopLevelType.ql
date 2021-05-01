/**
 * @name IsTopLevelType
 */

import default

from TopLevelType tp
where tp.fromSource() and tp.getCompilationUnit().getName() = "A"
select tp, tp.getPackage()
