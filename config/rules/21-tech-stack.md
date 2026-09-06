# Technology Stack and Versions

Load for dependency/framework/version changes or version-sensitive APIs.

## Source priority

1. Repository lockfile and dependency manifest.
2. Framework/runtime configuration in the repository.
3. Repository documentation.
4. Installed product documentation.
5. Current official upstream documentation when network access is allowed.

## Rules

- Do not upgrade a dependency merely because a newer version exists.
- Do not mix APIs from another major version.
- Verify compatibility before adding a core dependency.
- Prefer built-in framework/runtime capabilities before introducing overlapping libraries.
- For version-sensitive behavior, capture the actual installed/repository version before concluding.
