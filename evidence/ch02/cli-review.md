# 기본 CLI 후속 검증

기존 web 소스와 분리한 `~/workshop/cli-review`에서 수행했다. 명령은 도우미가 안내하고 학습자가 실행했다. 출력 블록은 학습자가 대화로 제공한 실제 텍스트다. 실행 완료만 보고한 명령은 가상의 프롬프트·출력을 붙이지 않는다.

## 위치·폴더 생성·이동

`pwd`의 실제 출력:

```text
/home/llcckk/workshop/web
```

`cd ..`, `mkdir cli-review` 수행을 보고했다. `ls -ld cli-review`의 실제 출력:

```text
drwxr-xr-x 2 llcckk llcckk 4096 Nov 10 20:43 cli-review
```

`cd cli-review`로 이동했다고 보고했다. 명령·옵션 풀이: cd는 change directory, mkdir는 make directory, ls는 list, -l은 long listing format, -d는 directory(디렉터리 내부 대신 자체 표시). ls의 -ld와 -dl은 이 경우 같은 옵션 조합이다.

## 빈 파일·내용 저장

`touch original.txt` 수행 보고 후 `ls -l original.txt`의 실제 출력:

```text
-rw-r--r-- 1 llcckk llcckk 0 Nov 10 20:45 original.txt
```

내용 저장 명령:

```bash
echo "CLI 복습 기록" > original.txt
```

수행 보고 후 `cat original.txt`의 실제 출력:

```text
CLI 복습 기록
```

touch는 기존 파일의 시간 정보를 갱신하고 파일이 없으면 빈 파일을 만든다. echo의 출력을 >로 저장했다. cat은 concatenate에서 온 이름이다.

## 복사·이름 변경

`cp original.txt copy.txt` 수행 보고 후 `cat copy.txt` 실제 출력:

```text
CLI 복습 기록
```

`mv copy.txt renamed.txt` 수행 보고 후 `ls -l` 실제 출력:

```text
total 8
-rw-r--r-- 1 llcckk llcckk 18 Nov 10 20:45 original.txt
-rw-r--r-- 1 llcckk llcckk 18 Nov 10 20:46 renamed.txt
```

cp는 copy, mv는 move다. 원본과 복사본 내용이 같고, 이름 변경 후 목록에서 copy.txt 대신 renamed.txt가 확인된다.

## 폴더로 이동·삭제·숨김 목록

`mkdir moved`, `mv renamed.txt moved/` 수행 보고 후 `ls -l moved/`의 실제 출력:

```text
total 4
-rw-r--r-- 1 llcckk llcckk 18 Nov 10 20:46 renamed.txt
```

`rm moved/renamed.txt` 수행 보고 후 `ls -la moved/`의 실제 출력:

```text
total 8
drwxr-xr-x 2 llcckk llcckk 4096 Nov 10 20:50 .
drwxr-xr-x 3 llcckk llcckk 4096 Nov 10 20:47 ..
```

rm은 remove, -a는 all(숨김 항목 포함)이다. 삭제 후 renamed.txt는 없고 .(현재 디렉터리)와 ..(부모 디렉터리)만 표시된다. 원본 original.txt는 삭제 대상으로 삼지 않았다. total은 개수가 아니라 목록 항목의 디스크 할당 공간 합계이며 이 환경의 기본 1KiB 단위 표시다. 상세 행의 18은 파일 내용의 바이트 크기다.

## 검증 범위

위치 확인, 폴더 생성·이동, 빈 파일 생성, 내용 저장·조회, 복사, 이름 변경, 폴더 이동, 삭제, 숨김 목록을 실제 출력과 실행 보고로 연결했다. 출력이 없는 명령의 성공 메시지를 만들지 않았다. 절대·상대 경로 사례와 초기 실습은 [앞선 CLI 기록](cli.md)에 있다.
