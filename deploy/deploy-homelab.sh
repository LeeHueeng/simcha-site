#!/bin/zsh
# car.hueeng.com 갱신: 홈서버(Proxmox LXC 101)의 clone 을 origin/main 으로 맞추고 nginx 를 다시 읽힌다.
# GitHub Pages(leehueeng.github.io/simcha-site)는 push 만으로 갱신되고, 이 스크립트는 car.hueeng.com 쪽이다.
set -eu
host="${SIMCHA_PVE_HOST:-root@100.98.113.16}"
key="${SIMCHA_PVE_KEY:-$HOME/.ssh/id_ed25519_proxmox}"
container="${SIMCHA_PVE_CT:-101}"
ssh -o BatchMode=yes -i "$key" "$host" "pct exec $container -- bash -lc '
  set -e; cd /opt/simcha-site/site
  git fetch -q origin main && git reset -q --hard origin/main
  docker compose -f deploy/compose.yaml up -d
  docker compose -f deploy/compose.yaml exec -T web nginx -s reload
  git log --oneline -1'"
for p in / /privacy /terms /account-delete; do
  print "  https://car.hueeng.com$p → $(curl -s -o /dev/null -w '%{http_code}' -m 20 "https://car.hueeng.com$p")"
done
