#!/bin/zsh
# car.hueeng.com 갱신: 홈서버(Proxmox LXC 101)의 clone 을 origin/main 으로 맞추고 nginx 를 다시 읽힌다.
# GitHub Pages(leehueeng.github.io/simcha-site)는 push 만으로 갱신되고, 이 스크립트는 car.hueeng.com 쪽이다.
# 서버 접속 정보는 환경변수로 바꿀 수 있다: SIMCHA_PVE_HOST, SIMCHA_PVE_KEY, SIMCHA_PVE_CT
set -eu
setopt pipefail
host="${SIMCHA_PVE_HOST:-root@100.98.113.16}"
key="${SIMCHA_PVE_KEY:-$HOME/.ssh/id_ed25519_proxmox}"
container="${SIMCHA_PVE_CT:-101}"
ssh -o BatchMode=yes -i "$key" "$host" "pct exec $container -- bash -s" <<'REMOTE'
set -euo pipefail
cd /opt/simcha-site/site
git fetch -q origin main
git reset -q --hard origin/main
docker compose -f deploy/compose.yaml up -d
for i in $(seq 1 20); do
  [ "$(docker inspect -f '{{.State.Health.Status}}' simcha-site-web-1)" = healthy ] && break; sleep 2
done
docker compose -f deploy/compose.yaml exec -T web nginx -t
docker compose -f deploy/compose.yaml exec -T web nginx -s reload
git log --oneline -1
REMOTE
fail=0
for p in / /privacy /terms /account-delete /app-ads.txt; do
  code=$(curl -s -o /dev/null -w '%{http_code}' -m 20 "https://car.hueeng.com$p" || echo 000)
  print "  https://car.hueeng.com$p → $code"
  [[ "$code" == 200 ]] || fail=1
done
exit $fail
