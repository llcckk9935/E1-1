# Docker 엔진 연결 점검 — 첫 실행

안내 명령: `docker info` (Windows PowerShell).

아래는 학습자가 제공한 실제 출력이다. 사용자 경로에서 사용자 이름만 `[USER]`로 마스킹했다.

```text
Client:
 Version:    29.9.2
 Context:    default
 Debug Mode: false
 Plugins:
  agent: Docker AI Agent Runner (Docker Inc.)
    Version:  v1.152.0
    Path:     C:\Users\[USER]\.docker\cli-plugins\docker-agent.exe
  ai: Docker AI Agent - Ask Gordon (Docker Inc.)
    Version:  v1.33.0
    Path:     C:\Users\[USER]\.docker\cli-plugins\docker-ai.exe
  buildx: Docker Buildx (Docker Inc.)
    Version:  v0.38.1
    Path:     C:\Users\[USER]\.docker\cli-plugins\docker-buildx.exe
  compose: Docker Compose (Docker Inc.)
    Version:  v5.6.1
    Path:     C:\Users\[USER]\.docker\cli-plugins\docker-compose.exe
  debug: Get a shell into any image or container (Docker Inc.)
    Version:  0.49.0
    Path:     C:\Users\[USER]\.docker\cli-plugins\docker-debug.exe
  desktop: Docker Desktop commands (Docker Inc.)
    Version:  4.98.0
    Path:     C:\Users\[USER]\.docker\cli-plugins\docker-desktop.exe
  dhi: CLI for managing Docker Hardened Images (Docker Inc.)
    Version:  v0.0.9
    Path:     C:\Users\[USER]\.docker\cli-plugins\docker-dhi.exe
  extension: Manages Docker extensions (Docker Inc.)
    Version:  v0.2.32
    Path:     C:\Users\[USER]\.docker\cli-plugins\docker-extension.exe
  init: Creates Docker-related starter files for your project (Docker Inc.)
    Version:  v1.4.1
    Path:     C:\Users\[USER]\.docker\cli-plugins\docker-init.exe
  mcp: Docker MCP Plugin (Docker Inc.)
    Version:  v0.44.2
    Path:     C:\Users\[USER]\.docker\cli-plugins\docker-mcp.exe
  model: Docker Model Runner (Docker Inc.)
    Version:  v1.2.9
    Path:     C:\Users\[USER]\.docker\cli-plugins\docker-model.exe
  offload: Docker Offload (Docker Inc.)
    Version:  v0.7.35
    Path:     C:\Users\[USER]\.docker\cli-plugins\docker-offload.exe
  pass: Docker Pass Secrets Manager Plugin (beta) (Docker Inc.)
    Version:  v0.3.2
    Path:     C:\Users\[USER]\.docker\cli-plugins\docker-pass.exe
  sandbox: "docker sandbox" is deprecated, use Docker Sandboxes instead (Docker Inc.)
    Version:  v0.13.0
    Path:     C:\Users\[USER]\.docker\cli-plugins\docker-sandbox.exe
  scout: Docker Scout (Docker Inc.)
    Version:  v1.27.0
    Path:     C:\Users\[USER]\.docker\cli-plugins\docker-scout.exe

Server:
failed to connect to the docker API at npipe:////./pipe/docker_engine; check if the path is correct and if the daemon is running: open //./pipe/docker_engine: The system cannot find the file specified.
```

## 판단과 다음 확인

Docker CLI 정보는 조회됐지만 Docker 엔진 연결은 실패했다. 현재 연결 대상은 default 컨텍스트의 docker_engine 파이프다. 파이프는 프로그램 사이의 통신 통로이며 앞서 학습한 셸의 `|`와 같은 문법을 뜻하는 것은 아니다.

Docker Desktop 최초 실행·엔진 시작 전일 가능성을 먼저 확인한다. 다른 연결 설정 문제도 가능하므로 오류만으로 원인을 확정하지 않는다. 조치와 재검증은 미실시다.

학습자는 CLI가 명령을 전달하고 엔진이 컨테이너를 관리한다고 정확히 설명했다. CLI가 Command Line Interface의 줄임말임을 추가 설명했다. 다음 단위는 사용자별 설치 경로의 Docker Desktop 앱을 실행하여 시작 화면을 확인하는 것이다. 앱 창이 열리는 사실만으로 엔진 정상 실행을 확정하지 않는다.

## Docker Desktop 최초 실행 — 학습자 보고

사용자별 설치 경로의 Docker Desktop 실행을 안내한 뒤 학습자는 창이 열려 Accept를 눌렀고, 이어 로그인 페이지가 나왔다고 보고했다. 이는 텍스트 보고이며 화면 캡처나 엔진 재점검 출력은 아직 제공되지 않았다. 로그인 성공이나 엔진 정상 실행을 기록하지 않는다. 다음은 화면에 건너뛰기 선택지가 있는지 확인하는 단계다.

## Docker Desktop 실행 후 재검증 — 실제 출력 발췌

학습자는 로그인 화면에서 Skip을 누르고 왼쪽 메뉴가 표시됐다고 보고했다. 이후 PowerShell에서 `docker info` 재실행을 안내했으며 아래 정상 출력을 제공받았다.

아래는 주요 항목 발췌다. Client의 Plugins 목록 및 Server의 일부 상세 항목은 생략했다. 사용자 경로와 엔진 ID는 이 발췌에 포함하지 않았다.

```text
Client:
 Version:    29.9.2
 Context:    desktop-linux
 Debug Mode: false

Server:
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 0
 Server Version: 29.9.2
 Storage Driver: overlayfs
  driver-type: io.containerd.snapshotter.v1
 Logging Driver: local
 Cgroup Driver: cgroupfs
 Cgroup Version: 2
```

같은 Server 출력의 실행 환경 항목:

```text
 Kernel Version: 6.18.54.1-microsoft-standard-WSL2
 Operating System: Docker Desktop
 OSType: linux
 Architecture: x86_64
 CPUs: 16
 Total Memory: 13.5GiB
 Name: docker-desktop
```

Client 플러그인 목록에서 compose v5.6.1 및 desktop 명령 플러그인 4.98.0도 표시됐다. 이는 해당 플러그인의 보고 버전이며 Compose 실습 수행 증거는 아니다.

### 재검증 판단

- 이전에는 default 컨텍스트에서 엔진 연결에 실패했고, 이번에는 desktop-linux에서 Server 정보가 반환됐다.
- Docker Desktop 실행·약관 동의·로그인 건너뛰기 후 엔진 응답을 확인했다. 앱 시작과 컨텍스트 변화가 함께 관찰됐으므로 한 요소만을 단독 원인으로 확정하지 않는다.
- CLI와 엔진의 보고 버전은 모두 29.9.2다. 커널과 OSType은 WSL 2 기반 Linux 컨테이너 환경과 일치한다.
- Containers 0, Images 0이므로 이번 결과는 엔진 응답 증거이며 컨테이너 실행 성공 증거는 아니다.
- 엔진의 Total Memory 13.5GiB는 Windows 호스트에서 조회한 약 27.7GiB와 구분한다.
- 이해도 확인: 학습자는 엔진이 응답했다는 근거가 있는 영역을 “server”라고 정확히 답했다.
