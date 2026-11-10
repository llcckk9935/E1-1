# Docker 기본 운영 검증 요약

단계별 실제 출력은 [Docker 실습 기록](docker.md)에 보관한다. 이 문서는 원본 운영 요구사항과 증거 위치를 연결하는 요약이다.

| 요구사항 | 수행 명령 | 확인된 결과 |
|---|---|---|
| 이미지 다운로드 | docker pull ubuntu, hello-world run의 자동 다운로드 | 실제 다운로드 완료 출력 확보 |
| 이미지 목록 | docker images | hello-world 실제 목록 출력 및 Ubuntu 목록 등장 보고 |
| 컨테이너 실행·재시작 | docker run, docker start | hello-world 메시지, Ubuntu Bash 프롬프트와 Up 목록 확보 |
| 실행 중·전체 목록 | docker ps, docker ps -a | 같은 Ubuntu 컨테이너의 Up/Exited 비교 확보 |
| 로그 조회 | docker logs affectionate_pascal | 종료된 hello-world의 실제 출력 확보 |
| 자원 조회 | docker stats --no-stream distracted_goodall | CPU 0.00%, 메모리 2.32MiB / 13.5GiB 실제 출력 확보 |
| 중지 | docker stop distracted_goodall 이후 docker ps -a | Exited (137) 및 동일 컨테이너 항목 유지 확인 |

종료 코드 137의 구체적인 발생 원인은 확정하지 않았고 정상 코드 0으로 변경하지 않는다. [종료·유지와 attach/exec 비교](lifecycle.md)의 최종 자기 설명과 전체 증거의 제출 검토는 별도 관리한다. 아직 GitHub에 이 기록을 업로드한 것은 아니다.
