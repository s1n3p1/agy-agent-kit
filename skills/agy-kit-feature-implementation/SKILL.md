---
name: agy-kit-feature-implementation
description: Use when implementing a new feature or user-visible capability while preserving architecture, scope, tests, and existing behavior.
---

# Feature Implementation

1. Translate the request into concrete acceptance criteria.
2. Inspect the repository and nearest analogous implementation.
3. Identify affected layers, interfaces, data boundaries, and canonical commands.
4. Create a short plan only when dependent or cross-cutting steps justify it.
5. Implement the thinnest coherent end-to-end slice first.
6. Validate inputs and failure paths at boundaries.
7. Reuse existing patterns before adding abstractions or dependencies.
8. Add or update tests for changed behavior.
9. Verify the primary path plus relevant build/typecheck/lint/test checks.
10. Inspect the final diff and apply the global completion gate.
