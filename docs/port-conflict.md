# 포트 충돌 진단과 해제

이 문서는 대응 절차이며 실제 포트 충돌을 새로 발생시킨 로그가 아니다. 서버 접속 실패만으로 포트 충돌을 확정하지 않는다. docker run/Compose가 address already in use 또는 port is already allocated를 표시하는지 먼저 확인한다.

## 1. Docker가 포트를 사용 중인지 확인

Ubuntu/WSL Bash에서:

```bash
docker ps --filter publish=8082 --format 'table {{.ID}}\t{{.Names}}\t{{.Ports}}'
docker compose ps
```

filter는 조건에 맞는 목록 조회, publish는 공개된 포트 조건이다. 이름과 포트 매핑을 확인한다. 조회만으로 컨테이너를 종료하지 않는다.

## 2. Linux 또는 Windows 프로세스 확인

Ubuntu에서 ss(socket statistics, 소켓 상태 조회):

```bash
sudo ss -ltnp 'sport = :8082'
```

- -l: listening, 연결을 기다리는 소켓.
- -t: TCP.
- -n: numeric, 주소·포트를 숫자로 표시.
- -p: process, 연결된 프로세스 표시.
- sport: source port, 여기서는 로컬 포트 조건.

WSL에서 빈 목록이어도 Windows 또는 Docker Desktop 측 점유까지 배제할 수 없다. Windows PowerShell에서는 다음을 조회한다.

```powershell
Get-NetTCPConnection -LocalPort 8082 -State Listen |
    Select-Object LocalAddress, LocalPort, OwningProcess
```

OwningProcess가 1234라고 확인된 경우에만 해당 숫자로 조회한다.

```powershell
Get-Process -Id 1234
```

1234는 예시 PID다. 실제 결과의 번호로 바꾼다. Docker Desktop 백엔드가 소유자라면 백엔드를 강제 종료하지 말고 Docker 목록에서 해당 컨테이너를 찾는다.

## 3. 확인한 대상의 정상 종료 또는 포트 변경

내가 만든 Compose web 서비스가 점유하고 있고 종료해도 되는 경우, compose.yaml 폴더에서:

```bash
docker compose stop web
```

별도로 실행한 실습 컨테이너라면 이름을 확인하고 `docker stop 확인한이름`으로 정지한다. 일반 프로그램은 해당 프로그램의 종료 기능을 우선 사용한다. Linux에서 자신이 관리하는 PID가 확인된 경우 `kill -TERM 확인한PID`로 정상 종료 신호를 보낼 수 있다. 시스템 프로세스나 불명확한 PID를 강제 종료하지 않는다.

종료할 수 없으면 compose.yaml의 `8082:8080`을 `8084:8080` 등 사용하지 않는 호스트 포트로 변경한다. NGINX 내부 포트 8080과 환경 변수는 유지한다.

```bash
docker compose up -d web
docker compose ps
curl --fail http://localhost:8084
```

포트를 해제했다면 처음의 프로세스·컨테이너 조회를 반복하고 기존 주소로 접속한다. 포트를 바꿨다면 브라우저 주소도 새 번호를 사용한다. Connection refused, 시간 초과, HTTP 403/404는 각각 서버 시작·경로/네트워크·HTTP 접근/파일 문제도 점검해야 하며 모두 포트 충돌은 아니다.

참고: [Docker 포트 공개](https://docs.docker.com/engine/network/port-publishing/).
