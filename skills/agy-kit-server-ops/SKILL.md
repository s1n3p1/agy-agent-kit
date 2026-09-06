---
name: agy-kit-server-ops
description: Use for Linux server operations, process managers, systemd, ports, reverse proxies, tunnels, deployments, service recovery, logs, and runtime verification.
---

# Server Operations

1. Apply the CLI/server, evidence, security, and completion rules as applicable.
2. Identify host, service, process manager, port, runtime user, and project path.
3. Inspect current state before restart, delete, replace, or reconfigure actions.
4. Prefer service-specific status/log commands before broad system changes.
5. Preserve unrelated processes, routes, ports, firewall rules, tunnels, and services.
6. Capture current configuration before modifying stateful infrastructure.
7. Distinguish process restart, service restart, OS reboot, instance stop/start, and infrastructure replacement.
8. Inspect the repository's actual build/start process instead of assuming commands or process names.
9. Verify locally first, then verify the external URL/tunnel path when applicable.
10. Apply the global completion gate before reporting success.
