# 챕터 5 — Docker 이미지와 컨테이너

## 시작 상태

우분투 재진입 후 Docker Server 29.9.2의 정상 응답을 확인했다. 이때 컨테이너·이미지는 모두 0이다. [실제 재검증 출력](../ch01/docker-group-session.md).

## 첫 컨테이너 실행 — 안내 단계

다음은 우분투에서 docker run hello-world로 테스트 컨테이너를 실행하는 실습이다. 아직 실제 출력이나 실행 성공은 기록하지 않는다.

## hello-world 실행 — 실제 제공 출력

안내 명령:

```bash
docker run hello-world
```

학습자가 제공한 실제 출력:

```text
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
4f55086f7dd0: Pull complete
d5e71e642bf5: Download complete
Digest: sha256:c567b231f65614688711a75f31518a064258a51d442117a3e771a3a8fdba78ef
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/get-started/
```

로컬 이미지가 없어 다운로드한 뒤 hello-world 프로그램의 메시지가 반환됨을 확인했다. 첫 줄만으로 실패라고 해석하지 않는다. 출력 속 Ubuntu 실행 예시는 프로그램 안내이며 이번에 실행한 명령은 아니다. 컨테이너 종료 상태·목록은 아직 별도 조회 전이다.

다음은 docker images로 저장된 이미지 목록 확인이다.

## 이미지 목록 — 실제 제공 출력

docker images 안내 후 실제 출력:

```text
i Info →   U  In Use
IMAGE                ID             DISK USAGE   CONTENT SIZE   EXTRA
hello-world:latest   c567b231f656       25.9kB         9.49kB    U
```

hello-world:latest 이미지와 짧은 ID, 저장 공간 정보가 표시됐다. U는 사용 중인 이미지라는 표시이며 컨테이너가 현재 실행 중인지 이 출력만으로 확정하지 않는다. 다음은 docker ps -a로 종료된 컨테이너를 포함한 목록과 상태를 확인하는 것이다. 아직 결과는 제공되지 않았다.

## 컨테이너 전체 목록 — 실제 제공 출력

docker ps -a 안내 후 실제 출력:

```text
CONTAINER ID   IMAGE         COMMAND    CREATED         STATUS                     PORTS     NAMES
121cbcd88298   hello-world   "/hello"   4 minutes ago   Exited (0) 4 minutes ago             affectionate_pascal
```

hello-world 이미지로 만든 컨테이너 121cbcd88298, 이름 affectionate_pascal을 확인했다. Exited (0)은 프로그램이 종료 코드 0으로 끝났음을 나타내며 이번 성공 메시지와 함께 정상 종료로 해석한다. 컨테이너의 프로그램이 끝나도 컨테이너 항목과 이미지는 남아 있다는 점을 실제 목록으로 확인했다.

다음은 docker logs affectionate_pascal로 종료된 컨테이너 출력을 조회하는 것이다. 아직 logs 결과는 제공되지 않았다.

## 실행 환경과 현재 경로 구분

학습자는 기존 workshop/archive 작업이 컨테이너 내부였는지와 현재 /mnt/c/Users 아래 프롬프트의 의미를 질문했다. 기존 파일 실습은 WSL Ubuntu Bash이며 hello-world 출력이 표시된 것만으로 컨테이너에 셸 진입한 것은 아니라고 설명했다.

현재 프롬프트는 학습자가 제공한 Windows 사용자 폴더 경로이며, 제출 기록에서는 사용자 이름을 마스킹한다.

```text
[USER]@[HOST]:/mnt/c/Users/[WINDOWS_USER]$
```

/mnt/c는 우분투에서 Windows C 드라이브에 접근하는 위치다. 실행 환경과 현재 폴더는 구분하며, 현재 Docker 로그 조회는 파일 경로가 아니라 엔진이 관리하는 컨테이너 이름을 대상으로 한다. 학습자는 설명을 듣고 이해했다고 응답했다. 아직 docker logs 출력은 받지 않았다.

