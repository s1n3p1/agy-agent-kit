# Upstream integration sources

AGY Agent Kit does not vendor the recommended Google/Chrome integration repositories. The installer fetches them from upstream.

| Integration | Upstream repository | Primary installation path |
|---|---|---|
| Modern Web Guidance | https://github.com/GoogleChrome/modern-web-guidance | `agy plugin install` (documented by upstream) |
| Gemini API skills | https://github.com/google-gemini/gemini-skills | `agy plugin install` (documented by upstream) |
| Chrome DevTools | https://github.com/ChromeDevTools/chrome-devtools-mcp | AGY plugin import when supported; skill fallback otherwise |
| Google Antigravity SDK skill | https://github.com/Google-Antigravity/antigravity-sdk-python | AGY plugin import when supported; `skills/google-antigravity-sdk` fallback otherwise |
| Google Maps Platform skill | https://github.com/googlemaps/agent-skills | AGY plugin import when supported; `skills/google-maps-platform` fallback otherwise |

The Google Maps and Antigravity SDK repositories also document installation through the cross-agent `skills` CLI. AGY Agent Kit uses a deterministic copy fallback into `~/.gemini/config/skills/` instead, because that is the global skill discovery path used by Antigravity CLI installations this kit targets.

The Chrome DevTools repository contains an agent plugin manifest and skills. Its Antigravity documentation also describes using Chrome DevTools as a custom MCP server. AGY Agent Kit does not force an MCP configuration during fallback; it installs the skills only if AGY plugin import is unavailable.

Upstream projects retain their own licenses and terms.
