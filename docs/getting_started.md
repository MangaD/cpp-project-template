# Getting Started

1. Install the required software as instructed in the [installation guide](./install.md).
2. Modify the [LICENSE](../LICENSE) file to suit your application.
3. Modify the global variables in the [CMakeLists.txt](../CMakeLists.txt) file.
4. Change the application's splashscreen in [assets/images](../assets/images).
5. Change the package's icons and banners in the subdirectories of [packaging](../packaging).
6. Change the application's logo in [docs/doxygen](./doxygen).
7. Remove the `.github/FUNDING.yml` file or modify it to suit your needs.
8. Remove the `CODEOWNERS` file or modify it to suit your needs.
9. Remove the `CITATION.cff` file or modify it to suit your needs.
10. If using GitLab, change the path of the CI/CD configuration file in your GitLab project's `Settings -> CI/CD` to `.gitlab/.gitlab-ci.yml`.
11. Create a [new project in CDash](https://my.cdash.org/project/new). Edit the file [CTestConfig.cmake](../CTestConfig.cmake) and update the CDash badge in the [README.md](../README.md) file accordingly.
12. Setup your repository in [Codecov](https://about.codecov.io/). Add the following [GitHub repository secret](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository):
    - `CODECOV_TOKEN`: Your Codecov repository upload token.

    Update the Codecov badge in the [README.md](../README.md) file accordingly.
13. Setup your repository in [Coveralls](https://coveralls.io/).  Add the following [GitHub repository secret](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository):
    - `COVERALLS_REPO_TOKEN`: Your Coveralls token.

    Update the Coveralls badge in the [README.md](../README.md) file accordingly.
14. Setup your repository in [Coverity scan](https://scan.coverity.com/). Add the following [GitHub repository secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository):
    - `COVERITY_SCAN_EMAIL`: Your Coverity Scan's account e-mail.
    - `COVERITY_SCAN_TOKEN`: Your Coverity Scan's project token.

    Update the Coverity Scan badge in the [README.md](../README.md) file accordingly.
15. See the [development guide](./development_guide.md) to learn how to work with this template.
16. When modifying dependencies, update `.devcontainer/Dockerfile`, `.github` workflows, and `docs/install.md` accordingly.
