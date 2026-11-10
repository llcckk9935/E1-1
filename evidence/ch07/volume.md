# 볼륨 영속성 실습 기록

학습자가 대화로 전달한 결과이며 도우미의 직접 실행 로그가 아니다.

| 안내한 작업 | 확인된 결과 |
|---|---|
| `docker volume create workshop-data` | 엔진 연결 오류 후 Docker Desktop 실행, `workshop-data` 출력 보고 |
| `docker run -it --name volume-test -v workshop-data:/data ubuntu bash` | 실제 프롬프트 `root@50dcb0254644:/#` 제공 |
| `echo "컨테이너를 삭제해도 이 메모는 남는다." > /data/memo.txt` | 화면 출력 없음 보고 |
| `cat /data/memo.txt` | 저장된 내용 표시 보고, 출력 원문 미수집 |
| `exit` 및 `docker rm volume-test` | 복귀·삭제 수행 보고, 삭제 출력 원문 미수집 |
| `docker run -it --name volume-test2 -v workshop-data:/data ubuntu bash` | PowerShell에서 생성 후 `root@3cdac4a27301:/# exit` 실제 기록 제공 |
| WSL에서 같은 run 명령 반복 | 아래 이름 중복 오류 원문 제공 |
| `docker start -ai volume-test2` | 기존 컨테이너 재진입 보고 |
| `cat /data/memo.txt` | 이전 메모 표시 보고, 출력 원문 미수집 |

제공된 오류 원문:

```text
docker: Error response from daemon: Conflict. The container name "/volume-test2" is already in use by container "3cdac4a27301eb7f9493d3ba81ea887d20a9201bc056218e8b6b7662f7b24e7c". You have to remove (or rename) that container to be able to reuse that name.
```

원인 가설: PowerShell에서 이미 생성한 컨테이너가 exit 후에도 남아 있어 같은 Docker 엔진에 새 컨테이너 생성을 요청하면 이름이 중복된다. 확인 근거는 첫 생성 프롬프트의 ID와 오류의 ID가 일치한다는 점이다. 해결은 새 run 대신 start -ai로 기존 컨테이너를 시작하는 것이다. 이후 재진입·메모 조회 성공을 학습자가 보고했다.

이해 확인: 새 빈 볼륨을 연결하면 이전 메모가 보일지 질문하자 “안보이지 워크샵데이터 볼륨에 저장되어있는거기 때문에”라고 답했다. 데이터가 컨테이너와 별도로 볼륨에 저장됨을 설명했다.

최초 실습은 위처럼 학습자 보고와 실제 출력을 구분했다. 이후 아래 재검증에서 삭제 전후 실제 출력을 보완했다. 최초 실행 때의 출력으로 소급하지 않는다.

## 후속 재검증 — 삭제 전후 실제 출력 확보

각 명령은 도우미가 안내하고 학습자가 실행했다. 아래 출력 블록은 대화로 제공된 원문이며 명령을 포함한 연속 터미널 캡처는 아니다.

### 1. 기존 컨테이너 상태

`docker ps -a`의 제공 출력 중 관련 행 발췌:

```text
CONTAINER ID   IMAGE              COMMAND                  CREATED             STATUS                      PORTS                                         NAMES
3cdac4a27301   ubuntu             "bash"                   5 hours ago         Exited (0) 5 hours ago                                                    volume-test2
```

`docker start -ai volume-test2` 수행 후 재진입을 보고했다.

### 2. 삭제 전 메모

컨테이너 안에서 실행한 명령:

```bash
cat /data/memo.txt
```

제공된 실제 출력:

```text
컨테이너를 삭제해도 이 메모는 남는다.
```

### 3. 기존 컨테이너 삭제

`exit`로 복귀했다고 보고한 뒤 호스트에서 다음을 실행했다.

```bash
docker rm volume-test2
```

제공된 실제 출력:

```text
volume-test2
```

### 4. 다른 컨테이너에 같은 볼륨 연결

```bash
docker run -it --name volume-test3 -v workshop-data:/data ubuntu bash
```

제공된 실제 프롬프트:

```text
root@77507e032262:/#
```

이전 ID 3cdac4a27301과 다른 새 컨테이너다. 이 새 컨테이너에서 다음 명령을 실행했다.

```bash
cat /data/memo.txt
```

제공된 실제 출력:

```text
컨테이너를 삭제해도 이 메모는 남는다.
```

판정: 기존 컨테이너 삭제 성공 출력, 새 컨테이너 식별자, 같은 볼륨 연결 명령, 전후 동일한 메모 출력으로 볼륨의 데이터 유지가 검증됐다. 이 과정에서 workshop-data 볼륨을 삭제하거나 메모를 다시 쓰지 않았다.
