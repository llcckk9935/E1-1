# 실제 트러블슈팅 기록

실제로 관찰한 증상과 결과만 기록한다. 현재 4건에 대해 조치와 후속 검증 기록을 확보했다. 최종 README 연결과 제출 검토는 남아 있으며 모든 실습의 완료를 뜻하지 않는다.

## TS-01 WSL 설치 후 가상화 관련 실행 불가 안내

### 문제

WSL 설치 후 `wsl --status`에서 기본 버전이 2로 나오지만, 가상화가 활성화되지 않아 WSL 2를 시작할 수 없다는 안내가 표시됐다.

### 원인 가설

1. 설치 후 재시작하지 않아 Windows 기능 적용이 완료되지 않았을 가능성.
2. 가상 머신 플랫폼 또는 펌웨어 가상화 설정이 비활성화됐을 가능성.

출력만으로 펌웨어 설정 문제를 확정하지 않았다.

### 확인

학습자에게 설치 후 재시작 여부를 확인했고, “아직 다시 시작한 적은 없어”라는 답변을 받았다.

### 조치

열어둔 작업을 저장하고 Windows의 ‘다시 시작’을 수행하도록 안내했다. 학습자는 “재시작 완료”라고 보고했다. 펌웨어 설정 변경이나 추가 기능 활성화 명령을 실행했다는 기록은 없다.

### 재검증

학습자가 PowerShell에서 `wsl --status`를 다시 실행했다. 제공된 출력에서 WSL 2 가상화 관련 실행 불가 안내가 사라졌고 WSL 1 관련 안내는 남았다.

