classdef arrayProductTest < matlab.unittest.TestCase
    methods(Test)
        function checkOutput(testCase)
            actSolution = arrayProduct(2,[1 2;3 4]);
            expSolution = [2 4;6 8];
            testCase.verifyEqual(actSolution,expSolution)
        end
        % function checkNumberOfArguments(testCase)
        %     testCase.verifyError(@()arrayProduct(1), ...
        %         "Two inputs required")
        % end
    end
end