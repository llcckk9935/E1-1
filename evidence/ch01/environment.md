# 챕터 1 — 환경 확인 기록

이 문서는 학습자가 대화에 제공한 출력과 보고를 도우미가 정리한 기록이다. 원본 출력이 없는 설치 과정은 성공 로그로 재구성하지 않았다. 실행 일시는 별도로 제공되지 않아 기재하지 않는다.

## 확인 환경

- Windows PowerShell 프롬프트: `PS C:\WINDOWS\system32>`
- Windows: Microsoft Windows 11 Home, 버전 10.0.26200, 빌드 26200 (아래 실제 출력으로 확인).
- Windows PowerShell: PSVersion 5.1.26100.9711, PSEdition Desktop (아래 실제 출력으로 확인).
- 터미널 앱 이름: 미확인.
- Ubuntu 설치·셸 진입·기본 명령 실행·WSL 2 등록은 아래 후속 출력으로 확인.

## 설치 시작 — 학습자 보고

학습자는 `wsl --status` 실행 후 설치되지 않았다는 안내를 보고 `wsl.exe --install`로 설치를 시작했다고 보고했다. 설치 완료 안내 화면으로 넘어가 설치 명령의 출력 원문은 확보하지 못했다. 이는 구두 보고이며 설치 출력 증거와 구분한다.

## 설치 후, 재시작 전 — 실제 제공 출력

```text
PS C:\WINDOWS\system32> wsl --status
기본 버전: 2
현재 컴퓨터 구성에서는 WSL1이 지원되지 않습니다.
WSL1을 사용하려면 "Windows Subsystem for Linux” 선택적 구성 요소를 사용하세요.
가상화가 활성화되지 않은 이 컴퓨터에서는 WSL2를 시작할 수 없습니다.
컴퓨터의 펌웨어 설정에서 ‘가상 머신 플랫폼’ 선택적 구성 요소가 활성화되고, 가상화가 켜져 있는지 확인하세요.

‘가상 머신 플랫폼’을 활성화기 위해 다음 명령 실행: wsl.exe --install --no-distribution

자세한 내용을 알아보려면 https://aka.ms/enablevirtualization을 방문하세요.
PS C:\WINDOWS\system32>
```

학습자는 설치 후 아직 재시작하지 않았다고 보고했다. 이후 Windows 다시 시작을 수행했다고 보고했다.

## 재시작 후 — 실제 제공 출력

학습자 메시지의 마지막 “그래도 이렇게 떠”는 출력에 대한 설명이므로 아래 출력에서 분리했다.

```text
PS C:\WINDOWS\system32> wsl --status
기본 버전: 2
현재 컴퓨터 구성에서는 WSL1이 지원되지 않습니다.
WSL1을 사용하려면 "Windows Subsystem for Linux” 선택적 구성 요소를 사용하세요.
```

## 검증과 한계

- 기본 WSL 버전 설정은 2로 표시된다.
- 재시작 후 제공된 출력에서는 WSL 2 가상화 관련 실행 불가 안내가 사라졌다.
- WSL 1 관련 안내는 남아 있다. 학습 경로는 WSL 2이므로 WSL 1 활성화를 이번 해결 목표로 삼지 않는다.
- 이 출력으로 Ubuntu 설치 또는 정상 실행까지 증명하지 않는다. 배포판 목록·버전·실행은 후속 검증 대상이다.
- 재시작 전후 사용자 제공 텍스트에서 비밀번호·토큰·개인키·인증 코드는 식별되지 않았다.

## 배포판 목록 확인 — 실제 제공 출력

```text
PS C:\WINDOWS\system32> wsl --list --verbose
Linux용 Windows 하위 시스템 설치된 배포가 없습니다.
아래 지침에 따라 배포를 설치하여 이 resolve 수 있습니다.

사용 가능한 배포를 나열하려면 'wsl.exe --list --online' 사용
설치하려면 'wsl.exe --install <Distro>'를 선택하세요.
```

학습자 설명인 “라고 나왔고”는 출력과 분리했다. 현재 명령을 실행한 Windows 사용자에게 등록된 배포판이 없음을 확인했다. 우분투는 아직 설치 완료로 기록하지 않는다. 다음 작업은 우분투를 지정하여 설치하는 것이며 실행 결과는 대기 중이다.

이해도 확인: 학습자는 배포판 목록에 표시되는 것과 배포판 안에서 명령이 정상 실행되는 것은 “다른 확인이다”라고 답했다. 설치 상태 확인과 실제 동작 검증의 구분을 확인했다.