## 종료된 컨테이너 로그 — 실제 제공 출력 발췌

docker logs affectionate_pascal 안내 후 학습자가 전체 로그를 제공했다. 아래는 핵심 부분의 실제 발췌이며 뒤의 Docker 계정·Ubuntu 실행 예시 안내는 생략했다.

```text
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.
```

종료된 컨테이너의 저장된 출력을 조회한 것을 확인했다. logs로 컨테이너를 새로 만들거나 다시 실행한 것은 아니다. 다음은 이름을 지정한 우분투 컨테이너를 새로 생성하고 대화형 Bash로 진입하는 실습이다. 아직 Ubuntu 이미지 다운로드·컨테이너 진입은 확인하지 않았다.

## 학습 속도 조정과 Ubuntu 실습 준비

여러 옵션의 Ubuntu 컨테이너 실행 명령은 학습자가 목적·용어 이해가 어렵다고 밝혀 보류했다. 이미지 보관과 프로그램 실행을 구분하고 hello-world가 작동 확인용 프로그램임을 다시 설명했다. 이후 학습자가 진행을 요청했다. 최종 자기 설명은 추후 실제 사례와 함께 확인한다.

다음은 docker pull ubuntu로 Ubuntu 이미지만 받는 단계다. 이후 컨테이너를 만들고 그 안에서 ls·echo를 사용하는 실습으로 연결한다. 현재 단계에서는 이미지 다운로드 성공이나 컨테이너 생성·진입을 기록하지 않는다.

## Ubuntu 이미지 다운로드 — 실제 제공 출력

docker pull ubuntu 안내 후 실제 출력:

```text
Using default tag: latest
latest: Pulling from library/ubuntu
f3f25b84a7d7: Pull complete
edafa32f5d9e: Pull complete
21594acc2d8b: Download complete
Digest: sha256:6a06111c3b0a8600feadb270aec771dc239bf407b25625f93f44ab00e11f4d3c
Status: Downloaded newer image for ubuntu:latest
docker.io/library/ubuntu:latest
```

Ubuntu 이미지 다운로드 완료를 실제 출력으로 확인했다. pull은 컨테이너를 생성·실행하는 명령이 아니다. 다음은 이미 배운 이미지 목록과 전체 컨테이너 목록을 조회해 Ubuntu가 어떤 목록에 생겼는지 비교하는 실습이다. 이 비교의 실제 출력과 Ubuntu 컨테이너 생성·진입은 아직 미확인이다.

## 다운로드와 실행 구분 확인 — 학습자 보고

docker images와 docker ps -a를 비교하도록 안내한 뒤 학습자는 Ubuntu가 첫째 목록인 이미지 목록에 나온다고 답했다. 목록 원문은 제공되지 않았으므로 만들어 기록하지 않는다.

다음은 `docker run -it ubuntu bash`로 Ubuntu 이미지에서 새 컨테이너를 만들고 Bash에 입력하는 실습이다. 초기 제안의 이름 지정 옵션은 개념 부담을 줄이기 위해 이번 명령에서 제외한다. -i의 입력 유지, -t의 가상 터미널, ubuntu 이미지, bash 프로그램의 역할을 설명한 뒤 실행하도록 안내한다. 실제 생성·진입 결과는 아직 받지 않았다.

## Ubuntu 컨테이너 Bash 진입 — 실제 제공 프롬프트

docker run -it ubuntu bash 안내 후 학습자가 제공한 프롬프트:

```text
root@c790b20e9cb0:/#
```

새 컨테이너의 Bash에 진입한 것으로 확인했다. 사용자는 컨테이너 내부 root, 호스트 이름 표시는 c790b20e9cb0, 현재 디렉토리는 /다. Docker ps로 ID를 별도 조회한 것은 아직 아니므로 프롬프트 표시와 구분한다. 이 프롬프트는 WSL의 기존 사용자·workshop 경로와 다르다. 아직 컨테이너 내부 실습 명령의 출력은 받지 않았다.

