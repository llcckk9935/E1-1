# 챕터 4 — Git 변경 이력 관리

## 우분투 Git 사용 가능 여부 — 실제 제공 출력

우분투 Bash에서 `git --version` 안내 후 학습자가 제공한 출력:

```text
git version 2.53.0
```

우분투 Git 버전 2.53.0을 확인했다. Windows에서 앞서 확인한 Git 2.55.0.windows.5와 구분한다. 아직 로컬 저장소 생성·사용자 정보·기본 브랜치 설정·커밋·원격 연결은 이 챕터에서 검증하지 않았다.

다음 단위는 `cd ~/workshop`으로 대상 폴더에 이동한 뒤 `git init -b main`으로 로컬 저장소를 초기화하는 것이다. 실제 결과는 아직 대기 중이다.

## 로컬 저장소 초기화 — 실제 제공 출력

`cd ~/workshop` 및 `git init -b main` 안내 후 학습자가 제공한 출력이다. 사용자 이름은 마스킹했다.

```text
Initialized empty Git repository in /home/[USER]/workshop/.git/
```

workshop의 .git 경로에 로컬 저장소가 초기화된 것을 확인했다. empty는 아직 커밋 이력이 없다는 의미이며 기존 작업 파일이 없다는 뜻으로 해석하지 않는다. 아직 git status로 초기 브랜치·파일 상태를 확인하지 않았으며 첫 커밋이나 GitHub 업로드는 수행하지 않았다.

다음 단위는 workshop에서 git status 조회다.

## 초기 Git 상태 — 실제 제공 출력

안내 명령: git status.

```text
On branch main

No commits yet

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        notes.txt

nothing added to commit but untracked files present (use "git add" to track)
```

초기 브랜치 main, 커밋 없음, notes.txt가 미추적 상태임을 확인했다. 다음은 git add notes.txt로 다음 커밋에 포함할 내용을 선택하고 git status로 상태 변화를 확인하는 것이다. 아직 실행하지 않았다.

## 첫 파일 스테이징 — 실제 제공 출력

사용자가 제공한 화면 중 git add와 그 뒤의 git status 결과를 발췌했다. 사용자·컴퓨터 이름은 마스킹했다. 앞쪽의 중복된 초기 상태 출력은 생략했다.

```text
[USER]@[HOST]:~/workshop$ git add notes.txt
[USER]@[HOST]:~/workshop$ git status
On branch main

No commits yet

Changes to be committed:
  (use "git rm --cached <file>..." to unstage)
        new file:   notes.txt
```

notes.txt가 미추적 상태에서 스테이징된 새 파일로 바뀌었다. 커밋 자체는 아직 없고 GitHub에 업로드되지 않았다. 출력에 나온 git rm --cached는 Git의 안내 문구이며 실행하지 않았다.

다음은 이 저장소에서 사용할 커밋 작성자 이름을 git config user.name으로 설정하는 단계다. 학습자가 지정한 제출 저장소 소유자 ID인 llcckk9935를 표시 이름으로 안내한다. 아직 실행 보고 전이며 이메일·기본 브랜치 공통 설정·실제 커밋은 남아 있다.

## 커밋 작성자 이름 설정 — 학습자 보고

`git config user.name "llcckk9935"` 안내 후 학습자가 완료했다고 보고했다. 설정값의 실제 조회 출력은 아직 확보하지 않았으므로 보고로 구분한다. 다음은 공개 저장소 제출에 사용할 커밋 이메일 설정이다. 개인 이메일 노출을 줄일 수 있는 GitHub noreply 주소를 검토한다.

## 커밋 이메일 주소 확인 — 학습자 제공

GitHub 이메일 설정에서 제공하는 noreply 주소를 요청했고 학습자는 `301666771+llcckk9935@users.noreply.github.com`을 제공했다. 이는 학습자 제공 정보이며 도우미가 계정 인증 화면을 직접 검증한 것은 아니다.

다음은 해당 주소를 현재 저장소의 user.email에 설정하고 git config --local --list로 이름·이메일 등 로컬 설정을 확인하는 것이다. 아직 실행 결과는 받지 않았다. 주소는 제출에 사용하는 noreply 주소이며 비밀번호·토큰·개인키는 제공받지 않았다.

