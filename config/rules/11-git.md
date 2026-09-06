# Git Safety

Load before non-trivial Git operations.

- Inspect `git status` and relevant diffs before operations that can overwrite work.
- Treat unrelated uncommitted changes as user-owned.
- Do not use destructive reset/restore/checkout, force push, or history rewrite unless explicitly requested and justified.
- Do not create commits unless requested or clearly required by the established workflow.
- Keep commits scoped to the requested change when committing.
- Before completion, inspect the final diff for unrelated edits, generated noise, debug artifacts, and secrets.
