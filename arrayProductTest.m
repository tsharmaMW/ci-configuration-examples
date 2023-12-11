classdef arrayProductTest < matlab.unittest.TestCase
    methods(Test)
        function checkCalculationResult(testCase)
            actSolution = arrayProduct(5,[1.5, 2, 9]);
            expSolution = [7.5, 10, 45];
            testCase.verifyEqual(actSolution,expSolution)
        end
        function checkNotRowVector(testCase)
            testCase.verifyError(@()arrayProduct(2,[1 2;3 4]), "MyToolbox:arrayProduct:notRowVector");
        end
    end
end