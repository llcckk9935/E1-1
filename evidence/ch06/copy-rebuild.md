# COPY와 원본 수정·재빌드 비교

학습자가 VS Code에서 WSL 작업 폴더의 index.html과 Dockerfile을 나란히 열어 확인했다. 다음 내용으로 HTML 제목 변경·저장을 안내했고 완료 보고를 받았다.

```html
<meta charset='utf-8'><h1>복사 확인 연습</h1>
```

## 관찰

1. 저장만 한 뒤 localhost:8082에서 Ctrl+F5: 이전 제목인 “바인드 마운트로 바꾼 화면”이 나온다고 보고했다. 현재 Compose에는 바인드 마운트가 없으며 이 문구는 이전 HTML의 제목이다.
2. `docker build -t workshop-web:2.0 .` 실행 후 다음 실제 출력 발췌를 제공했다.

```text
[+] Building 2.2s (9/9) FINISHED                                                                                               docker:default
 => [2/3] COPY index.html /usr/share/nginx/html/                                                                                         0.0s
 => [3/3] COPY default.conf.template /etc/nginx/templates/default.conf.template                                                          0.1s
 => => exporting manifest list sha256:310b3896289aee301cc318c3fae4b8fccc82a0bab328fd869df6cfc1ec9b99ec                                   0.0s
 => => naming to docker.io/library/workshop-web:2.0                                                                                      0.0s
```

3. `docker compose up -d web`의 실제 출력:

```text
[+] up 1/1
 ✔ Container web-web-1 Started
```

이 출력만으로 교체 과정 전체가 표시됐다고 보지는 않는다. 이후 같은 주소에서 Ctrl+F5를 안내했고 학습자는 “이제 복사 확인 이라고” 표시됨을 보고했다. 실제 브라우저 화면 파일은 미확보다.

## 자기 설명

> 카피로 넣은 html을 수정한 뒤에 화면에 반영하기 위해서는 새로 이미지를 빌드 하고 컨테이너도 새로 만들어야함. 명령어는 build와 compose를 씀

판정: COPY가 빌드 시 복사이며 원본 저장만으로 실행 중인 서버가 바뀌지 않음을 비교 관찰하고 설명했다. 정확한 사용 명령은 docker build와 docker compose up -d web이다.

## 실제 diff 및 커밋·업로드 확인

`git diff`의 실제 출력:

```diff
diff --git a/web/index.html b/web/index.html
index 92fa217..d0947ce 100644
--- a/web/index.html
+++ b/web/index.html
@@ -1 +1 @@
-<meta charset='utf-8'><h1>바인드 마운트로 바꾼 화면</h1>
+<meta charset='utf-8'><h1>복사 확인 연습</h1>
```

이 실제 diff를 기준으로 제출용 HTML 사본을 갱신했다. `git add index.html` 수행 보고 후 `git commit -m "COPY 변경 반영 실습으로 웹 제목 수정"`의 실제 출력:

```text
[main bd7e9e1] COPY 변경 반영 실습으로 웹 제목 수정
 1 file changed, 1 insertion(+), 1 deletion(-)
```

`git push` 수행은 완료 보고로 받았으며 전송 출력 원문은 미수집이다. 후속 `git status` 실제 출력:

```text
On branch main
Your branch is up to date with 'origin/main'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        ../practice1/

nothing added to commit but untracked files present (use "git add" to track)
```

로컬 main과 추적 중인 origin/main의 일치를 확인했다. 원격 웹의 최신 커밋 직접 조회는 별도이며 practice1은 여전히 커밋하지 않았다.
