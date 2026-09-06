# AGY Agent Kit

Defensive global rules and reusable development skills for **Google Antigravity CLI (`agy`)**.

The kit assumes that an agent can forget instructions, skip a useful skill, infer too much from incomplete evidence, or declare work complete before verification. It keeps the critical rules always loaded and routes longer task-specific rules and skills only when needed.

## Install

Requirements: macOS or Linux, `agy`, `curl`, and a normal POSIX shell. `git` is recommended for fallback installation of upstream skills.

```bash
curl -fsSL https://raw.githubusercontent.com/s1n3p1/agy-agent-kit/main/install.sh | bash
```

Core rules and skills only, without the recommended upstream plugins/skills:

```bash
curl -fsSL https://raw.githubusercontent.com/s1n3p1/agy-agent-kit/main/install.sh | bash -s -- --no-plugins
```

After installation, **start a new `agy` session** so the runtime discovers the new configuration.

## What it installs

### Always-loaded global policy

The installer adds one clearly marked AGY Agent Kit block to `~/.gemini/GEMINI.md` instead of replacing the user's existing file. If these shared instruction files already exist, the block imports them too:

- `~/.agents/AGENTS.md`
- `~/AGENTS.md`

The always-loaded block contains the core behavior, evidence requirements, repository-first policy, explicit rule router, skill router, and completion gate.

### Situational rules

Installed under `~/.gemini/config/agy-agent-kit/rules/`:

- session and scope discipline
- CLI/server operations
- Git safety
- coding quality
- technology/version handling
- security and irreversible operations
- Korean output guidance
- durable memory guidance

### Core skills

Installed under `~/.gemini/config/skills/` with namespaced names to avoid collisions:

- `agy-kit-bug-investigation`
- `agy-kit-feature-implementation`
- `agy-kit-frontend-ui`
- `agy-kit-refactor`
- `agy-kit-research`
- `agy-kit-server-ops`

### Recommended upstream integrations

By default, the installer also attempts to install or enable five useful Google/Chrome integrations from their upstream repositories:

- Chrome DevTools
- Modern Web Guidance
- Gemini API skills
- Google Antigravity SDK skill
- Google Maps Platform skill

Where an upstream repository is directly installable as an AGY plugin, the installer uses `agy plugin install`. If that is unavailable for a skills-only repository, it falls back to copying the upstream skill into Antigravity's global skill directory.

Existing unrelated plugins, skills, settings, authentication state, caches, and built-ins are not removed.

## Philosophy

The configuration uses three layers:

1. **Always loaded:** compact non-negotiable rules in `GEMINI.md`.
2. **On demand:** explicit task routing to longer rule files.
3. **Procedural:** skills for recurring engineering workflows.

This deliberately does not require a `GEMINI.md` or `.agents/` directory in every project.

## Verify

```bash
curl -fsSL https://raw.githubusercontent.com/s1n3p1/agy-agent-kit/main/verify.sh | bash
```

Then open a new AGY session and ask it to report the global rule files and custom skills discovered by the current runtime.

## Update

Run the same installation command again. The installer is intended to be idempotent and replaces only files managed by AGY Agent Kit.

## Uninstall

```bash
curl -fsSL https://raw.githubusercontent.com/s1n3p1/agy-agent-kit/main/uninstall.sh | bash
```

Uninstall removes only the AGY Agent Kit marker block, routed rule directory, and six namespaced core skills. Upstream plugins/skills are intentionally left installed because they may also be used independently.

## Backups

Before changing managed configuration, the installer writes timestamped backups under:

```text
~/.gemini/agy-agent-kit-backups/
```

## Notes

- AGY Agent Kit does not install Antigravity CLI itself.
- It does not modify Codex, Claude Code, or other agent configuration files.
- It does not create project-local AI configuration by default.
- Hooks are intentionally not enabled yet; mechanical enforcement should be added only after safe hook behavior is validated across AGY versions.

## License

MIT
