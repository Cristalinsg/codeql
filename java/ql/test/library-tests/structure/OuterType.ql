/**
 * @name OuterType
 */

import default

from TopLevelType t
where t.fromSource() and t.getCompilationUnit().getName() = "A"
select t