## 우분투 지정 설치 — 실제 제공 출력

제출용 기록에서는 사용자 이름을 `[USER]`로 마스킹했다. 아래의 계정 입력 줄만 마스킹했으며 나머지는 제공된 출력이다.

```text
PS C:\WINDOWS\system32> wsl --install -d Ubuntu
다운로드 중: Ubuntu
설치 중: Ubuntu
배포가 설치되었습니다. 'wsl.exe -d Ubuntu'을(를) 통해 시작할 수 있습니다.
Ubuntu 시작하는 중...
Provisioning the new WSL instance Ubuntu
This might take a while...
Create a default Unix user account: [USER]
```

배포판 설치 완료 메시지와 초기 사용자 계정 생성 안내를 확인했다. 사용자 이름 입력 확정, 비밀번호 설정, 셸 진입 및 WSL 2 실행 여부의 목록 검증은 아직 완료로 기록하지 않는다. 다음 단위는 사용자 이름 확정이다.

## 초기 계정 설정 — 실제 후속 출력 발췌

학습자가 같은 설치 명령의 이어진 출력을 제공했다. 앞선 다운로드·설치 메시지는 위와 중복되어 생략했고, 사용자 이름은 마스킹했다. 비밀번호 값은 제공되지 않았다.

```text
Create a default Unix user account: [USER]
New password:
Retype new password:
passwd: password updated successfully
usermod: no changes
Help improve Ubuntu!

Help us improve Ubuntu features and compatibility by sharing system reports with Canonical.
Reports are sent anonymously and do not contain any personal data.
For legal details, please visit: https://ubuntu.com/legal/systems-information-notice

We will save your answer to Windows and will only ask you once.

Would you like to opt-in to platform metrics collection (Y/n)? To see an example of the data collected, enter 'e'.
[Y/n/e]: y
```

비밀번호 설정 성공 메시지와 계정 이름을 정했다는 학습자 보고를 확인했다. `usermod: no changes` 뒤에도 초기 설정이 이어졌으며 이 문구만으로 설치 실패라고 판단하지 않는다. 현재 정보 수집 참여 질문에 y가 입력된 화면이다. 입력 확정 여부, 초기 설정 종료와 셸 진입은 미확인이다. 위 수집 설명은 화면 출력 인용이며 도우미가 수집 데이터 전체를 별도로 검증했다는 뜻은 아니다.

이해도 확인: 학습자는 배포판 지정 부분을 `-d Ubuntu`라고 정확히 답했다. `-d`는 `--distribution`의 짧은 표기임을 추가 설명했다.

## 초기 설정 종료와 셸 진입 — 실제 후속 출력

학습자는 정보 수집 참여 의사를 명시했고 아래 후속 출력을 제공했다. 사용자 이름과 컴퓨터 이름은 제출용 기록에서 마스킹했다.

```text
We will save your answer to Windows and will only ask you once.

Would you like to opt-in to platform metrics collection (Y/n)? To see an example of the data collected, enter 'e'.
[Y/n/e]: y
[USER]@[HOST]:/mnt/c/WINDOWS/system32$
```

초기 설정을 마치고 우분투 셸의 명령 입력 대기 화면에 진입한 것을 확인했다. `/mnt/c/WINDOWS/system32`는 WSL에서 보이는 Windows C 드라이브의 해당 경로이며, 아직 사용자의 Linux 홈 디렉토리로 이동하지 않았다. 우분투 안에서 실습 명령 실행 및 `wsl --list --verbose`를 통한 배포판의 WSL 버전 검증은 후속 작업이다.

현재 우분투 설치·계정 설정·셸 진입은 확인했지만, 챕터 1 전체나 WSL 2 버전 검증 완료로 표시하지 않는다.

## 홈 디렉토리 이동 — 실제 제공 출력

사용자 이름과 컴퓨터 이름을 마스킹했다.

```text
[USER]@[HOST]:/mnt/c/WINDOWS/system32$ cd ~
[USER]@[HOST]:~$
```

프롬프트의 작업 위치가 Windows 시스템 폴더에서 홈 디렉토리를 나타내는 `~`로 바뀐 것을 확인했다. 명령은 우분투 셸에서 실행했다. 홈의 실제 절대 경로는 아직 출력으로 확인하지 않았다.

이해도 확인:

