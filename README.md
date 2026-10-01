# simcha-site

심플차계부(com.hueeng.car) 공개 문서 사이트. 같은 파일을 두 곳에서 서빙한다.

| 주소 | 호스팅 | 갱신 |
|---|---|---|
| https://leehueeng.github.io/simcha-site/ | GitHub Pages | main 에 push |
| https://car.hueeng.com/ | 홈서버(Proxmox LXC 101) nginx + Cloudflare "simcha-site" 터널 | push 후 `deploy/deploy-homelab.sh` |

- `/` 지원·문의
- `/privacy` 개인정보처리방침 (앱 v1.5.0 이하가 car.hueeng.com 으로 링크)
- `/terms` 이용약관
- `/account-delete` 계정 삭제 안내 — Google Play 데이터 보안 양식 "계정 삭제 요청 URL" 은 github.io 주소
- `/chat/invite/<code>` 앱 채팅방 초대 링크 안내(앱에서 열기 버튼) — car.hueeng.com 에서만 의미 있음

서버 배치와 터널 자격증명 위치는 `deploy/compose.yaml` 머리말 참고. 자격증명은 git 에 넣지 않는다.
