classdef KgToPoundsEquivalenceTest < matlabtest.compiler.TestCase
    % properties
    %     BuildResults
    % end
    
    % methods(TestClassSetup)
    %     function buildPackage(testCase)
    %         testCase.BuildResults = build(testCase,"../src/KgToPounds.m", "pythonPackage");
    %     end
    % end
    
    methods(Test, TestTags = {'EquivalenceTest'})
        function pythonEquivalenceTest(testCase)
            % loadedData = load("pythonBuild.mat"); % for run-command
            loadedData = load("../pythonBuild.mat"); % for run-test
            buildResults = loadedData.buildResults;
            executionResults = execute(testCase,buildResults,{[1,2,3,4,5]});
            verifyExecutionMatchesMATLAB(testCase,executionResults);
        end
    end
    
end