- 학습자는 현재 명령을 우분투 셸이 처리한다고 답했다.
- 터미널과 셸을 설명한 뒤, 명령을 해석하는 프로그램을 “셸”이라고 답했다. 정확한 셸 종류는 아직 명령으로 확인하지 않았다.
- `cd ~` 실행 후 “~은 홈디렉토리를 말해”라고 설명했다.

## 홈 디렉토리 실제 경로 확인 — 실제 제공 출력

사용자 이름과 컴퓨터 이름을 마스킹했다. 출력 경로에서도 사용자 이름 부분만 마스킹했다.

```text
[USER]@[HOST]:~$ pwd
/home/[USER]
[USER]@[HOST]:~$
```

홈 디렉토리 실제 경로가 `/home/` 아래 사용자 디렉토리임을 확인했다. 학습자는 “cd는 이동 pwd print working directory 현재 작업 장소 확인”이라고 답하여 위치 변경과 위치 확인의 차이를 설명했다.

다음 예정 작업은 `exit`로 현재 우분투 셸을 종료하고 돌아온 화면을 확인하는 것이다. 종료 후 화면이나 배포판의 WSL 버전은 아직 확인하지 않았다.

## 우분투 셸 종료 — 실제 제공 출력

사용자 이름과 컴퓨터 이름을 마스킹했다.

```text
[USER]@[HOST]:~$ exit
exit
PS C:\WINDOWS\system32>
```

현재 우분투 셸을 종료하고 PowerShell 프롬프트로 돌아온 것을 확인했다. 학습자는 삭제되는 것이 아니라 PowerShell로 돌아오는 것이라고 설명했다. 이는 배포판 삭제나 WSL 전체 종료를 검증한 작업이 아니다.

다음 예정 작업은 PowerShell에서 `wsl --list --verbose`로 등록된 우분투의 WSL 버전을 확인하는 것이다.

## 설치된 배포판의 WSL 버전 확인 — 실제 제공 출력

```text
PS C:\WINDOWS\system32> wsl --list --verbose
  NAME      STATE           VERSION
* Ubuntu    Stopped         2
```

학습자 설명인 “wsl 2 는 버젼이지”는 출력과 분리했다. Ubuntu가 등록되어 있고 WSL 버전이 2임을 확인했다. `Stopped`는 조회 시 실행 중이 아닌 상태이며 설치 실패를 뜻하지 않는다. `*`는 기본 배포판 표시다. 앞서 우분투 셸 진입과 명령 실행도 확인했으므로 배포판 설치·기본 사용·WSL 버전 확인의 증거가 확보됐다.

이해도 확인: 학습자는 WSL 2의 버전 항목을 식별했다. `--verbose`는 상세 출력을 요청하는 옵션임을 추가 설명했다.

챕터 1 전체는 아직 완료가 아니다. Windows·셸·터미널 상세 환경 및 Git·VS Code·Docker 상태 확인이 남아 있다.

## Windows 상세 버전 확인 — 실제 제공 출력

```text
PS C:\WINDOWS\system32> Get-CimInstance Win32_OperatingSystem | Select-Object Caption, Version, BuildNumber

Caption                   Version    BuildNumber
-------                   -------    -----------
Microsoft Windows 11 Home 10.0.26200 26200
```

Windows 제품 이름은 Windows 11 Home이며 시스템 버전은 10.0.26200, 빌드 번호는 26200이다. 시스템 버전의 `10.0`을 근거로 Windows 10으로 기록하지 않는다. 이 명령은 운영체제 정보를 조회하며 설정을 변경하지 않는다. 학습자는 “이건 정보를 조회하는 명령어지”라고 답하여 조회와 설정 변경의 구분을 확인했다.

## PowerShell 버전 확인 — 실제 제공 출력

```text
PS C:\WINDOWS\system32> $PSVersionTable

Name                           Value
----                           -----
PSVersion                      5.1.26100.9711
PSEdition                      Desktop
PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0...}
BuildVersion                   10.0.26100.9711
CLRVersion                     4.0.30319.42000
WSManStackVersion              3.0
PSRemotingProtocolVersion      2.3
SerializationVersion           1.1.0.1
```

학습자는 “이건 파워쉘 버젼이야”라고 답했다. 현재 실행 중인 셸이 Windows PowerShell 5.1이며 PSVersion은 5.1.26100.9711이다. 이 표로 터미널 앱의 이름이나 우분투 내부 셸의 버전을 확인한 것은 아니다. 다음 작업은 Windows PowerShell에서 Git 버전 조회다.

## Windows Git 버전 확인 — 실제 제공 출력