다음은 현재 컨테이너 Bash에서 ls로 /의 파일·폴더 목록 확인이다. 현재 root 계정은 컨테이너 내부 사용자이며 Windows 관리자 계정을 뜻하지 않는다.

## 컨테이너 내부 ls — 실제 제공 출력

컨테이너 프롬프트에서 ls 안내 후 실제 출력:

```text
bin   dev  home  lib64  mnt  proc  run   srv  tmp  var
boot  etc  lib   media  opt  root  sbin  sys  usr
```

컨테이너 내부 /에서 기본 폴더 목록을 확인했다. 다음은 /tmp/container-note.txt에 echo로 메모를 저장하고 cat으로 읽는 실습이다. 이 파일은 현재 컨테이너 안에 만들 예정이며 기존 WSL workshop의 notes.txt와 구분한다. 파일 생성·내용은 아직 실제 결과를 받지 않았다.

## 컨테이너 내부 echo·cat — 실제 제공 출력 발췌

학습자는 root@c790b20e9cb0 프롬프트에서 echo로 저장하는 줄과 아래 cat 실행 결과를 제공했다. 입력한 문장이 echo 줄에서는 백슬래시와 숫자의 이스케이프 형태로 보였지만, 실제 cat 출력은 한글 문장이었다. 별도 인코딩 오류를 확인한 것은 아니므로 새로운 장애로 기록하지 않는다.

```text
root@c790b20e9cb0:/# cat /tmp/container-note.txt
컨테이너에서 만든 첫 메모
```

컨테이너 내부에서 파일 생성과 내용 조회를 수행한 결과를 확인했다. 다음은 exit로 현재 Bash를 종료하고 WSL 프롬프트로 돌아오는 것을 확인하는 실습이다. 이 컨테이너는 Bash를 주 프로그램으로 실행했으므로 셸 종료 뒤 실행 상태를 별도로 조회할 예정이다. 아직 종료·삭제를 실행한 것으로 기록하지 않는다.

## 컨테이너에서 나온 뒤 프롬프트 — 실제 제공 정보

학습자는 다시 아래 프롬프트로 이동했다고 보고했다. 사용자·컴퓨터 이름은 마스킹했다.

```text
[USER]@[HOST]:/mnt/c/Users/[WINDOWS_USER]$
```

현재 명령을 전달하던 WSL Ubuntu로 복귀했다. 컨테이너 종료 상태는 아직 목록으로 조회하지 않았으며 다음은 docker ps -a 확인이다. 컨테이너나 내부 메모 파일을 삭제한 것으로 기록하지 않는다.

중간에 학습자가 echo 입력 줄에서 한글이 백슬래시·숫자로 표시되는 이유를 질문했다. cat의 한글 출력은 정상이므로 입력 줄 표시·문자 처리 설정 문제 가능성을 설명하고 locale 확인을 검토했지만, 현재 컨테이너에서 이미 나왔으므로 해당 명령은 안내·실행하지 않았다. 원인은 미확정이며 다음 컨테이너 진입 시 필요하면 확인한다.

## 컨테이너에서 나온 후 전체 목록 — 실제 제공 출력

docker ps -a 안내 후 실제 출력:

```text
CONTAINER ID   IMAGE         COMMAND    CREATED        STATUS                    PORTS     NAMES
c790b20e9cb0   ubuntu        "bash"     2 hours ago    Exited (2) 2 hours ago              distracted_goodall
121cbcd88298   hello-world   "/hello"   19 hours ago   Exited (0) 19 hours ago             affectionate_pascal
```

Ubuntu 컨테이너 ID와 이름 distracted_goodall 및 종료 상태를 확인했다. 학습자도 종료됐다고 답했다. Ubuntu의 종료 코드가 2로 보고됐으므로 0과 같은 정상 성공 코드로 기록하지 않는다. 원인은 목록만으로 확정하지 않으며 실제 exit 입력 줄·직전 명령 결과는 미제공이다.

