classdef arrayProductTest < matlab.unittest.TestCase
    methods(Test)
        function validateCalculationResult(testCase)
            actSolution = arrayProduct(5,[1.5, 2, 9]);
            expSolution = [7.5, 10, 45];
            testCase.verifyEqual(actSolution,expSolution)
        end
        function validateNumberOfInputs(testCase)
            testCase.verifyError(@()arrayProduct(2), "MyToolbox:arrayProduct:nrhs");
        end
    end
end