안내한 `git --version`에 대해 학습자가 아래 출력을 제공했다. 입력 명령 줄은 메시지에 포함되지 않았으므로 실행 화면 원문으로 재구성하지 않았다.

```text
git version 2.55.0.windows.5
```

현재 Windows PowerShell에서 Git을 실행할 수 있음을 확인했다. 우분투 내부 Git 설치 여부나 Git 사용자 설정·GitHub 연결까지 확인한 것은 아니다.

이해도 확인: 학습자는 Git을 “파일의 변경 이력을 관리하는 프로그램이다”라고 설명했다.

## VS Code 버전 확인 — 출력 재확인 대기

`code --version` 안내 후 학습자가 아래 텍스트를 제공했다.

```text
git versio1.144.1
261c84cb1eddf11235f9e2c921425e9663fbe556
x64n 2.55.0.windows.5
```

Git 버전 문구와 섞인 형태이므로 VS Code의 정확한 버전 출력으로 확정하지 않는다. 같은 명령을 다시 실행하여 명령 줄과 출력 전체를 확인할 예정이다.

이해도 확인: 학습자는 VS Code를 “코드를 편집하고 작업 폴더를 열때 사용할 도구다”라고 정확히 설명했다.

## VS Code 버전 재확인 — 실제 제공 출력

같은 `code --version` 명령 재실행 안내에 대해 학습자가 아래 출력을 제공했다. 입력 명령 줄은 제공되지 않았으므로 아래에는 출력만 보존한다.

```text
1.144.1
261c84cb1eddf11235f9e2c921425e9663fbe556
x64
```

VS Code 명령의 버전 1.144.1, 빌드 식별자 및 x64 표시를 확인했다. VS Code 화면 실행·WSL 연결·GitHub 로그인은 아직 확인하지 않았다. 앞서 섞여 제공된 텍스트 대신 이번 분리된 출력을 버전 확인 근거로 사용한다.

## Docker 명령 확인 — 실제 오류 출력

`docker --version` 안내 후 학습자가 아래 오류를 제공했다.

```text
docker : 'docker' 용어가 cmdlet, 함수, 스크립트 파일 또는 실행할 수 있는 프로그램 이름으로 인식되지 않습니다. 이름이 정
확한지 확인하고 경로가 포함된 경우 경로가 올바른지 검증한 다음 다시 시도하십시오.
위치 줄:1 문자:1
+ docker --version
+ ~~~~~~
    + CategoryInfo          : ObjectNotFound: (docker:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CommandNotFoundException
```

현재 PowerShell에서 Docker 명령을 찾지 못함을 확인했다. Docker 미설치인지 설치 위치·명령 검색 경로 문제인지는 미확정이다. 데몬 동작 여부는 이 오류로 판단할 수 없다. 다음은 Docker Desktop 기본 설치 위치의 실행 파일 존재 확인이다. 기본 위치에 없더라도 다른 위치 설치 가능성을 배제하지 않는다.

이해도 확인: 학습자는 웹 요청에 HTML을 응답하는 프로그램이 웹 서버라고 답했다.

## Docker Desktop 기본 경로 확인 — 학습자 제공 결과

아래 안내 명령에 대해 학습자가 `false`라고 결과를 전달했다. 실행 화면 전체는 제공되지 않았으므로 명령과 보고 결과를 구분한다.

안내 명령:

```powershell
Test-Path 'C:\Program Files\Docker\Docker\Docker Desktop.exe'
```

제공 결과:

```text
false
```

해당 기본 경로에 파일이 없다는 결과다. 다른 경로 설치나 Docker CLI 단독 설치 여부는 아직 확인하지 않았다. 학습자는 검색한 경로에 없다는 의미라고 답하여 결과 해석의 범위를 정확히 구분했다. 다음은 Windows 시작 메뉴에 등록된 앱 중 Docker 이름이 포함된 항목을 조회하는 것이다. 이 목록만으로 모든 설치 위치를 조사한 것으로 판단하지 않는다.

## 시작 메뉴의 Docker 항목 조회 — 학습자 제공 결과

안내 명령:

```powershell
Get-StartApps | Where-Object { $_.Name -like '*Docker*' }
```

학습자는 “출력없음”이라고 보고했다. 오류 보고는 없으며, 이름에 Docker가 포함된 시작 메뉴 항목이 표시되지 않았다는 결과다. 모든 설치 경로에 Docker가 없음을 증명한 것은 아니다.

