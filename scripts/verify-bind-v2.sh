#!/usr/bin/env bash
# Ubuntu/WSL에서 실행. 실습용 컨테이너와 임시 폴더만 생성·정리한다.
set -euo pipefail

repo_root="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
log_path="$repo_root/evidence/ch07/bind-v2-runtime.log"
host_port="${BIND_HOST_PORT:-8083}"
mkdir -p -- "$(dirname -- "$log_path")"
exec > >(tee "$log_path") 2>&1
printf 'BIND_V2_VERIFICATION_STARTED=%s\n' "$(date -u +%FT%TZ)"
printf 'LOG_PATH=%s\n' "$log_path"

mount_dir=""
container_name="workshop-bind-v2-$(date +%s)-$$"
container_created=false
cleanup() {
    result=$?
    trap - EXIT
    set +e
    set -x
    if [ "$container_created" = true ]; then
        if [ "$result" -ne 0 ]; then docker logs "$container_name"; fi
        docker rm -f "$container_name"
        cleanup_result=$?
        if [ "$cleanup_result" -ne 0 ]; then result=1; fi
    fi
    if [ -n "$mount_dir" ]; then
        rm -f -- "$mount_dir/bind-check.txt"
        rmdir -- "$mount_dir"
        cleanup_result=$?
        if [ "$cleanup_result" -ne 0 ]; then result=1; fi
    fi
    set +x
    if [ "$result" -eq 0 ]; then
        printf 'VERIFICATION_RESULT=PASS\n'
    else
        printf 'VERIFICATION_RESULT=FAIL (exit=%s)\n' "$result"
    fi
    exit "$result"
}
trap cleanup EXIT

set -x
cd -- "$repo_root/web"
docker build -t workshop-web:2.0 .
mount_dir="$(mktemp -d "${TMPDIR:-/tmp}/workshop-bind-v2.XXXXXX")"
printf '%s\n' 'bind-v2-before' > "$mount_dir/bind-check.txt"
ls -ld "$mount_dir"
chmod 755 "$mount_dir"
chmod 644 "$mount_dir/bind-check.txt"
ls -ld "$mount_dir"
ls -l "$mount_dir/bind-check.txt"
docker run -d --name "$container_name" \
    --env NGINX_PORT=8080 \
    --publish "127.0.0.1:${host_port}:8080" \
    --mount "type=bind,source=${mount_dir},target=/usr/share/nginx/html,readonly" \
    workshop-web:2.0
container_created=true
docker inspect --format 'name={{.Name}} image={{.Config.Image}} ports={{json .HostConfig.PortBindings}} mounts={{json .Mounts}}' "$container_name"
before="$(curl --fail --silent --show-error --retry 10 --retry-connrefused --retry-delay 1 "http://127.0.0.1:${host_port}/bind-check.txt")"
printf 'BEFORE_HTTP_BODY=%s\n' "$before"
test "$before" = 'bind-v2-before'
docker exec "$container_name" cat /etc/nginx/conf.d/default.conf

# 여기서는 재빌드·재시작 없이 호스트 파일만 변경한다.
printf '%s\n' 'bind-v2-after' > "$mount_dir/bind-check.txt"
after="$(curl --fail --silent --show-error "http://127.0.0.1:${host_port}/bind-check.txt")"
printf 'AFTER_HTTP_BODY=%s\n' "$after"
test "$after" = 'bind-v2-after'
set +x
printf 'HTTP_COMPARISON=PASS (no build/restart between requests)\n'
