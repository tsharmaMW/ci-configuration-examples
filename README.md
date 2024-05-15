# Advanced Continuous Integration (CI) configuration examples for MATLAB®

This repository houses advanced MATLAB related workflows for the most common CI platforms. The configuration files take care of setting up MATLAB to work with the CI system and automatically executing your MATLAB tests.

If you are just beggining with connecting MATLAB with CI systems, the [ci-configuration-examples](https://github.com/mathworks/ci-configuration-examples) repository is an ideal starting point.

## Supported CI platforms
* Azure DevOps
* CircleCI
* GitHub Actions
* Jenkins&trade;

# Workflows in the repository

## 1) Toolbox packaging and distribution
This workflow demonstrates compilation, linking, and testing the C source file across multiple Operating Systems, which produces a binary MEX file within a single execution of the job. Finally, the resulting binaries are bundled together into a toolbox, which is then distributed as a GitHub release.

The repository includes configuration files for these CI platforms:
* [Azure DevOps](https://github.com/tsharmaMW/ci-configuration-examples/blob/main/azure-pipelines.yml)
* [CircleCI](https://github.com/tsharmaMW/ci-configuration-examples/blob/main/.circleci/config.yml)
* [GitHub Actions](https://github.com/tsharmaMW/ci-configuration-examples/blob/main/.github/workflows/create-and-release-toolbox.yml)
* [Jenkins&trade;](https://github.com/tsharmaMW/ci-configuration-examples/blob/main/Jenkinsfile)