이해도 확인: 학습자는 파이프가 왼쪽 결과를 “오른쪽으로” 전달한다고 답했다. 다음 작업은 Docker Desktop 설치 준비를 위한 WSL 프로그램 버전 조회다.

## WSL 프로그램 버전 — 실제 제공 출력

`wsl --version` 안내에 대해 학습자가 아래 텍스트를 제공했다. 명령 입력 줄은 제공되지 않았다. 마지막 줄의 `/wsl`은 원문 그대로 보존하며 버전 번호의 일부로 해석하지 않는다.

```text
WSL 버전: 3.0.3.0
커널 버전: 6.18.54.1-1
WSLg 버전: 1.0.79
MSRDC 버전: 1.2.7391
Direct3D 버전: 1.611.1-81528511
DXCore 버전: 10.0.26100.1-240331-1435.ge-release
Windows 버전: 10.0.26200.9711/wsl
```

WSL 프로그램 버전 3.0.3.0과 커널 버전 6.18.54.1-1을 확인했다. 배포판 목록의 VERSION 2와는 다른 버전 정보다. 학습자는 “wsl버전”이라고 답하여 Ubuntu 버전과 구분했다. 현재 명령만으로 Docker 실행 준비 전체가 완료됐다고 판단하지 않는다. 다음 확인은 시스템 종류와 물리 메모리 용량 조회다.

## 시스템 종류와 메모리 — 실제 제공 출력

`Get-CimInstance Win32_ComputerSystem | Select-Object SystemType, TotalPhysicalMemory` 안내에 대해 아래 출력을 제공받았다. 입력 명령 줄은 제공되지 않았다.

```text
SystemType   TotalPhysicalMemory
----------   -------------------
x64-based PC         29734412288
```

x64 시스템과 물리 메모리 29,734,412,288바이트를 확인했다. 1GiB = 1,073,741,824바이트로 환산하면 약 27.7GiB이며, Docker 공식 안내의 메모리 8GB 조건을 충족하는 용량이다. 이 값으로 장착 모듈의 명목 용량이나 다른 모든 하드웨어 조건을 확정하지 않는다.

이해도 확인: 학습자는 RAM을 “실행중인 프로그램이 사용하는 공간”이라고 답했다.

Docker 공식 안내에는 모든 사용자 설치 경로 외에 사용자별 경로 `%LOCALAPPDATA%\Programs\DockerDesktop`도 명시돼 있다. 앞선 기본 경로 검사만으로 이 위치까지 확인한 것은 아니므로 설치 전 사용자별 실행 파일의 존재 여부도 확인할 예정이다.

참고: https://docs.docker.com/desktop/setup/install/windows-install/

## Docker Desktop 사용자별 경로 확인 — 학습자 제공 결과

안내 명령:

```powershell
Test-Path "$env:LOCALAPPDATA\Programs\DockerDesktop\Docker Desktop.exe"
```

학습자는 `false`라고 결과를 전달했다. 해당 사용자별 기본 경로에도 실행 파일이 없다는 결과로 기록한다. 다른 사용자나 임의의 설치 경로까지 조사한 것은 아니다.

학습자는 LOCALAPPDATA 관련 이해도 질문을 이해하기 어렵다고 밝혔고 현재 사용자에 맞는 경로를 제공하는 환경 변수라는 개념을 예시로 다시 설명했다. 지수로 로그인한 예시에서 누구의 경로인지 묻자 “지수”라고 정확히 답했다. 다음 단계는 공식 배포 주소에서 설치 파일 다운로드이며 다운로드·설치는 아직 수행 결과를 받지 않았다.

## Docker Desktop 설치 파일 다운로드 — 실제 제공 화면

```powershell
PS C:\WINDOWS\system32> Invoke-WebRequest -UseBasicParsing -Uri 'https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe' -OutFile "$env:TEMP\DockerDesktopInstaller.exe"
PS C:\WINDOWS\system32>
```

학습자는 다운로드 도중 요청 진행 표시와 바이트 수 증가를 보고했고, 이후 위와 같이 오류 메시지 없이 PowerShell 프롬프트로 복귀한 화면을 제공했다. 다운로드와 설치를 구분하고 설치 여부를 별도로 확인해야 한다고 답했다.

현재 확인 범위는 다운로드 명령이 오류 표시 없이 종료됐다는 점이다. 저장된 파일의 존재·크기 및 설치 실행은 아직 확인하지 않았다. 다음은 Get-Item으로 저장 대상 파일의 이름과 크기를 조회하는 것이다.

