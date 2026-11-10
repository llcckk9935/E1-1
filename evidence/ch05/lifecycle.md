# 컨테이너 종료·유지와 attach/exec 비교

원본 요구: 컨테이너 종료/유지(attach/exec 등)의 차이를 직접 관찰하고 정리한다.

실습 대상은 Ubuntu 이미지로 만든 컨테이너 c790b20e9cb0, 이름 distracted_goodall이다. [단계별 실제 출력과 학습자 보고](docker.md)를 근거로 정리한다.

| 작업 | 실제 관찰 | 해석 |
|---|---|---|
| docker run -it ubuntu bash의 주 Bash에서 exit | WSL로 복귀 후 docker ps -a에서 Exited (2) | 주 프로그램 종료에 따라 컨테이너 실행 종료. 코드 2의 구체적 원인은 미확정이며 정상 코드 0으로 바꾸어 기록하지 않음 |
| start 후 attach한 상태에서 Ctrl+P → Ctrl+Q | WSL로 복귀, docker ps에 같은 ID가 Up About an hour | 터미널 연결을 분리해도 주 프로그램과 컨테이너는 유지 |
| docker exec -it distracted_goodall bash 후 그 Bash에서 exit | WSL로 복귀, docker ps에 같은 ID가 Up About an hour | 추가 Bash를 종료해도 원래 주 프로그램은 유지 |

중지·재시작 뒤 기존 메모도 읽었으나 컨테이너를 삭제한 것은 아니다. 삭제 후 데이터 영속성은 이후 볼륨 실습에서 따로 검증한다.

실제 프로세스 번호 목록을 조회한 것은 아니며 프로그램 역할은 run·attach·exec 명령의 동작과 관찰 결과를 연결해 설명했다. 학습자의 최종 자기 설명은 아직 대기 중이다.

## 최종 설명 중 확인된 혼동 — 재설명 단계

학습자는 root@c790b20e9cb0:/#는 Docker 컨테이너, llcckk@LCK의 /mnt/c 경로 프롬프트는 WSL Ubuntu라고 구분했다. 두 환경의 셸이 모두 Bash일 수 있다는 점과 컨테이너 이름 distracted_goodall과 프로그램 이름 bash를 다시 설명한다.

학습자는 attach 연결 후 나와도 프로그램이 유지되기 때문이라고 해석했다. 연결 분리(Ctrl+P, Ctrl+Q)는 기존 주 Bash를 유지하지만 attach된 주 Bash에서 exit하는 것은 다르다. 이번 관찰은 exec로 실행한 추가 Bash를 종료했고 원래 Bash가 남아 컨테이너가 유지된 경우다. attach와 exec에서 보이는 프롬프트가 같을 수 있어 표시만으로 어느 Bash인지 판단할 수 없다는 점을 보충한다.

아직 자기 설명 목표 완료로 표시하지 않고 새 실행 없이 개념을 다시 정리한다. A(원래 Bash)·B(추가 Bash)는 설명용 이름이며 실제 프로세스 번호를 측정한 값이 아니다.
