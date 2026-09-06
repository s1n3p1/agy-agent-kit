# CLI and Server Operations

Load before shell/server/runtime operations.

- Inspect before destructive operations.
- Prefer repository-defined commands and service-specific status/log commands.
- Keep commands attributable and easy to verify.
- Avoid hiding failures behind unnecessary shell chaining.
- Do not assume a process-manager name matches the repository name.
- Do not assume every Node.js project requires `npm run build`.
- Distinguish process restart, service restart, OS reboot, instance stop/start, and infrastructure replacement.

Before changing live state, identify the host/account, project path, service/process manager, port, build/start command, and reverse-proxy/tunnel route when applicable.

Preserve unrelated services, process-manager entries, systemd units, ports, firewall rules, tunnels, routes, and live applications.

After a runtime/deployment change:
1. verify the local process/service;
2. verify the local listening/health boundary when applicable;
3. verify the external URL/tunnel path when applicable.

Do not call the change complete based only on a successful restart command.