## 설치 파일 이름과 크기 확인 — 실제 제공 출력

`Get-Item "$env:TEMP\DockerDesktopInstaller.exe" | Select-Object Name, Length` 안내 후 아래 출력을 제공받았다.

```text
Name                          Length
----                          ------
DockerDesktopInstaller.exe 623748528
```

임시 폴더에 설치 파일이 있으며 크기가 623,748,528바이트임을 확인했다. 파일 존재와 크기만 검증했으며 설치 완료나 파일의 완전성·서명 확인까지 검증한 것은 아니다. 학습자는 이 명령이 “정보 조회”라고 정확히 답했다.

다음 단위는 설치 실행 전 설치 파일의 디지털 서명 조회다.

## 설치 파일 디지털 서명 확인 — 실제 제공 출력

안내 명령:

```powershell
Get-AuthenticodeSignature "$env:TEMP\DockerDesktopInstaller.exe" | Format-List Status, SignerCertificate
```

학습자가 제공한 출력:

```text
Status            : Valid
SignerCertificate : [Subject]
                      CN=Docker Inc, O=Docker Inc, L=Palo Alto, S=California,
                    C=US, SERIALNUMBER=4817464, OID.2.5.4.15=Private Organizat
                    ion, OID.1.3.6.1.4.1.311.60.2.1.2=Delaware, OID.1.3.6.1.4.
                    1.311.60.2.1.3=US

                    [Issuer]
                      CN=DigiCert Trusted G4 Code Signing RSA4096 SHA384 2021
                    CA1, O="DigiCert, Inc.", C=US

                    [Serial Number]
                      0DCE683683AE70C7C647ADDB7E609A9A

                    [Not Before]
                      2026-06-26 오전 9:00:00

                    [Not After]
                      2027-06-26 오전 8:59:59

                    [Thumbprint]
                      B6BD29272B07AD4D0F1322A739499D67CA3BAC3F
```

PowerShell이 서명 상태를 Valid로 보고했고 서명 인증서의 발행 주체가 Docker Inc임을 확인했다. 이 공개 서명 인증서 정보는 학습자의 개인키가 아니다. 파일 존재·크기 확인과 서명 검증은 구분하며 설치·데몬 실행까지 완료했다는 뜻으로 확대하지 않는다.

이해도 확인: 학습자는 크기 확인과 서명 확인이 “다른 작업임”이라고 답했다. 다음 단위는 설치 프로그램 실행이다. 설치 결과는 아직 대기 중이다.

## Docker Desktop 설치 실행 — 실제 제공 로그 발췌

안내 명령:

```powershell
Start-Process -FilePath "$env:TEMP\DockerDesktopInstaller.exe" -ArgumentList 'install','--user','--backend=wsl-2' -Wait
```

학습자가 제공한 설치 로그 마지막 3줄:

```text
[2026-11-04T00:10:53.192392700Z][InstallWorkflow][I] Phase 5: Validation
[2026-11-04T00:10:53.200989900Z][InstallWorkflow][I] Phase 6: Cleanup
[2026-11-04T00:10:53.200989900Z][InstallWorkflow][I] Installation succeeded
```

설치 프로그램이 성공을 보고한 것을 확인했다. Docker 명령의 인식, Docker Desktop 최초 실행, 데몬 동작 및 컨테이너 실행은 아직 별도 검증 전이다. 학습자는 이번 명령이 설치 프로그램을 실행한다고 정확히 설명했다.

다음은 새 PowerShell 창에서 `docker --version`을 실행하여 설치 후 명령 사용 가능 여부를 확인하는 것이다. 기존 셸에 설치 후 PATH 변경이 반영되지 않을 수 있어 새 창을 사용한다.

## 설치 후 Docker 명령 재검증 — 실제 제공 출력

새 PowerShell 창에서 `docker --version`을 실행하도록 안내한 뒤 학습자가 아래 출력을 제공했다.

```text
Docker version 29.9.2, build a82e528
```

기존 명령 미인식 오류 대신 버전이 표시되어 Docker CLI 실행과 버전 29.9.2를 확인했다. Docker Desktop 앱 버전이나 데몬 실행은 아직 미검증이다. 학습자는 새 창을 여는 이유를 “설치로 변경된 path를 반영하기 위해서”라고 답한 뒤 PATH의 의미를 질문했다. 다음은 명령 프로그램을 검색하는 폴더 목록인 PATH의 개념 설명과 이해도 확인이다.

