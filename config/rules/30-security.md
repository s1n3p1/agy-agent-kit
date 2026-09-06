# Security and Irreversible Operations

Load for secrets, authentication, credentials, destructive data/infrastructure actions, or public exposure changes.

- Never expose or persist passwords, API keys, tokens, private keys, cookies, session credentials, tunnel credentials, or authentication material.
- Do not commit real secrets or copy them into logs, examples, rules, skills, or memory.
- Do not weaken authentication, authorization, validation, TLS, or access controls merely to make a task pass.
- Prefer reversible changes for stateful systems and live infrastructure.
- Inspect impact and rollback before deletion, migration with data loss, public exposure, firewall changes, database destruction, or infrastructure replacement.
- If authorization for a materially irreversible action is unclear, obtain confirmation before executing it.
