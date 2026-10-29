# finaci (피나시) — GAI3008 중간프로젝트

**여러 통화의 생활비 흐름과 목표 날짜를 함께 보는 UI 프로토타입**

GAI3008 응용모바일프로그래밍 · Dinh Vu Thuy Anh · 2024106125

- 제출 저장소: https://github.com/thanhdvu/finaci-midterm
- 웹 데모: https://flying-fjord-n1xr8rj-thuyanhdv-3408.vercel.app
- 데이터 확인: [전망 예시](https://flying-fjord-n1xr8rj-thuyanhdv-3408.vercel.app/api/outlook) · [예정 항목](https://flying-fjord-n1xr8rj-thuyanhdv-3408.vercel.app/api/plannedPayments)
- 1분 데모 영상: [MP4](docs/video/finaci-demo-1min.mp4)
- 발표자료: [PDF](output/finaci-midterm-final.pdf) · [PowerPoint](output/finaci-midterm-final.pptx)

finaci는 여러 국가·통화로 돈을 관리하는 사람을 위한 생활비 계획 도우미입니다. 이 프로토타입은 한국에 거주하며 VND 원격 급여, KRW 아르바이트 급여와 가족 지원금을 함께 고려하는 베트남 유학생의 사용 상황을 예시로 사용합니다. 이 사례는 테스트 시나리오이며 전체 대상 사용자를 제한하지 않습니다.

## 화면 미리보기

| Wallet 현행 화면 | finaci A · 현금흐름 홈 | finaci B · 일정 상세 | finaci C · 시나리오 | finaci 넓은 화면 |
|---|---|---|---|---|
| ![Wallet Dashboard](docs/screenshots/journey/wallet-dashboard-redacted.jpg) | ![finaci A](docs/screenshots/finaci-a.png) | ![finaci B](docs/screenshots/finaci-b.png) | ![finaci C](docs/screenshots/finaci-c.png) | ![finaci wide](docs/screenshots/finaci-wide.png) |

> A/B/C/D는 수업용 고정 예시 UI입니다. 예시 값과 번들된 Wallet 현행 캡처를 구분해서 봐 주세요. D는 A/B 하단 중앙 +에서 열리는 빠른 기록 시트입니다.

로딩·오류·빈 상태는 실제 Flutter 실행 캡처로 남겼습니다: [로딩](docs/screenshots/states/loading.png), [오류](docs/screenshots/states/error.png), [빈 상태](docs/screenshots/states/empty.png).

## 핵심 문제와 v2 방향

Wallet iPhone 5.7.5를 살펴본 학생은 Planned Payments와 Outlook이 별도 흐름이며, 이미 등록한 예정 항목을 Outlook에서 확인하려면 다시 입력해야 했다고 보고했습니다. 이에 finaci는 **기록한 반복 수입·지출을 날짜별 현금흐름 보기에서 재사용하는 경험**을 제안합니다. P07(효율성) 우선, P06(기억보다 재인) 보조입니다. 이는 한 사용자의 관찰이지 모든 Wallet 사용자에 대한 결론은 아닙니다. Store 리뷰는 별도의 근거로 분리했습니다.

v2는 현재 잔액과 예시 전망을 구분하고, 포함·제외 항목과 가정을 가까이 보여 줍니다. 목표 카드는 보조 use case입니다. 실제 환율 변환·잔액 계산·AI 호출·은행 연결·로그인·결제·영구 저장은 구현하지 않았습니다.

## 화면 흐름

| 화면 | 비즈니스 명칭 | 주요 구성 | 전환 |
|---|---|---|---|
| A | 현금흐름 홈 | 통화별 계좌, 실제/예상 보기, 날짜별 전망, 반영된 반복 항목, 목표 카드 | 첫 화면; B로 이동; 중앙 +로 D; 시나리오로 C |
| B | 현금흐름 일정 상세 | 예정 수입·지출, 7일/30일/목표일까지 탭, 포함·제외 설명 | Navigator push; 탭 전환 |
| C | 급여 지연 시나리오 | 미리 작성한 기본/지연 예시 비교와 한계 안내 | showModalBottomSheet |
| D | 빠른 기록 | 지출/수입/이체, 금액, KRW/VND/USD/EUR/JPY 예시 통화, 분류, 날짜 | A/B 중앙 +의 showModalBottomSheet; 저장하지 않음 |

구현 대응: `docs/디자인가이드.md` · 셀프 논증과 증거: `docs/셀프논증.md`, `docs/prompt-log.md` · Wallet 리뷰: `docs/wallet-review-notes.md` · checklist: `docs/checklist-tien-do.md`.

## 실행 방법

준비물: Flutter SDK (Dart 3.10 이상), Node.js 22 또는 24.

터미널 1:

```bash
cd mock_server
npm install
npm start
```

터미널 2, 저장소 루트에서:

```bash
flutter pub get
flutter run -d chrome
```

기본 데이터는 `mock_server/db.json`에 있습니다. 앱은 로컬 json-server에서 GET만 사용합니다. 서버 주소와 실행 환경별 설정은 `lib/api.dart`와 `mock_server/README.md`를 참고하세요.

상태 시연:

```bash
flutter run -d chrome --dart-define=DEMO_STATE=loading
flutter run -d chrome --dart-define=DEMO_STATE=error
flutter run -d chrome --dart-define=DEMO_STATE=empty
```

## 평가용 자료

- 앱 요약: `docs/finaci-app-summary-onepage-ko.md`
- Wallet 현행 User Journey와 리뷰 연결: `docs/hanh-trinh-nguoi-dung.md`, `docs/wallet-user-journey-board-ko.png`
- Fishbone + 5 Why: `docs/phan-tich-nguyen-nhan.md`, `docs/wallet-fishbone-5why-board-ko.png`
- 디자인 가이드와 P01–P10: `docs/디자인가이드.md`, `docs/원칙카드.md`
- AI 사용 기록과 학생 판단: `docs/prompt-log.md`, `docs/셀프논증.md`
- 자가평가: `docs/자가평가.md`
- 발표자료는 수업 템플릿의 본문 순서와 B1–B5를 따릅니다. 원칙별 카드와 화면별 요소 분석표는 템플릿 지시에 따라 부록을 복제했습니다. 제목은 Noto Serif KR, 본문은 Noto Sans KR입니다.

## 예시 데이터의 일관성

기준일은 2026-10-28, 목표일은 2027-02-28입니다. KRW 계좌 1,240,000원과 VND 계좌 7,500,000동을 예시 환율 1 KRW = 20 VND로 표현하면 현재 합산 예시는 1,615,000원입니다. 매월 원격 급여 VND 7,000,000, 가족 지원 VND 2,000,000, 한국 급여 KRW 380,000, 월세 KRW 375,000과 보험 KRW 75,000을 반영한 목표일 예시는 3,135,000원입니다.

C 시나리오는 2월 25일 예정 급여가 7일 늦어 3월 4일 입금되는 경우입니다. 입금이 목표일을 넘기므로 2월 28일 예시는 2,755,000원으로 달라집니다. 이 숫자는 작성 단계에서 맞춘 고정 예시이며 앱은 환산·합산·예측 계산을 실행하지 않습니다. 변동 지출, 환전 수수료와 환율 변동은 제외합니다.

## 앱스토어 비교 근거

참조 앱: [Wallet — Apple App Store Korea](https://apps.apple.com/kr/app/wallet-%EA%B0%9C%EC%9D%B8-%EA%B8%88%EC%9C%B5/id1032467659). Review snapshot은 2026-10-28에 Apple KR/US/UK와 Google Play US에서 수집했습니다. 총 20개를 R01–R20으로 익명화하고, 각 store/지역/플랫폼/날짜/별점을 분리 기록했습니다. 서로 다른 지역과 플랫폼은 하나의 평점 분포로 합치지 않았습니다. 세부 수치와 제한은 `docs/wallet-review-notes.md`를 보세요.

## 구현 범위

- 허용 범위: Flutter 화면 전환, 화면 내부 선택 상태(`setState`), 고정 예시 응답, 로컬 json-server GET, 로딩·오류·빈 상태, 넓은 화면 배치.
- 제외 범위: POST/PUT/DELETE, 영구 저장, 로그인·결제, 실제 재무 계산·환율 API·AI API·개인정보.
- 자산: mascot은 앞선 finaci 프로젝트에서 복사한 파일입니다. 원 제작자와 라이선스는 확인되지 않았으므로 공개/상업 배포 전에 확인하세요.
- Vercel: 웹과 읽기 전용 json-server API를 같은 프로젝트에서 제공합니다. 2026-10-29 공개 URL과 GET 응답(200), POST/PUT/DELETE 거절(403)을 확인했습니다. 학생은 임시 프로젝트를 자신의 계정으로 수령했다고 확인했습니다. 재배포는 `scripts/prepare-vercel.ps1`로 빌드한 뒤 Vercel CLI에 로그인하여 `npx vercel --cwd mock_server --prod`로 진행합니다.

## 발표와 시연

- PowerPoint10장에는 MP4가 문서에 포함됩니다. PDF에서는 영상 링크를 사용합니다.
- 제품 대상은 다국가·다중 통화 이용자이며 VND/KRW는 시연 시나리오입니다. 빠른 기록에는 KRW/VND/USD/EUR/JPY 예시 선택이 있습니다.
- 자연스러운6분 발표 대본: [한국어 대본](docs/발표대본.md)
- 교수 관점의 평가와 한계: [평가 기록](docs/audit-goc-nhin-giao-su.md)

