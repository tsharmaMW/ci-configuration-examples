classdef KgToPoundsEquivalenceTest < matlabtest.compiler.TestCase
    properties
        BuildResults
    end
    
    methods(TestClassSetup)
        function buildPackage(testCase)
            testCase.BuildResults = build(testCase,"../src/KgToPounds.m", "pythonPackage");
        end
    end
    
    methods(Test)
        function pythonEquivalenceTest(testCase)
            % loadedData = load("pythonBuild.mat");
            % buildResults = loadedData.buildResults;
            executionResults = execute(testCase,buildResults,{[1,2,3,4,5]});
            verifyExecutionMatchesMATLAB(testCase,executionResults);
        end
    end
    
end