## 로컬 Git 설정 검증 — 실제 제공 출력

git config user.email 설정과 git config --local --list 안내 후 실제 출력:

```text
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
user.name=llcckk9935
user.email=301666771+llcckk9935@users.noreply.github.com
```

현재 저장소에 작성자 이름·이메일이 저장됐음을 실제 출력으로 검증했다. 출력에서 토큰·비밀번호·개인키는 확인되지 않았다. core 항목은 Git의 저장소 설정이며 이번 단위에서는 각 내부 설정의 숙련을 요구하지 않는다.

다음은 스테이징된 notes.txt를 git commit -m으로 첫 기록으로 저장하는 것이다. 아직 커밋 성공이나 GitHub 업로드는 확인하지 않았다. 향후 저장소의 공통 기본 브랜치 설정도 후속 필수 항목으로 유지한다.

## 첫 커밋 — 실제 제공 출력

git commit -m "첫 학습 기록" 안내 후 실제 출력:

```text
[main (root-commit) 4ce9eea] 첫 학습 기록
 1 file changed, 2 insertions(+)
 create mode 100644 notes.txt
```

main 브랜치에 첫 커밋(root-commit)이 만들어졌고 짧은 식별자는 4ce9eea다. 파일 1개와 추가된 줄 2개가 보고됐다. create mode 100644는 Git의 일반 비실행 파일 모드 표기이며 Linux의 모든 파일 권한 비트를 그대로 보존한다는 뜻은 아니다. 앞서 파일 시스템에서 640을 설정한 것과 이 출력만으로 충돌한다고 판단하지 않는다. 현재 파일 시스템 권한을 별도로 재조회한 것은 아니다.

다음은 git log --oneline으로 저장된 이력 조회다. GitHub 업로드는 아직 수행하지 않았다.

## 첫 커밋 이력 조회 — 실제 제공 출력

git log --oneline 안내 후 실제 출력:

```text
4ce9eea (HEAD -> main) 첫 학습 기록
```

main의 첫 커밋이 로컬 이력에서 조회됐다. HEAD는 현재 작업 기준을 가리키며 여기서는 main 브랜치를 가리킨다. 이어 학습자가 GitHub에 올린 것인지 질문해 로컬 커밋과 원격 업로드를 구분하는 설명을 진행한다. 아직 git remote 연결·push·GitHub 파일 확인은 수행하지 않았다.

## 첫 커밋 이후 파일 수정 — 실제 제공 상태 출력

workshop에서 echo로 문장을 추가하고 git status를 실행하도록 안내했다.

```bash
echo "Git으로 변경 이력을 남긴다." >> notes.txt
git status
```

학습자가 제공한 실제 출력:

```text
On branch main
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   notes.txt

no changes added to commit (use "git add" and/or "git commit -a")
```

Git이 추적 중인 notes.txt의 수정은 감지했지만 이번 수정은 아직 스테이징되지 않았다. 기존 커밋을 수정하거나 두 번째 커밋을 생성한 것은 아니다. 출력에 나온 restore와 commit -a는 Git의 도움말이며 실행하지 않았다.

다음은 git diff로 스테이징하지 않은 변경 줄을 확인하는 것이다. 아직 diff 출력은 받지 않았다.

## 변경 내용 비교 — 실제 제공 출력

git diff 안내 후 실제 출력:

```diff
diff --git a/notes.txt b/notes.txt
index ee2515c..c50a482 100644
--- a/notes.txt
+++ b/notes.txt
@@ -1,2 +1,3 @@
 오늘 첫 파일을 만들었다.
 권한 실험
+Git으로 변경 이력을 남긴다.
```

추가 문장 한 줄을 확인했다. 내용 줄 앞의 +는 비교 출력의 추가 표시이며 파일 내용에 + 자체를 적었다는 뜻이 아니다. 기존 2줄에서 3줄로 바뀌는 diff를 실제로 확인했다.

다음은 add로 이번 수정을 선택하고 커밋 메시지를 붙여 두 번째 이력을 남기는 것이다. 아직 두 번째 커밋은 확인하지 않았다.

## 두 번째 커밋 — 실제 제공 출력

git add 및 git commit 안내 후 실제 출력:

```text
[main fa02190] git 학습 문장 추가
 1 file changed, 1 insertion(+)
```

두 번째 커밋 fa02190이 main에 만들어졌고 파일 1개에 1줄 추가가 보고됐다. 메시지는 학습자가 제공한 출력의 소문자 git을 그대로 보존한다. 아직 원격 업로드는 하지 않았다.

다음 실습은 이미 배운 한 줄 이력 조회 명령을 다시 사용해 첫 커밋과 두 번째 커밋을 함께 확인하는 것이다. 아직 조회 결과는 대기 중이다.

## 두 커밋 이력 조회 — 실제 제공 출력

```text
fa02190 (HEAD -> main) git 학습 문장 추가
4ce9eea 첫 학습 기록
```

학습자는 앞서 배운 한 줄 이력 조회를 수행하고 위 출력을 제공했다. 최신 커밋과 첫 커밋이 모두 남아 있으며 HEAD는 main의 최신 커밋을 가리킨다. 파일 수정·status·diff·add·commit·log 흐름을 두 커밋으로 학습했다.

다음은 원본 요구사항인 공통 기본 브랜치 설정을 위해 우분투 사용자의 init.defaultBranch를 main으로 설정하고 git config --list 실제 결과를 확인하는 것이다. 기존 저장소는 init -b main으로 이미 main을 사용하지만 새 저장소의 기본값과는 별개다. 아직 공통 설정의 실행 결과는 받지 않았다.

## 공통 기본 브랜치 및 적용 설정 검증 — 실제 제공 출력

git config --global init.defaultBranch main 및 git config --list 안내 후 실제 출력:

```text
init.defaultbranch=main
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
user.name=llcckk9935
user.email=301666771+llcckk9935@users.noreply.github.com
```

새 저장소 기본 브랜치 main과 현재 저장소 작성자 이름·noreply 이메일이 적용됨을 실제 출력으로 확인했다. 비밀번호·토큰·개인키는 출력에서 확인되지 않았다. 현재 저장소가 main인 사실과 공통 기본값 설정을 각각 구분해 검증했다.

다음은 학습한 작업 상태 조회 명령을 사용해 커밋 뒤 남은 변경이 있는지 확인하는 마무리 실습이다. 해당 최신 결과와 Git/GitHub 역할의 최종 설명은 아직 대기 중이다. 원격 연결·업로드는 아직 수행하지 않았다.

## 커밋 후 작업 상태 — 실제 제공 출력

앞서 배운 상태 조회 명령으로 마무리 확인하도록 안내했고 학습자가 제공한 출력:

```text
On branch main
nothing to commit, working tree clean
```

현재 main에서 Git이 보고하는 추가 커밋 대상 변경이 없음을 확인했다. 무시된 파일이나 컴퓨터의 모든 파일까지 Git에 저장됐다는 뜻은 아니다. 원격 업로드 완료를 뜻하지도 않는다.

Git 버전·저장소 생성·작성자와 기본 브랜치 설정·상태 조회·차이 확인·스테이징·두 커밋·이력 조회까지 실제 출력과 학습자 보고를 구분해 기록했다. 다음은 과제 목표 6의 Git과 GitHub 역할 차이에 대한 학습자 설명이며 아직 답변은 받지 않았다.

## Git과 GitHub 역할 설명

후속 웹 실습 후 실제 `git status`에서 main 브랜치의 미추적 파일은 `practice1/`, `web/`로 표시됐다. 커밋 전 web의 4개 파일 목록과 각 파일 원문을 확인했다. practice1은 중단한 반복 연습 폴더이며 현재 web만 스테이징할 예정이다. 아직 웹 파일 커밋·원격 푸시는 수행 확인 전이다.

학습자 답변:

> 깃은 파일들을 관리하는 프로그램이고, 깃허브는 파일들을 저장할 수 있는 보관소 서비스다.

프로그램과 원격 보관 서비스라는 기본 구분을 확인했다. 도우미가 Git의 핵심은 로컬 변경 이력 관리이고 GitHub는 파일과 그 Git 이력을 원격으로 보관·공유하며 협업하는 서비스라고 보충했다. 현재 두 커밋은 로컬에 있으며 지정 GitHub 저장소에 업로드한 것으로 기록하지 않는다.
