# 환경 변수로 NGINX 내부 포트 변경

학습자가 실행하고 대화로 제공한 결과를 기록한다. 안내한 파일 작성과 실제 제공 출력은 구분한다.

## 변경 전

[Compose 통신 기록](compose.md)에서 이미지 1.0, 포트 8082:80으로 실행하고 helper에서 `http://web`(기본 포트 80)에 요청해 HTML을 받은 실제 출력이 있다.

## 템플릿·이미지 준비

아래 파일을 `default.conf.template`로 작성하도록 안내했고 학습자가 완료 보고했다. 원본 cat 출력은 아직 미수집이다.

```nginx
server {
    listen ${NGINX_PORT};
    root /usr/share/nginx/html;
    index index.html;
}
```

Dockerfile에 다음 줄 추가를 안내했고 완료 보고를 받았다.

```dockerfile
COPY default.conf.template /etc/nginx/templates/default.conf.template
```

`docker build -t workshop-web:2.0 .`의 제공 출력 중 실제 발췌:

```text
[+] Building 2.3s (9/9) FINISHED                                                                                               docker:default
 => [2/3] COPY index.html /usr/share/nginx/html/                                                                                         0.1s
 => [3/3] COPY default.conf.template /etc/nginx/templates/default.conf.template                                                          0.1s
 => => naming to docker.io/library/workshop-web:2.0                                                                                      0.0s
```

제공된 베이스 이미지 전체 digest는 `sha256:713fc2ebfd92e8217db451477182ee91944b123d2b1ee9fd5a8c6e91ca6c3a11`, 생성 이미지 manifest list digest는 `sha256:31fed3a0d0347271d2eb5add88f7de9a505faadf9633b15f91a3da778512af10`이다. Dockerfile에 digest 고정을 했다는 의미는 아니다.

## Compose 변경 안내

다음 설정으로 파일을 교체하도록 안내했고 학습자가 완료 보고했다. 변경 후 원본 cat 출력은 미수집이다.

```yaml
services:
  web:
    image: workshop-web:2.0
    environment:
      NGINX_PORT: "8080"
    ports:
      - "8082:8080"
  helper:
    image: alpine
    command: sleep 3600
```

`docker compose up -d`의 실제 출력:

```text
[+] up 2/2
 ✔ Container web-helper-1 Running                                                                                                         0.0s
 ✔ Container web-web-1    Started
```

## 1. 실제 생성된 설정 확인

명령:

```bash
docker compose exec web cat /etc/nginx/conf.d/default.conf
```

실제 출력:

```nginx
server {
    listen 8080;
    root /usr/share/nginx/html;
    index index.html;
}
```

## 2. 변경된 포트의 응답 확인

```bash
docker compose exec helper wget -qO- http://web:8080
```

실제 출력:

```html
<meta charset='utf-8'><h1>바인드 마운트로 바꾼 화면</h1>
```

판정: 환경 변수로 실제 listen 설정이 8080으로 생성됐고 해당 포트에서 HTTP 응답을 받았다. 현재 Compose에는 바인드 마운트가 없다. 제목은 앞선 실습에서 수정했던 호스트 HTML을 2.0 이미지 빌드 때 COPY한 결과로 해석한다. 출력 HTML을 현재 호스트 파일 전체에 대한 직접 조회 증거로 대체하지 않는다.

작동 원리 참고: [NGINX 공식 이미지 시작 스크립트](https://github.com/nginx/docker-nginx/blob/master/entrypoint/20-envsubst-on-templates.sh)는 기본적으로 /etc/nginx/templates의 .template 파일에 환경 변수를 치환해 /etc/nginx/conf.d에 설정을 생성한다.

## 후속 원본 확인·이해 확인

이후 학습자가 `cat web/compose.yaml`, `cat web/Dockerfile`, `cat web/default.conf.template`, `cat web/index.html`의 실제 출력을 각각 제공했다. 위 변경 안내와 일치했고 HTML은 `<meta charset='utf-8'><h1>바인드 마운트로 바꾼 화면</h1>`이었다. 제출용 [Dockerfile](../../web/Dockerfile)·[템플릿](../../web/default.conf.template)·[Compose](../../web/compose.yaml)·[HTML](../../web/index.html)을 제공된 원문에 맞춰 갱신했다. 이는 제공된 텍스트 내용의 대조이며 파일 바이트 전체·줄바꿈 형식 검증은 아니다.

내부 포트를 9090으로 바꿀 때 포트 매핑 중 바꿀 숫자를 질문하자 학습자는 “8080을 9090으로”라고 답했다. 도우미는 NGINX_PORT 값도 함께 9090으로 맞춰야 한다고 보충했다. 9090 변경 실행을 수행한 것으로 기록하지 않는다.

보완: 최종 README에 이미지 2.0의 선행 빌드 명령과 Compose 실행 폴더를 명시하고 화면 증거를 연결한다.
