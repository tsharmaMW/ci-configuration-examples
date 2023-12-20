function plan = buildfile
import matlab.buildtool.tasks.CodeIssuesTask
import matlab.buildtool.tasks.TestTask

% Create a plan from task functions
plan = buildplan(localfunctions);

% Add a task to identify code issues
plan("checkCode") = CodeIssuesTask;

end

function createExecutableTask(~)
% Create an executable
    mcc -m code/quadraticSolver.m;
end