## Docker 엔진 응답 확인

`docker info` 실제 출력에서 Client 정보는 조회됐지만 Server 연결은 실패했다. [마스킹한 출력 전체와 해석](docker-info.md)을 별도로 저장했다. CLI 실행 성공과 엔진 동작을 구분한다. Docker Desktop 최초 실행 여부와 엔진 상태는 확인 전이며, CLI/엔진 역할에 대한 이해도 답변은 대기 중이다.

## Docker 엔진 응답 재검증

Docker Desktop을 실행하고 약관 동의·로그인 건너뛰기 후 `docker info` 재실행 출력에서 Client와 Server 모두 정상 정보가 반환됐다. 컨텍스트 desktop-linux, Server Version 29.9.2, OSType linux, WSL2 커널, Containers 0, Images 0을 확인했다. [전후 비교와 실제 출력 발췌](docker-info.md).

CLI 사용과 엔진 응답까지 검증했으며 컨테이너 실행 실습은 아직 하지 않았다. 우분투 내부 Docker CLI 연결, 우분투 버전·셸 종류, 터미널 앱 이름 등 남은 환경 명세도 별도 확인 대상이다.

## 우분투 재진입 — 학습자 보고

PowerShell에서 `wsl -d Ubuntu`를 안내한 뒤 학습자가 “실행하는거고 실행했어”라고 답했다. 설치가 아닌 기존 배포판 실행임을 이해한 것을 확인했다. 이 단계의 실제 프롬프트 출력은 제공되지 않았으므로 실행 화면을 만들어 기록하지 않는다. 다음 작업은 우분투에서 `/etc/os-release` 내용을 조회해 배포판 버전을 확인하는 것이다.

## 우분투 버전 확인 — 실제 제공 출력

우분투에서 `cat /etc/os-release` 실행 안내 후 학습자가 제공한 출력:

```text
PRETTY_NAME="Ubuntu 26.04.1 LTS"
NAME="Ubuntu"
VERSION_ID="26.04"
VERSION="26.04.1 LTS (Resolute Raccoon)"
VERSION_CODENAME=resolute
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=resolute
LOGO=ubuntu-logo
```

실제 파일 내용에서 Ubuntu 26.04.1 LTS와 VERSION_ID 26.04를 확인했다. 학습자는 cat이 내용을 보여주는 명령이라고 정확히 답했다. 다음은 현재 실행 중인 셸의 프로세스 이름 조회다.

## 현재 셸 확인 — 학습자 제공 결과

안내 명령:

```bash
ps -p $$ -o comm=
```

학습자는 `bash`가 나왔다고 보고했다. 현재 셸 프로세스의 이름이 Bash임을 확인했다. 셸 버전까지 조회한 것은 아니다.

학습자는 실행 중인 프로그램을 프로세스라고 하므로 셸도 프로세스라고 부를 수 있다고 정확히 설명했다. 다음은 우분투에서 Docker CLI의 사용 가능 여부 확인이다. Windows PowerShell의 Docker 실행 성공을 우분투 내부의 성공으로 대신 기록하지 않는다.

## 우분투 내부 Docker CLI 확인 — 실제 제공 출력

우분투 Bash에서 `docker --version` 실행 안내 후 제공받은 출력:

```text
Docker version 29.9.2, build a82e528
```

우분투에서 실행하도록 안내한 뒤 Docker CLI 버전 29.9.2 출력을 제공받았다. 학습자는 Windows 실행 결과만으로 우분투 실행을 확정할 수 없다고 정확히 답했다. 다만 후속 docker info에서 Windows 형식의 플러그인 경로가 표시돼 실제 명령 실행 환경을 재확인 중이다. 이 버전 출력만으로 Linux용 CLI의 위치나 우분투 내부 연결 성공을 확정하지 않는다.

## 우분투 연결 점검 중 오류 — 실행 환경 재확인 대기

우분투에서 `docker info`를 실행하도록 안내한 뒤 실제 출력 전체를 제공받았다. 아래는 핵심 발췌이며 플러그인 목록의 나머지는 생략했고 사용자 이름을 마스킹했다.

```text
Client:
 Version:    29.9.2
 Context:    desktop-linux
 Debug Mode: false
 Plugins:
  agent: Docker AI Agent Runner (Docker Inc.)
    Version:  v1.152.0
    Path:     C:\Users\[USER]\.docker\cli-plugins\docker-agent.exe
```

같은 출력의 Server 오류:

