function plan = buildfile
import matlab.buildtool.tasks.CodeIssuesTask
import matlab.buildtool.tasks.TestTask

% Create a plan from task functions
plan = buildplan(localfunctions);

% Add a task to identify code issues
plan("check") = CodeIssuesTask;

% Add a task to run tests and generate test and coverage results
plan("test") = TestTask(SourceFiles="arrayProductTest.m", TestResults="test-results/results.xml", CodeCoverageResults="code-coverage/results.xml");

% plan.DefaultTasks = "mex";

plan("testMex") = TestTask();

end

function mexTask(~)
% Create a mex file
    mex arrayProduct.cpp;
    disp(mexext);
    dir;
    % searching for error in ubuntu says to install gcc
    disp(arrayProduct(2,[1 2;3 4]));
    disp(arrayProduct(1));
end
