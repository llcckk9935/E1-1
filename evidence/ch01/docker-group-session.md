# Docker 그룹 등록과 현재 세션 비교

사용자가 제공한 실제 결과이며 사용자 이름은 `[USER]`로 마스킹했다. 도우미의 직접 WSL 접근은 Wsl/Service/E_ACCESSDENIED로 실패했으므로 아래 출력을 도우미가 직접 실행한 것으로 기록하지 않는다.

## 현재 세션의 사용자·그룹

안내 명령: `id`

```text
uid=1000([USER]) gid=1000([USER]) groups=1000([USER]),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),100(users)
```

현재 세션의 그룹 목록에는 docker가 없다.

## 소켓 권한

안내 명령: `ls -l /var/run/docker.sock`

```text
srw-rw---- 1 root docker 0 Nov  4 11:33 /var/run/docker.sock
```

소유자 root와 소유 그룹 docker에 읽기·쓰기 권한이 있으며 그 외 사용자의 권한은 없다.

## 등록된 그룹 구성원

안내 명령: `getent group docker`

```text
docker:x:1001:[USER]
```

docker 그룹의 번호는 1001이고 계정이 구성원으로 등록되어 있다. `x`는 비밀번호 자체가 아닌 그룹 데이터의 비밀번호 필드 표시다.

## 판단과 다음 조치

그룹 구성원 등록과 현재 세션의 그룹이 서로 다르므로 세션에 docker 그룹이 미반영된 상태라는 판단을 뒷받침한다. 그룹 등록을 중복 수행하지 않는다. `newgrp docker`로 docker를 기본 그룹으로 사용하는 새 셸을 시작하도록 안내한다. 아직 조치 결과와 엔진 연결 성공은 확인하지 않았다. 이 새 셸에서 만드는 파일의 소유 그룹이 docker가 될 수 있으므로 진단 후 일반 실습에 앞서 셸 상태를 정리한다.

## newgrp 실행 오류와 대안

학습자가 제공한 실제 출력:

```text
Command 'newgrp' not found, but can be installed with:
sudo apt install util-linux-extra
```

newgrp 명령을 사용할 수 없어 새 그룹 셸은 시작되지 않았다. 화면에 제안된 패키지 설치 명령은 실행한 것으로 기록하지 않는다. 대안으로 현재 우분투 셸을 exit로 종료하고 PowerShell에서 우분투를 재실행해 그룹 정보를 새 세션에 반영한다. 이후 id와 docker info로 적용 여부·엔진 응답을 각각 검증할 예정이다. 현재 안내 단위는 exit로 현재 셸 종료다.

## 우분투 재진입 — 실제 시작 메시지 발췌

챕터 4 이후 exit와 wsl -d Ubuntu 재진입을 안내한 뒤 학습자가 시작 메시지를 제공했다. 아래는 운영체제와 시각 부분의 실제 발췌이며 개인 경로·내부 IP·기타 안내는 생략했다.

```text
Welcome to Ubuntu 26.04.1 LTS (GNU/Linux 6.18.54.1-microsoft-standard-WSL2 x86_64)
System information as of Thu Nov  5 14:19:28 KST 2026
```

우분투 재진입 후 시작 안내가 표시된 것을 확인했다. 아직 docker 그룹 반영이나 엔진 연결 복구를 성공으로 기록하지 않는다. 추가 진단을 최소화하기 위해 다음은 기존 실패 명령 docker info를 직접 재검증하고, 여전히 실패할 때만 그룹 정보를 추가 조회한다.

## 재진입 후 엔진 연결 재검증 — 실제 제공 출력 발췌

docker info 재실행 안내 후 학습자가 제공한 Server 앞부분이다.

```text
Server:
 Containers: 0
  Running: 0
  Paused: 0
  Stopped: 0
 Images: 0
 Server Version: 29.9.2
 Storage Driver: overlayfs
  driver-type: io.containerd.snapshotter.v1
 Logging Driver: local
 Cgroup Driver: cgroupfs
 Cgroup Version: 2
```

우분투 새 세션에서 권한 거부 대신 엔진의 정상 정보가 반환됐다. 계정의 docker 그룹 등록과 이전 세션의 미반영을 확인한 뒤 재진입하여 연결이 복구된 흐름이다. 재진입 후 id 자체를 다시 조회한 것은 아니므로 새 그룹 목록 출력을 만들어 기록하지 않는다. 컨테이너와 이미지는 아직 0으로, 컨테이너 실행 성공 증거는 별도 실습에서 확보한다.
