# simcha-site

심플차계부(com.hueeng.car) 공개 사이트 — 앱 소개 랜딩과 법적 문서. 같은 파일을 두 곳에서 서빙한다.

| 주소 | 호스팅 | 갱신 |
|---|---|---|
| https://leehueeng.github.io/simcha-site/ | GitHub Pages | main 에 push |
| https://car.hueeng.com/ | 홈서버(Proxmox LXC 101) — [LeeHueeng/hueeng-sites](https://github.com/LeeHueeng/hueeng-sites) 의 nginx, 주 Cloudflare 터널 | main 에 push 하면 약 5분 안에 자동 반영 (hueeng-sites 가 이 저장소를 서브모듈로 따라간다) |

- `/` 앱 소개(히어로·기능·실제 화면·다운로드·FAQ·문의). 모양은 `assets/site.css`, 이미지는 `assets/` WebP. 링크는 모두 상대경로(두 호스팅 공용)
- `/privacy` 개인정보처리방침 (앱 v1.5.0 이하가 car.hueeng.com 으로 링크)
- `/terms` 이용약관
- `/account-delete` 계정 삭제 안내 — Google Play 데이터 보안 양식 "계정 삭제 요청 URL" 은 github.io 주소
- `/chat/invite/<code>` 앱 채팅방 초대 링크 안내(앱에서 열기 버튼) — car.hueeng.com 에서만 의미 있음

car.hueeng.com 의 nginx 규칙(`/chat/invite/` 안내 페이지 200, `/simcha-site/` 경로 호환, 확장자 없는 주소, http→https, 저장소 내부 파일 차단)은 hueeng-sites 저장소 `nginx/conf.d/sites.conf` 에 있다. 2026-11-03 이전의 전용 nginx·"simcha-site" 터널 배포(`deploy/`)는 폐기했다.

법적 문서와 `404.html` 은 `style.css` 를 쓰고, 소개 페이지만 `assets/site.css` 를 쓴다. 스토어 화면(앱 v1.5.0 기준 초록 테마)이 바뀌면 `assets/screen-*.webp`·`shot-*.webp` 도 다시 만든다.

모든 페이지 하단에는 같은 사업자 정보(상호 후엥(Hueeng) · 대표 이현우 · 사업자등록번호 474-26-01971 · 주소 · hi@hueeng.com)를 둔다. `naver*.html` 은 네이버 서치어드바이저 소유확인 파일이므로 지우지 않는다.
