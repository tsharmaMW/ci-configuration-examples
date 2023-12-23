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
plan("testMex").Dependencies = ["setup"];

% plan("createMex") = MEXTask("arrayProduct.c");

end

function createMexTask(~)
    % Create a mex file
    mex arrayProduct.c -outdir toolbox/;
end

function setupTask(context)
    % Setup path for the build
    addpath(fullfile(context.Plan.RootFolder,"toolbox"));
end

function toolboxTask(~)
    % Create an mltbx toolbox package
    dir toolbox/*.mex*;
    identifier = "myToolboxUuid";
    toolboxFolder = "toolbox";
    opts = matlab.addons.toolbox.ToolboxOptions(toolboxFolder,identifier);
    
    opts.ToolboxName = "Array Product Toolbox";
    opts.MinimumMatlabRelease = "R2023a";

    matlab.addons.toolbox.packageToolbox(opts);

    dir;
    disp("-------");
    dir toolbox/*.mex*;
end