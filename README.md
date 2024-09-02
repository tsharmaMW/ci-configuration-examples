# Advanced Continuous Integration (CI) configuration examples for MATLAB®

This repository houses advanced MATLAB related workflows for the most common CI platforms. The configuration files take care of setting up MATLAB to work with the CI system and automatically executing your MATLAB tests.

If you are just beggining with connecting MATLAB with CI systems, the [ci-configuration-examples](https://github.com/mathworks/ci-configuration-examples) repository is an ideal starting point.

<br>

## Supported CI platforms
* Azure® DevOps
* CircleCI®
* GitHub® Actions
* Jenkins&trade;

<br>

# Workflows in the repository

## 1) Toolbox packaging and distribution
This workflow demonstrates compilation, linking, and testing the C source file across multiple Operating Systems, which produces a binary MEX file within a single execution of the job. Finally, the resulting binaries are bundled together into a toolbox, which is then distributed as a GitHub release.

The repository includes configuration files for these CI platforms:
* [Azure DevOps](https://github.com/tsharmaMW/ci-configuration-examples/blob/main/AzureDevOps/ToolboxDistribution.yml)
* [CircleCI](https://github.com/tsharmaMW/ci-configuration-examples/blob/main/.circleci/ToolboxDistribution.yml)
* [GitHub Actions](https://github.com/tsharmaMW/ci-configuration-examples/blob/main/.github/workflows/ToolboxDistribution.yml)
* [Jenkins&trade;](https://github.com/tsharmaMW/ci-configuration-examples/blob/main/Jenkins/ToolboxDistribution.yml)

## 2) Building and publishing executables
This workflow automates the process of building and publishing MATLAB executables across multiple Operating Systems. It installs specific MATLAB releases and compiles MATLAB functions for deployment using the MATLAB Compiler SDK. Finally, the compiled executables are stored as artifacts. It ensures compatibility and efficience in generating deployable applications.

The repository includes configuration files for these CI platforms:
* [Azure DevOps](https://github.com/tsharmaMW/ci-configuration-examples/blob/main/AzureDevOps/CrossPlatformBuilder.yml)
* [CircleCI](https://github.com/tsharmaMW/ci-configuration-examples/blob/main/.circleci/CrossPlatformBuilder.yml)
* [GitHub Actions](https://github.com/tsharmaMW/ci-configuration-examples/blob/main/.github/workflows/CrossPlatformBuilder.yml)
* [Jenkins&trade;](https://github.com/tsharmaMW/ci-configuration-examples/blob/main/Jenkins/CrossPlatformBuilder.yml)

<br>

## Contact Us
If you have any questions or suggestions, please contact MathWorks at [continuous-integration@mathworks.com](mailto:continuous-integration@mathworks.com).