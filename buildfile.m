function plan = buildfile
import matlab.buildtool.tasks.CodeIssuesTask
import matlab.buildtool.tasks.TestTask
% import matlab.buildtool.tasks.MEXTask

% Create a plan from task functions
plan = buildplan(localfunctions);

% Add a task to identify code issues
plan("checkCode") = CodeIssuesTask;

% Add a task to run tests and generate test and coverage results
plan("testMex") = TestTask(SourceFiles="arrayProductTest.m", TestResults="test-results/results.xml", CodeCoverageResults="code-coverage/results.xml");

% plan("createMex") = MEXTask("arrayProduct.c");

end

function createMexTask(~)
    % Create a mex file
    mex arrayProduct.c --outdir toolbox/;
end

% function toolboxTask(~)
%     % Create an mltbx toolbox package
%     dir toolbox/*.mex*
%     matlab.addons.toolbox.packageToolbox("Array-Product.prj","release/Array-Product.mltbx");
% end