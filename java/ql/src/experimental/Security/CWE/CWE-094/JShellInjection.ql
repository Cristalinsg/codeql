/**
 * @name JShell injection
 * @description Evaluation of a user-controlled JShell expression
 *              may lead to arbitrary code execution.
 * @kind path-problem
 * @problem.severity error
 * @precision high
 * @id java/jshell-injection
 * @tags security
 *       external/cwe-094
 */

import java
import JShellInjection
import semmle.code.java.dataflow.DataFlow2
import semmle.code.java.dataflow.FlowSources
import DataFlow::PathGraph

class JShellInjectionConfiguration extends TaintTracking::Configuration {
  JShellInjectionConfiguration() { this = "JShellInjectionConfiguration" }

  override predicate isSource(DataFlow::Node source) { source instanceof RemoteFlowSource }

  override predicate isSink(DataFlow::Node sink) { sink instanceof JShellInjectionSink }

  override predicate isAdditionalTaintStep(DataFlow::Node pred, DataFlow::Node succ) {
    exists(
      SourceCodeAnalysisAnalyzeCompletionCall scaacc, CompletionInfoSourceOrRemainingCall cisorc
    |
      scaacc.getArgument(0) = pred.asExpr() and
      cisorc = succ.asExpr() and
      DataFlow2::localExprFlow(scaacc, cisorc.getQualifier())
    )
  }
}

from DataFlow::PathNode source, DataFlow::PathNode sink, JShellInjectionConfiguration conf
where conf.hasFlowPath(source, sink)
select sink.getNode(), source, sink, "JShell injection from $@.", source.getNode(),
  "this user input"
