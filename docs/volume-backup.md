# 볼륨 백업·복원과 데이터 손실 대안

볼륨은 컨테이너 삭제와 별도로 유지되지만 백업은 아니다. 볼륨 자체 삭제, 잘못된 파일 수정, 저장 장치 고장에 대비해 별도 사본이 필요하다. 아래는 Ubuntu/WSL Bash용 재현 절차이며 이 문서 작성 시 새 백업·복원을 실행했다고 기록하지 않는다.

## 백업 전 확인

```bash
docker volume inspect workshop-data
docker ps --filter volume=workshop-data
```

해당 볼륨을 쓰는 프로그램의 쓰기를 중단한 뒤 일관된 시점에 백업한다. 데이터베이스는 먼저 DB 전용 dump/backup 도구를 사용한다. 실행 중인 DB 파일을 tar로 복사한 것만으로 일관된 백업을 보장할 수 없다.

## 파일 볼륨 백업

아래는 실습의 workshop-data가 존재하는 경우에 사용한다. inspect 실패 시 중단한다. 없는 이름으로 docker run을 실행해 빈 볼륨을 백업하지 않는다. 현재 폴더에서 새 백업 디렉터리를 만들고 tar를 저장한다.

```bash
backup_dir=$(mktemp -d "$(pwd)/volume-backup.XXXXXX")
docker run --rm \
  --mount type=volume,source=workshop-data,target=/data,readonly \
  --mount "type=bind,source=$backup_dir,target=/backup" \
  ubuntu tar -cpf /backup/workshop-data.tar -C /data .
docker run --rm \
  --mount "type=bind,source=$backup_dir,target=/backup,readonly" \
  ubuntu tar -tf /backup/workshop-data.tar
sha256sum "$backup_dir/workshop-data.tar"
```

tar는 tape archive에서 온 이름이다. -c는 create(생성), -p는 permissions(권한 처리), -f는 file(아카이브 파일 지정), -C는 먼저 이동할 디렉터리, -t는 목록 조회다. 압축하지 않은 tar 파일이며 원본 데이터 볼륨은 읽기 전용으로 연결한다. 이름에 날짜를 포함한 디렉터리나 저장소별 백업 정책을 사용하고, 체크섬 결과와 백업 일시를 함께 보관한다.

## 원본을 지우지 않고 새 볼륨에 복원 검증

원본 workshop-data를 삭제하지 않는다. 새 이름이 이미 존재하면 다른 이름을 선택하고, 기존 데이터가 있는 볼륨 위에 복원하지 않는다.

```bash
docker volume create workshop-data-restored-check
docker run --rm \
  --mount type=volume,source=workshop-data-restored-check,target=/restore \
  --mount "type=bind,source=$backup_dir,target=/backup,readonly" \
  ubuntu tar -xpf /backup/workshop-data.tar -C /restore
docker run --rm \
  --mount type=volume,source=workshop-data-restored-check,target=/data,readonly \
  ubuntu cat /data/memo.txt
```

- -x: extract, 아카이브 풀기.
- 다른 셸에서 복원한다면 backup_dir 변수를 실제 백업 디렉터리의 절대 경로로 다시 지정한다.
- 실습 메모뿐 아니라 중요한 파일의 목록·내용·권한과 서비스 정상 실행도 확인한다. 복원 검증 후 서비스의 볼륨 연결을 새 볼륨으로 전환할 수 있다.
- 볼륨을 의도적으로 삭제하기 전에는 사용할 수 있는 백업과 복원 검증을 먼저 확보한다. 삭제 후에는 새 볼륨을 만들고 백업을 풀어야 하며, 백업이 없는 삭제 데이터를 Docker가 자동 복구해 주지는 않는다.

## 추가 대안

백업 파일을 같은 노트북에만 두지 말고 외장 장치나 접근 제한된 원격 저장소에도 보관한다. 민감 데이터는 암호화하고 키를 백업과 별도로 관리한다. 스토리지 스냅샷을 지원한다면 복구 지점을 만들되, 동일 장치의 스냅샷만으로 장치 고장에 대비했다고 판단하지 않는다. Docker image export/save나 컨테이너 이미지화는 연결된 볼륨 데이터의 백업을 대신하지 않는다. 실제 데이터 백업 tar를 공개 GitHub 저장소에 올리지 않는다.

참고: [Docker 공식 볼륨 백업·복원 안내](https://docs.docker.com/engine/storage/volumes/#back-up-restore-or-migrate-data-volumes).