```text
Server:
ERROR: Error response from daemon: The command 'docker' could not be found in this WSL 2 distro.
We recommend to activate the WSL integration in Docker Desktop settings.
For details about using Docker Desktop with WSL 2, visit: https://docs.docker.com/go/wsl2/
errors pretty printing info
```

학습자는 버전 조회뿐 아니라 엔진 통신도 확인하는 작업이라고 답했다. WSL Integration 설정을 확인해야 할 가능성이 있지만, 출력의 Windows 경로와 실행 프롬프트 부재를 고려해 먼저 현재 실행 환경을 `uname -s`로 확인한다. 실제 원인·설정 변경·연결 성공은 아직 미확인이다.

## 오류 진단을 위한 실행 환경 확인 — 학습자 보고

같은 창에서 `uname -s`를 실행하도록 안내했고 학습자는 Linux가 나왔다고 보고했다. 학습자는 실행 환경을 조회하는 작업이라고 정확히 답했다. 실제 명령 줄·프롬프트는 제공되지 않았으며 Linux 결과만으로 Docker CLI 경로까지 확인한 것은 아니다.

다음은 Docker Desktop의 Settings > Resources > WSL Integration에서 Ubuntu 연결 설정의 현재 상태를 확인하는 것이다. 아직 설정을 변경하거나 연결을 재검증한 것으로 기록하지 않는다.

## Ubuntu WSL Integration 설정 확인 — 학습자 보고

학습자는 Docker Desktop의 Settings > Resources > WSL Integration 화면에서 Ubuntu 스위치가 꺼져 있다고 보고했다. WSL 연결 비활성화 상태라는 가설을 뒷받침한다. 다음 조치는 Ubuntu 스위치를 켜고 Apply 또는 Apply & Restart로 적용하는 것이다. 설정 변경 완료와 docker info 재검증은 아직 확인하지 않았다.

## WSL Integration 적용 후 재검증 — 실제 출력 발췌

학습자가 설정 완료를 보고한 뒤 우분투에서 `docker info` 재실행을 안내했다. 다음은 실제 출력의 핵심 발췌다. 다른 플러그인 항목은 생략했다.

```text
Client:
 Version:    29.9.2
 Context:    default
 Debug Mode: false
 Plugins:
  agent: Docker AI Agent Runner (Docker Inc.)
    Version:  v1.152.0
    Path:     /usr/local/lib/docker/cli-plugins/docker-agent
```

Server 부분의 실제 오류:

```text
Server:
permission denied while trying to connect to the docker API at unix:///var/run/docker.sock
```

기존 WSL Integration 안내 오류에서 Unix 소켓 접근 권한 오류로 증상이 바뀌었다. Linux 형식의 플러그인 경로를 확인했으나 엔진 연결 성공은 아직 미검증이다. 현재 사용자 그룹과 소켓 권한을 확인한다.

## 소켓 접근 오류 진단: 현재 사용자 그룹

`id` 안내 후 학습자가 제공한 출력이다. 사용자 이름만 마스킹했다.

```text
uid=1000([USER]) gid=1000([USER]) groups=1000([USER]),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),100(users)
```

현재 세션 그룹에 docker가 없다. 계정에 등록됐지만 현재 세션에 반영되지 않은 경우는 아직 배제하지 않는다. 소켓의 실제 소유 그룹과 권한은 아직 확인하지 않았으므로 원인을 확정하지 않는다. 다음 단위는 `ls -l /var/run/docker.sock` 조회이며 권한 변경은 아직 수행하지 않았다.

- [트러블슈팅 TS-01](../../docs/troubleshooting.md#ts-01-wsl-설치-후-가상화-관련-실행-불가-안내)
 
## Docker 소켓 권한 확인 — 실제 제공 출력

`ls -l /var/run/docker.sock` 안내 후 제공받은 출력:

```text
srw-rw---- 1 root docker 0 Nov  4 11:33 /var/run/docker.sock
```

소켓 파일(s)의 소유자는 root, 그룹은 docker이고 접근 권한은 소유자 rw, 그룹 rw, 그 외 사용자 없음이다. 현재 세션의 id 결과에 docker가 없다는 사실은 접근 거부와 일치한다. 계정의 저장된 그룹 등록 여부는 아직 확인하지 않았으므로 다음은 `getent group docker`로 조회한다. 현재 세션 반영 문제인지 미등록 문제인지 구분한 뒤 조치를 정한다.
- README는 학습 진행에 따라 작성하며, 이 기록의 링크를 연결할 예정이다.
