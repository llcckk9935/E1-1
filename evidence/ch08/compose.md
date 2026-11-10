# 단일 서비스 Compose 실행·운영

학습자가 Ubuntu의 `~/workshop/web`에서 실행하고 대화로 제공한 결과다. 원본 설정 파일 내용은 아직 직접 조회하지 않았으며, 아래는 작성하도록 안내한 설정이다. 파일 작성은 학습자가 완료 보고했다.

```yaml
services:
  web:
    image: workshop-web:1.0
    ports:
      - "8082:80"
```

## 실행

명령:

```bash
docker compose up -d
```

제공된 실제 출력:

```text
[+] up 2/2
 ✔ Network web_default Created                                                  0.1s
 ✔ Container web-web-1 Started
```

브라우저 `http://localhost:8082`에서 “내 개발 작업실”이 나온다고 보고했다. 실제 주소창 포함 화면은 미확보다. 기존 이미지의 COPY된 콘텐츠이며 이 설정에는 바인드 마운트가 없다.

## 상태

```bash
docker compose ps
```

제공된 실제 출력:

```text
NAME        IMAGE              COMMAND                  SERVICE   CREATED       STATUS       PORTS
web-web-1   workshop-web:1.0   "/docker-entrypoint.…"   web       3 hours ago   Up 3 hours   0.0.0.0:8082->80/tcp, [::]:8082->80/tcp
```

## 로그

```bash
docker compose logs --tail 10 web
```

제공된 실제 출력:

```text
web-1  | 2026/11/10 06:37:36 [notice] 1#1: start worker process 40
web-1  | 2026/11/10 06:37:36 [notice] 1#1: start worker process 41
web-1  | 2026/11/10 06:37:36 [notice] 1#1: start worker process 42
web-1  | 2026/11/10 06:37:36 [notice] 1#1: start worker process 43
web-1  | 2026/11/10 06:37:36 [notice] 1#1: start worker process 44
web-1  | 2026/11/10 06:37:36 [notice] 1#1: start worker process 45
web-1  | 172.18.0.1 - - [10/Nov/2026:06:39:44 +0000] "GET / HTTP/1.1" 200 52 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36 Edg/157.0.0.0" "-"
web-1  | 172.18.0.1 - - [10/Nov/2026:06:39:44 +0000] "GET /favicon.ico HTTP/1.1" 404 555 "http://localhost:8082/" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36 Edg/157.0.0.0" "-"
web-1  | 2026/11/10 06:39:44 [error] 30#30: *1 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 172.18.0.1, server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "localhost:8082", referrer: "http://localhost:8082/"
web-1  | 172.18.0.1 - - [10/Nov/2026:06:39:49 +0000] "GET / HTTP/1.1" 304 0 "-" "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/157.0.0.0 Safari/537.36 Edg/157.0.0.0" "-"
```

해석: GET /의 200은 페이지 요청 성공, 304는 브라우저가 보관한 내용을 재사용할 수 있다는 응답이다. favicon.ico의 404는 탭 아이콘 파일이 없는 별도 요청으로, 페이지 요청 실패와 구분한다. worker process는 요청을 처리하는 작업 프로세스다.

## 종료 및 재실행·내부 통신

`docker compose down`의 실제 출력:

```text
[+] down 2/2
 ✔ Container web-web-1 Removed                                                                                                            0.4s
 ✔ Network web_default Removed
```

이후 `docker compose ps`의 실제 출력(제목만 있고 컨테이너 행 없음):

```text
NAME      IMAGE     COMMAND   SERVICE   CREATED   STATUS    PORTS
```

helper 서비스를 추가한 뒤 제공된 `cat compose.yaml` 실제 출력:

```yaml
services:
  web:
    image: workshop-web:1.0
    ports:
      - "8082:80"
  helper:
    image: alpine
    command: sleep 3600
```

제출용 사본: [compose.yaml](../../web/compose.yaml). 이후 수정 시 실제 원문과 대조해 갱신한다.

`docker compose up -d`의 실제 출력:

```text
[+] up 7/7
 ✔ Image alpine           Pulled                                                                                                          3.5s
 ✔ Network web_default    Created                                                                                                         0.1s
 ✔ Container web-web-1    Started                                                                                                         0.8s
 ✔ Container web-helper-1 Started
```

`docker compose exec helper wget -qO- http://web`의 실제 출력:

```html
<meta charset='utf-8'><h1>내 개발 작업실</h1>
```

판정: helper에서 서비스 이름 web으로 HTTP 요청을 보내 응답을 수신했다. 브라우저용 호스트 포트 8082를 경유하는 검증과 별개다. 학습자는 요청 주체가 helper임을 답했고, 설정 파일에서 8082를 8083으로 바꾸면 호스트 접속 포트가 바뀐다고 설명했다.

미완료: 환경 변수로 서버 포트 또는 모드 변경의 실제 동작 비교, 주소창 포함 화면 증거, 최종 이미지·Compose 재현 절차 정리. helper의 sleep 3600은 1시간 후 종료하므로 후속 exec 전 실행 상태에 유의한다.