컨테이너가 삭제되지 않고 종료된 상태로 남았음을 확인했다. 다음은 docker start distracted_goodall로 같은 컨테이너를 다시 시작하는 실습이다. 시작 성공·실행 중 상태·재연결·메모 유지 여부는 아직 검증 전이다.

## 기존 컨테이너 시작 요청 — 실제 제공 결과

docker start distracted_goodall 안내 후 학습자는 다음 이름이 반환됐고 현재 우분투 Bash에 있다고 보고했다.

```text
distracted_goodall
```

명령이 컨테이너 이름을 반환한 결과와 WSL 셸에 남아 있다는 보고를 기록한다. 현재 실행 중 상태는 아직 별도 조회 전이다. 다음은 docker ps로 실행 중인 컨테이너 목록 확인이다.

## 재시작 후 실행 중 목록 — 실제 제공 출력

docker ps 안내 후 실제 출력:

```text
CONTAINER ID   IMAGE     COMMAND   CREATED       STATUS              PORTS     NAMES
c790b20e9cb0   ubuntu    "bash"    2 hours ago   Up About a minute             distracted_goodall
```

같은 ID c790b20e9cb0과 이름의 Ubuntu 컨테이너가 Up 상태로 표시돼 재시작 후 실행 중임을 검증했다. 옵션 없는 docker ps에서는 종료된 hello-world 항목이 표시되지 않았다. 원래 컨테이너가 재사용됐으며 내부 파일 유지 여부는 아직 조회 전이다.

다음은 docker attach distracted_goodall로 기존 주 프로그램 Bash의 입력·출력에 연결하는 것이다. 새로운 Bash나 컨테이너를 만든 것으로 기록하지 않는다. 실제 재연결 결과는 아직 대기 중이다.

## 기존 Bash에 attach — 학습자 보고

docker attach distracted_goodall 안내 후 root@c790b20e9cb0:/# 프롬프트가 나타나는지 질문했고 학습자는 나타난다고 보고했다. 실제 프롬프트 원문은 새로 제공되지 않았으므로 보고로 구분한다.

다음은 컨테이너 내부에서 cat /tmp/container-note.txt로 종료·재시작 전에 만든 메모를 읽는 것이다. 기존 컨테이너 파일 유지 여부는 아직 실제 결과를 받지 않았다. 이 실습은 컨테이너 삭제 후 볼륨 영속성 검증과 별개다.

## 같은 컨테이너 재시작 후 메모 조회 — 실제 제공 내용

cat /tmp/container-note.txt 안내 후 학습자가 제공한 내용:

```text
컨테이너에서 만든 첫 메모
```

같은 ID의 컨테이너를 다시 시작하고 연결한 뒤 기존 메모를 읽을 수 있음을 확인했다. 중지는 컨테이너 삭제가 아니며 기존 컨테이너 파일이 남을 수 있음을 실습으로 확인했다. 컨테이너 삭제나 볼륨 연결은 수행하지 않았으므로 이 결과를 삭제 후 영속성 증거로 쓰지 않는다.

다음은 Ctrl+P 다음 Ctrl+Q로 Bash를 종료하지 않고 attach 연결만 끊는 실습이다. 아직 분리된 프롬프트와 실행 유지 상태는 확인하지 않았다.

## attach 연결 분리 — 학습자 보고

Ctrl+P 다음 Ctrl+Q 안내 후 학습자는 WSL 프롬프트로 돌아왔다고 보고했다. 이번에는 exit 대신 기본 분리 단축키를 사용한 흐름이다. 아직 실행 유지 여부는 목록으로 재검증하지 않았으므로 다음은 docker ps 확인이다.

## 연결 분리 후 실행 유지 — 실제 제공 출력

docker ps 안내 후 학습자는 Up이라고 보고하고 이어 아래 실제 출력을 제공했다.

```text
CONTAINER ID   IMAGE     COMMAND   CREATED       STATUS             PORTS     NAMES
c790b20e9cb0   ubuntu    "bash"    3 hours ago   Up About an hour             distracted_goodall
```

