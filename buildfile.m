function plan = buildfile
import matlab.buildtool.tasks.CodeIssuesTask
import matlab.buildtool.tasks.TestTask

% Create a plan from task functions
plan = buildplan(localfunctions);

% Add a task to identify code issues
plan("check") = CodeIssuesTask;

plan.DefaultTasks = "mex";

end

function mexTask(~)
% Create a mex file
    mex code/yprime.c
end
