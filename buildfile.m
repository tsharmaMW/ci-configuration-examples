function plan = buildfile
import matlab.buildtool.tasks.CodeIssuesTask
import matlab.buildtool.tasks.TestTask

% Create a plan from task functions
plan = buildplan(localfunctions);

% Add a task to identify code issues
plan("checkCode") = CodeIssuesTask;

% Add a task to run tests and generate test and coverage results
plan("testMex") = TestTask(SourceFiles="arrayProductTest.m", TestResults="test-results/results.xml", CodeCoverageResults="code-coverage/results.xml");

end

function createMexTask(~)
% Create a mex file
    mex arrayProduct.c;
end

function createExecutableTask(~)
% Create an executable
    mcc -m code/quadraticSolver.m;
    dir;
end