동일 컨테이너가 연결 분리 후에도 Up 상태인 것을 검증했다. 앞선 exit 때의 Exited와 구분된다. 다음은 docker exec -it distracted_goodall bash로 실행 중인 컨테이너에 추가 Bash를 실행하는 실습이다. 실제 exec 결과와 추가 셸 종료 후 실행 유지는 아직 확인하지 않았다.

## exec로 추가 Bash 실행 — 학습자 제공 프롬프트

docker exec -it distracted_goodall bash 안내와 필수 요구사항 설명 후 학습자가 아래 프롬프트로 넘어왔다고 제공했다.

```text
root@c790b20e9cb0:/#
```

같은 컨테이너 안이므로 이전 attach 프롬프트와 비슷하다. 안내한 exec의 동작에 따라 추가 Bash에 연결한 흐름이며 별도 프로세스 목록을 조회한 것은 아니다.

다음은 추가 Bash에서 exit한 뒤 WSL에서 docker ps로 원래 컨테이너의 실행 유지 여부를 확인하는 실습이다. 실제 종료 후 상태는 아직 대기 중이다.

## exec Bash 종료 후 실행 유지 — 실제 제공 출력

추가 Bash에서 exit 후 WSL에서 docker ps를 안내했고 아래 실제 출력을 제공받았다.

```text
CONTAINER ID   IMAGE     COMMAND   CREATED       STATUS             PORTS     NAMES
c790b20e9cb0   ubuntu    "bash"    3 hours ago   Up About an hour             distracted_goodall
```

동일 컨테이너가 계속 Up 상태임을 확인했다. 주 Bash에서의 종료, attach 연결만 분리, exec 추가 Bash 종료를 각각 관찰했다. [비교 요약](lifecycle.md)을 만들며, 마지막으로 이번 exec 종료 뒤 컨테이너가 유지된 이유에 대한 학습자 설명을 기다린다.

## 스스로 수행한 컨테이너 파일 조작 — 실제 제공 기록

학습자가 WSL에서 attach 후 pwd·mkdir·ls·ls -a·cd를 직접 조합해 실습한 기록을 제공했다. 첫 줄의 사용자·Windows 경로만 마스킹했다.

```text
[USER]@[HOST]:/mnt/c/Users/[WINDOWS_USER]$ docker attach distracted_goodall
root@c790b20e9cb0:/# pwd
/
root@c790b20e9cb0:/# mkdir "test"
root@c790b20e9cb0:/# ls
bin   dev  home  lib64  mnt  proc  run   srv  test  usr
boot  etc  lib   media  opt  root  sbin  sys  tmp   var
root@c790b20e9cb0:/# ls -a
.   .dockerenv  bin   dev  home  lib64  mnt  proc  run   srv  test  usr
..  .rock       boot  etc  lib   media  opt  root  sbin  sys  tmp   var
root@c790b20e9cb0:/# cd test
root@c790b20e9cb0:/test#
```

현재 컨테이너 내부 /test에 진입한 실제 기록을 확보했다. user가 cd ~도 연습했다고 보고했으나 해당 출력은 위 원문에 없으므로 재구성하지 않는다. 이어 이 명령들이 PowerShell에서도 가능한지 질문해 환경·셸과 명령 호환 범위를 설명하는 단계다. Docker 자체를 Bash와 동일하다고 해석하지 않도록 구분한다.

## 운영 필수 항목 마무리 — 자원 조회 안내

학습자가 빠른 진행을 요청했다. 반복 설명·불필요한 진단을 줄이고 남은 필수 운영 항목인 stats와 stop을 진행한 뒤 Dockerfile로 넘어간다. 이번 단위는 컨테이너 외부 WSL에서 docker stats --no-stream distracted_goodall로 자원 사용량 한 번 조회다. 현재 프롬프트가 컨테이너 안이면 앞서 배운 분리 키로 WSL에 돌아오도록 안내한다. 아직 이번 측정의 실제 출력은 받지 않았다.

