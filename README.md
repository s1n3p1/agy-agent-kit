# AGY Agent Kit

**Google Antigravity CLI (`agy`)**를 위한 방어적인 전역 규칙과 재사용 가능한 개발 Skill 모음입니다.

이 Kit은 에이전트가 지침을 잊거나, 유용한 Skill을 건너뛰거나, 불완전한 근거만 보고 과도하게 추론하거나, 충분한 검증 없이 작업이 끝났다고 판단할 수 있다는 전제에서 설계했습니다. 꼭 필요한 핵심 규칙은 항상 로드하고, 길고 상황별로 필요한 규칙과 Skill은 해당 작업에서만 불러오도록 구성합니다.

## 설치

요구사항: macOS 또는 Linux, `agy`, `curl`, 일반적인 POSIX shell. Upstream Skill의 fallback 설치를 위해 `git` 사용을 권장합니다.

```bash
curl -fsSL https://raw.githubusercontent.com/s1n3p1/agy-agent-kit/main/install.sh | bash
```

추천 upstream plugin/skill 없이 핵심 규칙과 Skill만 설치하려면:

```bash
curl -fsSL https://raw.githubusercontent.com/s1n3p1/agy-agent-kit/main/install.sh | bash -s -- --no-plugins
```

설치 후에는 runtime이 새 설정을 발견할 수 있도록 **새 `agy` 세션을 시작하세요.**

## 설치되는 항목

### 항상 로드되는 전역 정책

설치기는 사용자의 기존 `~/.gemini/GEMINI.md`를 통째로 덮어쓰지 않고, AGY Agent Kit가 관리하는 구분된 block 하나만 추가합니다. 아래 공용 지침 파일이 이미 존재하면 해당 block에서 함께 import합니다.

- `~/.agents/AGENTS.md`
- `~/AGENTS.md`

항상 로드되는 block에는 핵심 행동 규칙, evidence 요구사항, repository-first 정책, 명시적 Rule router, Skill router, completion gate가 포함됩니다.

### 상황별 Rule

다음 경로에 설치됩니다.

```text
~/.gemini/config/agy-agent-kit/rules/
```

포함 내용:

- 세션 및 작업 범위 관리
- CLI/서버 운영
- Git 안전 규칙
- 코딩 품질
- 기술 스택 및 버전 처리
- 보안 및 되돌리기 어려운 작업
- 한국어 출력 가이드
- 장기 기억 관리 가이드

### 핵심 Skill

다른 Skill과 이름이 충돌하지 않도록 namespace를 붙여 `~/.gemini/config/skills/` 아래에 설치합니다.

- `agy-kit-bug-investigation`
- `agy-kit-feature-implementation`
- `agy-kit-frontend-ui`
- `agy-kit-refactor`
- `agy-kit-research`
- `agy-kit-server-ops`

### 추천 Upstream Integration

기본 설치에서는 Google/Chrome의 공식 upstream repository에서 유용한 Integration 5종도 설치하거나 활성화합니다.

- Chrome DevTools
- Modern Web Guidance
- Gemini API Skills
- Google Antigravity SDK Skill
- Google Maps Platform Skill

Upstream repository가 AGY plugin으로 직접 설치 가능한 경우 `agy plugin install`을 사용합니다. Skill만 제공하는 repository 등에서 plugin 설치가 지원되지 않으면 해당 upstream Skill을 Antigravity의 전역 Skill 경로로 복사하는 fallback 방식을 사용합니다.

기존에 사용자가 설치한 다른 plugin, Skill, 설정, 인증 상태, cache, built-in 파일은 삭제하지 않습니다.

## 설계 철학

설정은 세 계층으로 구성됩니다.

1. **Always loaded:** `GEMINI.md`에 들어가는 짧고 반드시 지켜야 하는 핵심 규칙
2. **On demand:** 작업 종류에 따라 명시적으로 routing되는 상세 Rule
3. **Procedural:** 반복되는 개발 작업 절차를 담당하는 Skill

Gemini가 항상 필요한 규칙과 Skill을 스스로 정확하게 선택할 것이라고 가정하지 않습니다. 대신 최소한의 핵심 정책은 항상 주입하고, 나머지는 명시적인 routing과 progressive disclosure로 필요한 순간에만 불러옵니다.

또한 모든 프로젝트마다 `GEMINI.md`나 `.agents/` 디렉터리를 만들어야 하는 구조를 사용하지 않습니다.

## 검증

```bash
curl -fsSL https://raw.githubusercontent.com/s1n3p1/agy-agent-kit/main/verify.sh | bash
```

그다음 새 AGY 세션을 열고, 현재 runtime이 발견한 global Rule 파일과 custom Skill을 직접 확인하면 됩니다.

## 업데이트

설치 명령을 다시 실행하면 됩니다.

```bash
curl -fsSL https://raw.githubusercontent.com/s1n3p1/agy-agent-kit/main/install.sh | bash
```

설치기는 반복 실행해도 같은 결과가 나오도록 구성했으며, AGY Agent Kit가 관리하는 파일만 교체합니다.

## 제거

```bash
curl -fsSL https://raw.githubusercontent.com/s1n3p1/agy-agent-kit/main/uninstall.sh | bash
```

제거 스크립트는 AGY Agent Kit marker block, 상황별 Rule 디렉터리, namespace가 붙은 핵심 Skill 6개만 제거합니다. Upstream plugin/skill은 AGY Agent Kit와 별개로 사용할 수도 있으므로 의도적으로 남겨둡니다.

## 백업

관리 대상 설정을 변경하기 전에 기존 파일을 timestamp별로 다음 경로에 백업합니다.

```text
~/.gemini/agy-agent-kit-backups/
```

## 참고

- AGY Agent Kit 자체는 Antigravity CLI를 설치하지 않습니다.
- Codex, Claude Code 등 다른 에이전트의 설정 파일은 수정하지 않습니다.
- 기본적으로 프로젝트별 AI 설정 파일을 생성하지 않습니다.
- Hook은 아직 활성화하지 않습니다. Hook을 통한 기계적 강제는 AGY 버전 간 동작을 충분히 검증한 뒤 추가하는 것이 안전합니다.

## 라이선스

MIT
