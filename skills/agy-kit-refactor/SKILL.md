---
name: agy-kit-refactor
description: Use for cleanup, extraction, reorganization, or maintainability work where behavior and public contracts should remain unchanged.
---

# Refactor

1. Define the behavior/contracts that must remain invariant.
2. Locate existing tests; add characterization coverage when risk justifies it.
3. Refactor in small, reviewable steps.
4. Keep behavior changes separate unless explicitly requested.
5. Avoid dependency churn and public renames without need.
6. Run focused tests after meaningful boundary changes.
7. Remove dead code only after establishing that it is unused.
8. Compare final behavior/configuration surfaces and apply the global completion gate.