## 컴퓨터 재시작 후 실습 재개 — 실제 제공 목록

학습자는 컴퓨터가 꺼진 뒤 wsl -d ubuntu만 실행한 상태라고 알렸다. Docker Desktop을 시작하고 WSL에서 docker ps -a로 확인하도록 안내한 뒤 아래 출력을 제공받았다.

```text
CONTAINER ID   IMAGE         COMMAND    CREATED      STATUS                       PORTS     NAMES
c790b20e9cb0   ubuntu        "bash"     3 days ago   Exited (255) 4 seconds ago             distracted_goodall
121cbcd88298   hello-world   "/hello"   4 days ago   Exited (0) 4 days ago                  affectionate_pascal
```

기존 컨테이너 ID와 이름이 유지됐고 현재 Ubuntu 컨테이너는 종료 상태임을 확인했다. 종료 코드 255를 정상 성공 코드로 기록하지 않으며 컴퓨터 종료와의 정확한 인과관계는 이 출력만으로 확정하지 않는다. 다음은 기존 컨테이너 start 후 stats --no-stream으로 자원 사용량 조회다. 아직 재개 후 시작·측정 결과는 받지 않았다.

## 컨테이너 자원 조회 — 실제 제공 출력

docker start 뒤 docker stats --no-stream distracted_goodall 안내 후 학습자가 제공한 자원 표:

```text
CONTAINER ID   NAME                 CPU %     MEM USAGE / LIMIT   MEM %     NET I/O        BLOCK I/O     PIDS
c790b20e9cb0   distracted_goodall   0.00%     2.32MiB / 13.5GiB   0.02%     1.7kB / 126B   19.5MB / 0B   1
```

앞선 start 출력은 학습자 메시지에서 끝부분 dall만 제공됐으므로 전체 반환 이름을 재구성하지 않는다. stats 결과에서 같은 컨테이너의 자원 조회가 이뤄짐을 확인했다. 조회 시 CPU 0.00%, 메모리 2.32MiB / 한도 13.5GiB, 메모리 비율 0.02%다. 순간 측정값이며 모든 시간의 사용량이나 Windows 전체 메모리 용량으로 해석하지 않는다.

다음은 docker stop distracted_goodall 후 docker ps -a로 실행 중지와 컨테이너 항목 유지 여부 확인이다. 아직 stop 결과는 받지 않았다.

## stop 후 종료 상태 — 실제 제공 출력

docker stop 및 docker ps -a 안내 후 제공받은 목록:

```text
CONTAINER ID   IMAGE         COMMAND    CREATED      STATUS                       PORTS     NAMES
c790b20e9cb0   ubuntu        "bash"     3 days ago   Exited (137) 4 minutes ago             distracted_goodall
121cbcd88298   hello-world   "/hello"   4 days ago   Exited (0) 4 days ago                  affectionate_pascal
```

Ubuntu 컨테이너가 실행 중에서 종료 상태로 바뀌었고 항목은 남았음을 확인했다. 137은 SIGKILL로 종료됐을 때 사용하는 코드다. stop은 종료 요청 후 대기 시간 초과 시 강제 종료할 수 있지만, 이번에 타임아웃이 직접 원인이었는지 별도 로그·이벤트를 조회하지 않았으므로 확정하지 않는다. 메모리 부족으로 단정하지도 않는다.

근거: [Docker 컨테이너 목록의 종료 신호 설명](https://docs.docker.com/reference/cli/docker/container/ls/), [stop의 종료 대기와 강제 종료](https://docs.docker.com/reference/cli/docker/container/stop/).

기본 운영의 시작·상태·로그·자원·중지 실제 결과를 확보했다. attach/exec의 관찰은 기록했고 최종 자기 설명은 제출 전 다시 확인한다. 다음은 챕터 6의 웹 서버 커스텀 이미지 준비다.