- [재시작 전후 명령과 실제 출력](../evidence/ch01/environment.md)
- [Microsoft 공식 문제 해결 안내](https://github.com/MicrosoftDocs/wsl/blob/main/WSL/troubleshooting.md)

### 결론과 한계

재시작 후 문제 안내가 사라지는 변화를 관찰했다. 원인 가설 1과 일치하는 결과이나 이때는 Ubuntu 설치·실행까지 확인한 것은 아니었다.

후속으로 배포판 목록이 비어 있음을 확인하고 Ubuntu를 지정 설치했다. 계정 설정 종료, 우분투 셸 진입, `cd ~`와 `pwd` 실행 및 `exit`로 PowerShell 복귀를 실제 출력으로 확인했다. 이어 `wsl --list --verbose` 결과의 Ubuntu 행에서 VERSION 2를 확인했다. 우분투 설치·기본 사용·WSL 2 등록까지 검증했으며, 이 결과를 다른 개발 도구 준비 완료로 확대하지 않는다.

## TS-02 Docker 명령을 찾을 수 없음 — 명령 실행 재검증 완료

### 문제

Windows PowerShell에서 `docker --version` 실행 시 `CommandNotFoundException`이 발생했다. [실제 오류 출력](../evidence/ch01/environment.md).

### 원인 가설

1. Docker Desktop 또는 Docker CLI가 설치되지 않았을 가능성.
2. 설치됐지만 명령 검색 경로(PATH)에 등록되지 않았거나 현재 PowerShell에 반영되지 않았을 가능성.

### 다음 확인

기본 설치 경로 `C:\Program Files\Docker\Docker\Docker Desktop.exe`의 존재를 `Test-Path`로 확인하도록 안내했고 학습자가 `false`라는 결과를 전달했다. 해당 경로에는 파일이 없으나, 다른 위치 설치나 CLI 단독 설치까지 배제하지 않는다. 결과 해석의 이해도 확인 후 다음 진단을 진행한다.

### 해결 및 재검증

미실시. 실제 확인 결과를 받은 뒤 해결 방법을 정하고 `docker --version`과 데몬 점검을 별도로 수행할 예정이다.

### 추가 확인

시작 메뉴 등록 앱의 이름에 Docker가 포함된 항목을 조회했으며 학습자가 출력 없음을 보고했다. 명령 미인식·기본 경로 부재·시작 메뉴 조회 결과를 확인했지만 다른 위치 설치까지 배제하지는 않았다. Docker Desktop 설치 준비로 WSL 프로그램 버전을 다음에 조회한다.

후속 확인에서 WSL 프로그램 버전 3.0.3.0, x64 시스템, 약 27.7GiB 메모리를 확인했다. 공식 문서에 별도의 사용자별 설치 경로도 명시되어 있어, 설치를 시작하기 전 해당 경로를 추가 확인할 예정이다.

사용자별 기본 설치 경로 `%LOCALAPPDATA%\Programs\DockerDesktop\Docker Desktop.exe` 확인 결과도 학습자가 `false`라고 전달했다. 두 기본 설치 경로 및 시작 메뉴에서 설치 흔적을 찾지 못했으나 임의 경로 설치까지 배제한 것은 아니다. 설치·해결·재검증은 아직 미실시다.

### 설치 조치 후 진행 상태

공식 배포 주소에서 설치 파일을 다운로드하고 파일 크기와 Docker Inc의 유효한 서명을 확인했다. 사용자별 설치 및 WSL 2 기반을 지정해 설치 프로그램을 실행하도록 안내했다. 학습자가 제공한 로그의 2026-11-04T00:10:53Z `Installation succeeded`로 설치 성공 보고를 확인했다.

설치 성공 메시지 확인 시점에는 명령 미인식 해결 여부가 미검증이었다. 이어 새 PowerShell 창에서 재검증하도록 안내했다.

### 최종 재검증

학습자가 제공한 실제 출력:

```text
Docker version 29.9.2, build a82e528
```

명령 미인식 증상이 사라지고 Docker CLI가 실행됨을 확인했다. 설치와 새 셸 실행을 함께 수행했으므로 하나만을 단독 원인으로 확정하지 않는다. 최초에 임의 경로까지 설치 여부를 조사한 것은 아니다. 학습자는 새 셸 실행 이유를 설치 후 PATH 반영이라고 설명했다.

해결 범위는 Docker 명령 실행과 버전 확인이다. Docker Desktop 최초 실행·데몬 응답·컨테이너 실행은 별도 후속 검증 항목이다.

## TS-03 Docker CLI는 실행되지만 엔진 연결 실패 — 엔진 응답 재검증 완료

- 증상: `docker info`에서 Client 정보는 나오지만 Server에서 docker_engine 파이프에 연결할 수 없다는 오류 발생.
- [실제 출력](../evidence/ch01/docker-info.md).
- 가설: Docker Desktop이 아직 실행되지 않았거나 엔진 준비가 끝나지 않았을 가능성. 연결 대상 설정 문제도 배제하지 않는다.
- 다음 확인: Docker Desktop 최초 실행 여부와 시작 화면 확인 후 엔진 응답 재검증.
- 해결·재검증: 아직 미실시. CLI가 정상 실행된다는 사실로 엔진 실행 성공을 기록하지 않는다.

### 후속 조치와 실제 재검증

사용자별 설치 경로에서 Docker Desktop 앱을 실행하도록 안내했다. 학습자는 창 열림, Accept 선택, 로그인 화면의 Skip 선택 및 메인 메뉴 표시를 보고했다. 이후 `docker info` 재실행 실제 출력에서 Client와 Server 정보가 정상 반환됐다.

- 이전: default 컨텍스트에서 docker_engine 연결 오류.
- 이후: desktop-linux 컨텍스트에서 Server Version 29.9.2, OSType linux, WSL2 커널 정보 반환.
- [실제 출력 발췌와 해석](../evidence/ch01/docker-info.md).

앱 실행과 연결 대상 변화가 함께 관찰됐으므로 원인을 앱 미실행 하나로만 확정하지 않는다. 엔진 응답을 확인해 연결 실패 증상의 해소를 검증했다. 이미지와 컨테이너는 각각 0이므로 실제 컨테이너 실행까지 검증한 것은 아니다.

## TS-04 WSL Integration과 소켓 권한 오류 — 연결 재검증 완료

- 증상: 우분투에서 실행하도록 안내한 docker info의 후속 출력에서 해당 WSL 2 배포판에 docker 명령이 없으며 WSL Integration 활성화를 권하는 Server 오류가 발생했다.
- [실제 오류 발췌](../evidence/ch01/environment.md).
- 가설: 배포판의 WSL 연결 설정 문제 가능성. 다만 Client 플러그인 경로가 Windows 형식이므로 명령을 실행한 셸과 실제 CLI 경로도 확인 필요.
- 다음 확인: 같은 창에서 uname -s 실행. Linux 환경 확인 후 필요한 경우 Docker Desktop Settings > Resources > WSL Integration 점검.
- 조치·재검증: 미실시. 앞선 PowerShell 정상 응답을 이번 우분투 연결 성공으로 대신하지 않는다.
- [공식 WSL 연결 안내](https://docs.docker.com/desktop/features/wsl/).

후속 확인: 학습자는 같은 창에서 uname -s 실행 결과가 Linux라고 보고했다. 다음은 WSL Integration 화면의 Ubuntu 설정 상태 확인이다. Docker CLI 경로·설정 변경·연결 복구는 아직 미검증이다.

설정 확인 결과: 학습자는 Ubuntu 연결 스위치가 꺼져 있다고 보고했다. 연결 비활성화 가설을 뒷받침하므로 Ubuntu 연결 활성화·적용을 다음 조치로 안내한다. 변경 결과와 엔진 연결 재검증은 대기 중이다.

### 연결 적용 후: 소켓 접근 권한 오류로 변화

학습자가 설정 완료를 보고했다. 후속 docker info에서 플러그인 경로가 `/usr/local/lib/docker/cli-plugins/`로 표시됐고 Server 오류가 `permission denied while trying to connect to the docker API at unix:///var/run/docker.sock`로 바뀌었다.

WSL 연결 설정 후 다른 오류로 진행한 것이며 전체 연결 복구로 기록하지 않는다. 현재 사용자의 그룹 또는 소켓 접근 권한 문제를 가설로 두고 우선 `id`, 이후 소켓 소유자·그룹·권한을 확인할 예정이다. 아직 사용자의 그룹 누락으로 확정하지 않았으며 권한 변경도 수행하지 않았다.

id 후속 출력에서 uid/gid 1000 및 현재 세션 그룹에 docker가 없는 것을 확인했다. 다음은 `ls -l /var/run/docker.sock`으로 소켓 소유 그룹과 권한을 확인한다. 계정의 그룹 등록 여부나 세션 갱신 문제는 아직 미확정이다.

### 그룹 정보 비교 결과

getent group docker 결과에서 그룹 번호 1001과 학습자 계정의 구성원 등록을 확인했다. id의 현재 세션 그룹에는 docker가 없으므로 그룹 미등록이 아니라 세션 미반영 상태라는 판단을 뒷받침한다. 그룹을 중복 추가하지 않고 newgrp docker로 새 셸을 시작한 뒤 연결을 검증할 예정이다. [실제 출력 비교](../evidence/ch01/docker-group-session.md). 아직 이 조치와 엔진 응답은 미검증이다.

### 시도한 조치의 실패와 대안

newgrp 실행은 명령 없음 오류로 실패했다. 화면은 `sudo apt install util-linux-extra`를 제안했으나 해당 설치는 실행하지 않았다. 로그아웃·재진입으로 그룹 정보를 갱신하는 대안을 안내한다. 현재는 exit로 우분투 셸을 종료하는 단계이며 재진입·그룹·연결 재검증은 대기 중이다.

### 최종 조치와 재검증

로컬 Git 학습 후 우분투 exit, PowerShell에서 wsl -d Ubuntu로 재진입하도록 안내했다. 시작 메시지와 후속 docker info의 실제 Server 정상 정보(버전 29.9.2, 컨테이너·이미지 각각 0)를 제공받았다. 이전 permission denied 오류가 사라져 우분투 엔진 연결 복구를 검증했다. [그룹 비교·재진입·정상 응답 증거](../evidence/ch01/docker-group-session.md).

계정 등록과 이전 세션의 차이에 근거해 재진입했고 그룹 중복 추가나 소켓 권한 완화를 수행하지 않았다. 재진입 후 id 출력은 수집하지 않았으므로 생성하지 않는다.

## TS-05 컨테이너 입력 줄에서 한글이 숫자로 표시 — 원인 미확정

- 관찰: echo 입력 줄은 백슬래시·숫자로 표시됐으나 cat으로 읽은 실제 파일 내용은 정상 한글이었다. [관찰 기록](../evidence/ch05/docker.md).
- 가설: Bash의 입력 줄 표시 또는 컨테이너의 문자 처리 설정 문제 가능성. 파일 내용 손상으로 확정하지 않는다.
- 근거 자료: [GNU Bash Readline 설정](https://www.gnu.org/software/bash/manual/html_node/Readline-Init-File-Syntax.html)은 문자 표시 설정과 LC_CTYPE의 관계를 설명한다. 이 문서만으로 현재 컨테이너의 실제 설정값을 확인한 것은 아니다.
- 확인 계획: 필요하면 컨테이너 내부 locale와 입력 줄 설정 확인. 현재는 사용자가 컨테이너에서 나왔으므로 추가 진단을 보류한다.
- 조치·재검증: 미실시. 해결 건수에 포함하지 않는다.

소켓 조회 결과는 `srw-rw---- 1 root docker 0 Nov  4 11:33 /var/run/docker.sock`이다. 소유자 root와 그룹 docker만 rw 권한이 있어 현재 세션의 그룹과 비교하면 거부 원인에 부합한다. 저장된 docker 그룹 구성원을 `getent group docker`로 조회한 뒤 세션 미반영과 계정 미등록을 구분할 예정이다. 아직 그룹 등록·세션 갱신·엔진 재검증은 미실시다.
