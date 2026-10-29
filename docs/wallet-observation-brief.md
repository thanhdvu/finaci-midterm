# Wallet 현행 관찰 기록

관찰일 2026-10-28, Wallet5.7.5, iPhone14 Pro Max. 사용자는 당시 최신 iOS라고 설명했으나 정확한 숫자 버전은 남기지 않았다. 21개 화면을 제공했고 대부분의 흐름을 직접 시험했다. 각 흐름은 따로 확인했으며 연속 세션 기록은 아니다.

## 확인한 흐름

| 흐름 | 확인한 화면/요소 | 관찰과 해석 |
|---|---|---|
| 현재 잔액 | Dashboard 계좌 grid, Balance Trend, Top Expenses, Last Records, widget 설정 | 계좌별 잔액을 나누어 보는 구조와 중앙 +를 사용자가 편리하게 느꼈다. |
| 통화 설정 | Settings/Currencies의 KRW base, 추가된 VND, 환율 업데이트 선택 | Wallet은 이미 다중 통화를 지원한다. 내부 환산 방식까지 시험한 것은 아니다. |
| 빠른 기록 | Expense/Income/Transfer, 금액·계좌·분류·날짜, Templates와 Add Template | 여러 기록 유형을 한 진입점에 모은 패턴을 finaci에 유지한다. |
| 예정 항목 | Planning/Planned Payments, All/Income/Expense, 반복 항목과 예정일 | 이미 아는 수입·지출을 입력할 수 있다. 미래 전망과의 관계는 별도 경험 확인이 필요했다. |
| 예산 | Weekly/Monthly/Yearly/One-Time, Spent/Remains와 상태 색상 | 사용자는 Monthly 시작일을 바꾸지 못했고 중간 시작에 맞지 않는다고 보고했다. |
| 통계·전망 | Balance/Spending/Cash Flow/Outlook 등 | 사용자는 Planned Payments를 Outlook에서 보려면 재입력해야 했다고 확인했다. Outlook 카드의 0원만으로 내부 원인을 단정하지 않는다. |
| 더 보기 | Group Sharing, Records, Investments, ShareCost, Settings 등 | 모듈의 존재를 확인했다. 항목 수만 보고 UI가 나쁘다고 판단하지 않는다. |
| 계좌 추가·연결 | 계좌 유형, 입력 방법, 국가 선택, 기관 목록 | 실제 금융정보를 넣어 연결하지 않았다. 국가별 표시 범위만 기록했다. |

## 계좌와 Bank Sync

New Account에는 Cash, Checking Account, Credit card, Savings Account, Investments, Loans and Mortgage, Other가 있다. Checking Account에서 Bank Sync, Apple Pay Integration, Manual Entry, Import Files를 선택한다. Import는 Web App으로 표시된다.

사용자는 국가 목록에서 Vietnam을 찾지 못했다. South Korea를 고르고 Show all banks를 연 화면에는 BUXFER(Checking), HSBC Offshore Banking(Checking), Wise(Checking/Savings)가 보였다. 모두 한국의 국내 은행이라고 부르지 않는다. 실제 연결 성공, 이용자 수, 기관의 인기도는 확인하지 않았다.

이는 해당 persona의 연결 범위와 수기 대안을 검토하는 근거다. Wallet의 다중 통화 미지원 근거가 아니다. 사용자는 partnership 의존성이 크다는 이유로 이 문제를 핵심에서 제외했다.

## Goals·유료 범위

관찰 화면에서 Goals를 찾지 못했다. 2026-10-28 확인한 [Wallet Help Center](https://support.budgetbakers.com/hc/en-us/articles/7181571852690-Setting-up-Goals)는 iOS에서 사용할 수 없다고 표시했다. Android의 Goals 안내를 iOS 화면에 그대로 적용하지 않는다.

Dashboard/More의 업그레이드 안내는 확인했다. 사용자는 record history 세부에서 제한을 본 것 같다고 했지만 정확히 기억하지 못했으므로 특정 기능을 확정된 유료 제한으로 쓰지 않는다.

## 개인 경험으로 확정한 내용

- 여러 통화 수입과 잔액을 종합해 미래 계획을 세울 때 머릿속으로 연결해야 했다.
- Planned Payments와 Outlook이 분리돼 같은 항목을 다시 입력하는 흐름이 불편했다.
- Monthly 예산 시작일을 바꾸지 못했다.
- 계좌별 카드와 중앙 +에서 기록하는 구조는 유지할 장점이다.
- 감정 0/-1/0/0/-1/-2는 AI 초안을 사용자가 검토·채택한 회고형 주관 평정이다.

## 근거와 한계

공개 화면은 `screenshots/journey/`에서 확인하며 금액은 가렸다. 캡처는 화면을 증명하지만 모든 분기·오류·내부 계산을 증명하지 않는다. 리뷰는 `wallet-review-notes.md`, Journey는 `사용자여정.md`, 결정 과정은 `prompt-log.md`다.

사전 탐색으로 친구5–7명과 구두 대화를 했다는 사용자 설명이 있다. 메모·질문지·응답 원자료가 없으므로 정량 설문, 인용 또는 대표성 있는 결과로 쓰지 않는다.
