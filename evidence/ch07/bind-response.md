# 바인드 마운트 후속 검증 — 실제 HTTP 응답

초기 브라우저 제목 변경 보고는 [앞선 기록](bind-mount.md)에 보관한다. 아래는 별도 후속 검증으로, 제공받은 실제 출력 원문을 기록한다. 명령은 도우미가 안내했고 학습자가 Ubuntu 터미널에서 실행했다.

## 1. 기존 컨테이너 시작

```bash
docker start web-live
```

실제 출력:

```text
web-live
```

이 컨테이너는 이전 실습에서 `/home/llcckk/workshop/web:/usr/share/nginx/html`을 바인드 마운트하고 `8081:80`으로 실행했다. 이름과 생성 ID는 앞선 기록에 있다.

## 2. 현재 HTML 응답

```bash
curl http://localhost:8081
```

실제 출력:

```html
<meta charset='utf-8'><h1>복사 확인 연습</h1>
```

## 3. 호스트에 새 검증 파일 작성

HTML 원본을 다시 변경하지 않도록 별도의 임시 검증 파일을 사용했다.

```bash
echo "마운트 변경 전" > ~/workshop/web/bind-check.txt
```

파일 작성은 완료 보고로 받았다. 이어 아래 명령을 실행했다.

```bash
curl http://localhost:8081/bind-check.txt
```

실제 출력:

```text
마운트 변경 전
```

## 4. 호스트 파일 변경 후 같은 URL 재조회

```bash
echo "마운트 변경 후" > ~/workshop/web/bind-check.txt
```

완료 보고 후 같은 요청:

```bash
curl http://localhost:8081/bind-check.txt
```

실제 출력:

```text
마운트 변경 후
```

판정: 두 요청 사이 이미지 빌드·컨테이너 재생성·재시작 없이 호스트 파일의 새 내용이 HTTP 응답에 반영됐다. 이것은 이미지 안의 COPY 복사본이 자동 갱신된 것이 아니라 연결된 호스트 폴더를 사용하는 결과다.

후속 정리: `rm ~/workshop/web/bind-check.txt`로 검증용 파일만 삭제하도록 안내했고 학습자가 수행 완료를 보고했다. 삭제 후 목록 출력은 별도로 수집하지 않았으므로 생성하지 않는다. 원래 HTML은 그대로 유지했다. 포트 접속의 실제 브라우저 화면은 [별도 증거](ports.md)에 있다.
