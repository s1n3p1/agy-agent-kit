# Coding and Software Quality

Load when source code is written, modified, reviewed, refactored, or tested.

- Inspect the current implementation and nearest analogous code before editing.
- Preserve public/user-visible behavior unless the request changes it.
- Prefer the smallest coherent patch.
- Avoid unrelated refactors and broad formatting churn.
- Reuse existing project patterns before adding abstractions.
- Prefer explicit types, validated boundaries, and error handling at the layer that can act on the error.
- Do not add a dependency for behavior already supported cleanly by the existing stack.
- Add or update tests when changed behavior warrants them.
- Run the narrowest relevant verification first, then broader checks when justified.
