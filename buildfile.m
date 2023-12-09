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

plan("testMex") = TestTask(SourceFiles="arrayProduct.cpp");

end

function mexTask(~)
% Create a mex file
    mex arrayProduct.cpp;
    disp(mexext);
    disp(arrayProduct(2,[1 2;3 4]));
end
