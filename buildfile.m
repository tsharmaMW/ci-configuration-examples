function plan = buildfile
import matlab.buildtool.tasks.CodeIssuesTask
import matlab.buildtool.tasks.TestTask

% Create a plan from task functions
plan = buildplan(localfunctions);

% Add a task to identify code issues
plan("check") = CodeIssuesTask;

% Add a task to run tests and generate test and coverage results
plan("test") = TestTask(SourceFiles="code/quadraticSolver.m", TestResults="test-results/results.xml", CodeCoverageResults="code-coverage/results.xml");

% plan.DefaultTasks = "mex";

end

function mexTask(~)
% Create a mex file
    mex code/yprime.c
    disp(mexext)
end
