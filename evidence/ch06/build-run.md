# 챕터 6 — 웹 서버 커스텀 이미지

선택 방식: 원본 4절의 A, 기존 웹 서버 이미지에 정적 콘텐츠를 추가하는 방식으로 학습한다. Dockerfile은 학습자가 지시문 의미를 배운 뒤 직접 구성할 기회를 제공한다.

## 작업 폴더 준비 — 학습자 보고

안내 명령:

```bash
mkdir ~/workshop/web
cd ~/workshop/web
```

학습자는 프롬프트가 바뀌었다고 보고하고 폴더 생성이 맞는지 질문했다. WSL Ubuntu의 workshop 안에 web을 만들고 이동한 작업임을 설명했다. 프롬프트 원문은 미제공이며 실제 화면을 재구성하지 않는다. 컨테이너 내부에 만든 /test와 구분한다.

다음은 index.html에 UTF-8 문자 설정과 제목을 담은 작은 HTML 페이지를 만들고 cat으로 내용을 확인하는 것이다. 아직 파일 내용·Dockerfile·이미지 빌드·웹 접속은 검증하지 않았다.

## 웹 페이지 소스 저장 확인 — 학습자 보고

echo로 index.html을 만들고 cat으로 확인하도록 안내했고 학습자는 내용이 나온다고 보고했다. 제목을 바꿀 수 있도록 안내했으므로 제공되지 않은 실제 파일 원문을 예시와 같다고 확정하지 않는다. 소스 원문 수집과 웹 접속 검증은 후속 단계다.

다음은 Dockerfile이 이미지 제작 설명서임을 배우고 FROM으로 기존 NGINX 이미지를 선택하며 COPY로 웹 소스를 넣는 두 작업을 학습한다. 완성 예시를 일괄 제공하기 전에 COPY의 참고 예시와 실제 원본·목적지를 제시해 학습자가 필요한 한 줄을 직접 구성하도록 한다. 아직 Dockerfile 파일 저장이나 빌드는 수행하지 않았다.

참고: [공식 NGINX 이미지의 정적 콘텐츠와 Dockerfile 예시](https://github.com/docker-library/docs/blob/master/nginx/README.md#hosting-some-simple-static-content).

## COPY 지시문 직접 구성

COPY의 일반 예시와 실제 원본·목적지를 설명한 뒤 학습자가 직접 작성한 줄:

```dockerfile
COPY index.html /usr/share/nginx/html/
```

원본과 이미지 내부 목적지를 올바르게 구성했다. 다음은 FROM nginx:alpine과 이 줄을 echo·리다이렉션으로 Dockerfile에 저장하고 cat으로 확인하는 작업이다. 파일 저장 결과와 빌드는 아직 검증하지 않았다.

## Dockerfile 저장 확인 — 실제 제공 내용

cat Dockerfile 안내 후 학습자가 제공한 내용:

```dockerfile
FROM nginx:alpine
COPY index.html /usr/share/nginx/html/
```

기존 웹 서버 이미지를 선택하고 학습자가 구성한 COPY를 포함하는 Dockerfile 내용을 확인했다. 사용자 페이지를 포함하는 것이 커스텀 포인트이며 NGINX 패키지를 처음부터 설치하는 방식은 아니다. 아직 index.html의 실제 전체 원문과 빌드·실행·접속은 검증하지 않았다.

다음은 workshop/web에서 docker build -t workshop-web:1.0 .으로 이미지 제작이다. 실제 빌드 결과는 대기 중이다.

## 커스텀 이미지 빌드 — 실제 제공 출력

docker build -t workshop-web:1.0 . 안내 후 학습자가 전체 빌드 출력을 제공했다. 아래는 제작 단계와 결과의 실제 발췌다. 다운로드 레이어 상세는 생략했으며 터미널 폭으로 잘린 해시를 임의로 완성하지 않는다.

```text
[+] Building 12.2s (8/8) FINISHED                           docker:default
 => [internal] load build definition from Dockerfile                  0.1s
 => => transferring dockerfile: 94B                                   0.0s
 => [internal] load metadata for docker.io/library/nginx:alpine       3.6s
 => [internal] load build context                                     0.0s
 => => transferring context: 89B                                      0.0s
 => [1/2] FROM docker.io/library/nginx:alpine@sha256:713fc2ebfd92e82  6.7s
 => [2/2] COPY index.html /usr/share/nginx/html/                      0.2s
 => exporting to image                                                1.4s
 => => naming to docker.io/library/workshop-web:1.0                   0.0s
 => => unpacking to docker.io/library/workshop-web:1.0                1.2s
```

FROM·COPY 단계와 workshop-web:1.0 이름으로 이미지 출력 완료를 확인했다. 이미지 제작 성공이며 웹 서버 실행·포트 접속 성공은 아직 확인하지 않았다. 기반 태그 nginx:alpine은 변할 수 있는 태그다. 제공된 해시는 일부가 잘려 있으므로 완전한 digest로 고정한 빌드라고 기록하지 않는다. 최종 재현 문서에는 실제 검증 조건을 명시한다.

다음은 docker run -d --name my-web -p 8080:80 workshop-web:1.0으로 웹 서버 컨테이너 실행이다. 브라우저 접속을 위해 호스트 8080과 컨테이너 80을 연결하며, 실제 실행 결과는 아직 대기 중이다.

## 커스텀 이미지로 컨테이너 생성 — 실제 제공 ID

위 run 명령 안내 후 학습자가 긴 컨테이너 ID를 제공했다.

```text
725a8fe580da4db5f7e1cdd5125d760652a7a43c1ecb5f9befa999d4df1b9774
```

함께 제공된 앞줄 web:1.0은 일부 텍스트만 있으므로 전체 명령 줄이나 다른 성공 메시지로 재구성하지 않는다. 컨테이너 식별자가 반환된 것을 확인했다. 이후에도 서버가 실행 중이고 실제 웹 응답이 되는지는 아직 별도 확인 전이다. 다음은 Windows 브라우저의 http://localhost:8080 접속이다.
