# finaci 목업 서버 — json-server GET 전용

`db.json`의 데이터를 **GET으로만** 앱에 내려 주는 로컬 서버입니다.
중간고사 안내 5장: json-server에서 `GET`은 **허용**, `POST`/`PUT`/`DELETE`·저장은 **감점**입니다.

```
mock_server/
├── db.json        # outlook 1개, plannedPayments 20개, demoAssumptions 설명
├── package.json   # json-server 0.17.4 고정 · "npm start" (= "npm run mock")
├── api/server.js  # (가산 +5) Vercel 서버리스 함수 — 읽기 전용 GET
└── vercel.json    # (가산 +5) /api/* → api/server.js
```

## 1. 설치 → 실행 → 확인

Node.js(18 이상 권장)가 필요합니다.

```bash
cd mock_server
npm install      # json-server 0.17.4 설치 (node_modules/는 git에 올리지 않음)
npm start        # = json-server --watch db.json --port 3000 --host 0.0.0.0  (npm run mock 도 같음)
```

다른 터미널에서:

```bash
curl http://localhost:3000/outlook          # A 홈과 B 목표일 잔액에 쓰는 예시 배열
curl http://localhost:3000/plannedPayments  # B 기간/수입/지출 필터에 쓰는 예시 배열
curl http://localhost:3000/demoAssumptions  # 기준일·고정 환율·시나리오 설명 객체
```

- `--watch`: `db.json`을 고치고 저장하면 서버를 다시 켜지 않아도 반영됩니다.
- `--host 0.0.0.0`: 같은 Wi-Fi의 실기기에서도 접속할 수 있게 엽니다(macOS 방화벽 창이 뜨면 "허용").
- 끄기: 서버 터미널에서 `Ctrl + C`.
- 쓰기 요청을 아예 막고 싶으면 `npx json-server --watch db.json --port 3000 --host 0.0.0.0 --read-only` (GET 외 403).
- 로딩 화면을 서버 쪽에서 늦추고 싶으면 `--delay 2000` (앱 쪽은 `DEMO_STATE=loading`).

> ⚠ json-server는 원래 POST/PUT/DELETE도 받아 `db.json`에 **실제로 저장**합니다.
> 중간고사에서는 앱이 GET만 보내야 합니다(쓰기 요청은 감점 항목).

## 2. `db.json` 바꾸기

- 최상위 키 하나가 주소 하나가 됩니다. A는 `/outlook`, B는 `/plannedPayments`와 `/outlook`을 읽습니다. 요청 코드는 `lib/api.dart`에만 있습니다.
- 항목마다 `id`가 있습니다. A의 예정 항목 미리보기는 B와 같은 ID·이름을 사용한 고정 예시입니다. 실제 동기화 기능은 구현하지 않습니다.
- 필드를 바꾸면 `lib/models.dart`의 `fromJson` 패턴도 같이 바꿉니다(모양이 다르면 그 항목은 목록에서 빠집니다).
- **실제 개인정보(이름·전화·학번·주소 등)는 넣지 않습니다**(감점 항목). 이미지는 `https://picsum.photos/seed/<아무 글자>/400/300` 같은 예시 이미지를 씁니다.

### 고정 예시의 가정

- 기준일은 2026년 10월 28일입니다. 현재 계좌는 KRW 1,240,000과 VND 7,500,000이며 **1 KRW = 20 VND**로 합친 예시 잔액은 KRW 1,615,000입니다.
- 매월 VND 원격 급여 7,000,000(5일), 가족 지원금 2,000,000(10일), KRW 월세 375,000(23일), 아르바이트 급여 380,000(25일), 보험료 75,000(25일)을 준비했습니다.
- 사전에 작성한 월 순증가 예시는 KRW 380,000이며 2027년 2월 28일 예시 잔액은 KRW 3,135,000입니다. 앱은 이 금액을 계산하지 않습니다.
- C는 **2월 25일 급여가 3월 4일에 들어오는 경우**를 비교합니다. 목표일 2월 28일을 지나므로 급여 KRW 380,000을 받기 전의 예시 잔액 KRW 2,755,000을 보여 줍니다. 목표일 전에 입금되는 지연에 같은 결과를 적용하지 않습니다.
- 환율 변화, 환전 수수료, 변동 지출과 미입력 항목은 제외합니다. 예상값은 보장 잔액이 아닙니다. 실제 환전이나 이체도 하지 않습니다.
- `visibleIn`은 계산된 날짜 필터가 아니라 미리 지정한 표시 태그입니다. 기준일 이후 7일 내 예정 항목이 없어 7일 탭은 빈 상태를 보여 줍니다.

## 3. Flutter 앱에서 쓸 주소

| 실행 대상 | 주소 | 앱 설정 |
|---|---|---|
| Chrome(웹) · macOS · Windows · iOS 시뮬레이터 | `http://localhost:3000` | 기본값 — 그대로 `flutter run` |
| **Android 에뮬레이터** | **`http://10.0.2.2:3000`** | 기본값 — 템플릿이 Android를 알아서 10.0.2.2로 바꾼다 |
| 실기기(폰) | 같은 Wi-Fi PC의 IP, 예: `http://192.168.0.10:3000` | `--dart-define=API_BASE=http://192.168.0.10:3000` |

PC IP 확인: macOS `ipconfig getifaddr en0` · Windows `ipconfig`(IPv4 주소).

플랫폼 설정(템플릿에 이미 반영):
- Android: 평문 `http://` 허용 — `android/app/src/debug/AndroidManifest.xml`의 `usesCleartextTraffic="true"`(디버그 빌드만).
- macOS: `macos/Runner/*.entitlements`에 `com.apple.security.network.client`.

## 4. CORS (Flutter 웹)

Chrome에서 실행한 Flutter 웹(`http://localhost:<임의 포트>`)이 `http://localhost:3000`을 부르면 출처(origin)가 달라 서버가 CORS 헤더를 줘야 합니다.
json-server 0.17.4는 **기본으로 CORS를 허용**합니다(`--no-cors`를 붙이지 마세요). 모바일·데스크톱 앱은 CORS와 무관합니다.

## 5. (가산 +5) Vercel 배포 — 읽기 전용

서버리스 함수(`api/server.js`)가 `db.json`을 메모리로만 읽고(`jsonServer.router(객체)`), `readOnly: true`로 **GET 외 요청은 403**으로 거절합니다.
구조는 [kitloong/json-server-vercel](https://github.com/kitloong/json-server-vercel)(MIT)을 참고해 최소 구성으로 다시 썼습니다(`midterm/mock_server`와 같은 파일).

```powershell
# 저장소 루트에서 웹 빌드와 public/ 복사를 한 번에 준비한다.
powershell -File scripts/prepare-vercel.ps1
# 자신의 Vercel 계정에 로그인하고 기존 프로젝트를 선택한다.
npx vercel login
npx vercel --cwd mock_server --prod
```

같은 Vercel 프로젝트에서 웹과 API를 함께 배포할 때는 `--dart-define=API_BASE=/api`로 빌드할 수 있습니다. 실제 웹 출처의 `/api`로 해석하며, 설정을 생략한 로컬 실행은 계속 localhost json-server를 사용합니다.

현재 시연 URL: https://flying-fjord-n1xr8rj.tmp.now . 2026-10-29 웹과 데이터 GET 200, 데이터 POST/PUT/DELETE 403을 확인했고 학생이 프로젝트 수령을 확인했습니다. Windows에서 재배포를 준비하려면 저장소 루트에서 `powershell -File scripts/prepare-vercel.ps1`을 실행하고, Vercel CLI에 로그인한 뒤 `npx vercel --cwd mock_server --prod`로 배포합니다. `public/`은 생성 산출물이라 Git에는 올리지 않으며, CLI 배포에는 `.vercelignore` 규칙으로 포함합니다.
