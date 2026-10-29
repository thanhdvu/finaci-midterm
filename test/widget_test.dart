// Widget coverage for the Finaci prototype. Loaders are fixtures; no server is used.
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mid_project_template/models.dart';
import 'package:mid_project_template/screens/a_list_screen.dart';

const _snapshot = OutlookSnapshot(
  id: 1,
  goalDate: '2027-02-28',
  actualKrw: 1615000,
  projectedKrw: 3135000,
  balances: [
    CurrencyBalance(currency: 'KRW', amount: 1240000),
    CurrencyBalance(currency: 'VND', amount: 7500000),
  ],
  actualTimeline: [
    BalancePoint(label: '10/28', amount: 1615000, barHeight: 86),
  ],
  forecastTimeline: [
    BalancePoint(label: '오늘', amount: 1615000, barHeight: 52),
    BalancePoint(label: '02/28', amount: 3135000, barHeight: 100),
  ],
  upcomingPayments: [
    PlannedPayment(
      id: 1,
      date: '2026-11-05',
      name: '원격 급여',
      category: '급여',
      amount: 7000000,
      currency: 'VND',
      type: 'income',
      source: '반복 예정 항목',
      visibleIn: [],
    ),
  ],
  goal: SavingsGoal(
    name: '다음 학기 등록금',
    savedAmount: 1200000,
    targetAmount: 3000000,
    currency: 'KRW',
    dueDate: '2027-02-28',
    progress: 0.4,
  ),
);

const _payments = [
  PlannedPayment(
    id: 1,
    date: '2026-11-05',
    name: '원격 급여',
    category: '급여',
    amount: 7000000,
    currency: 'VND',
    type: 'income',
    source: '반복 예정 항목',
    visibleIn: ['30일', '목표일까지'],
  ),
  PlannedPayment(
    id: 2,
    date: '2026-11-23',
    name: '월세',
    category: '주거',
    amount: 375000,
    currency: 'KRW',
    type: 'expense',
    source: '반복 예정 항목',
    visibleIn: ['30일', '목표일까지'],
  ),
];

Future<List<OutlookSnapshot>> _outlook() async => const [_snapshot];
Future<ScheduleData> _schedule() async =>
    const ScheduleData(payments: _payments, outlook: _snapshot);

Widget _app({OutlookLoader load = _outlook}) => MaterialApp(
  home: ListScreen(load: load, scheduleLoad: _schedule),
);

void _setSize(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
}

void main() {
  testWidgets('A는 loading, error/retry, empty, data 상태를 보여 준다', (tester) async {
    _setSize(tester, const Size(400, 900));
    final first = Completer<List<OutlookSnapshot>>();
    var calls = 0;
    await tester.pumpWidget(
      _app(
        load: () =>
            ++calls == 1 ? first.future : Future.value(const [_snapshot]),
      ),
    );
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    first.completeError(Exception('test error'));
    await tester.pumpAndSettle();
    expect(find.text('현금흐름을 불러오지 못했습니다.'), findsOneWidget);
    await tester.tap(find.text('다시 시도'));
    await tester.pumpAndSettle();
    expect(find.text('내 현금흐름'), findsOneWidget);
    expect(calls, 2);

    await tester.pumpWidget(
      MaterialApp(
        home: ListScreen(
          key: const ValueKey('empty'),
          load: () async => const [],
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('표시할 현금흐름 예시가 없습니다.'), findsOneWidget);
  });

  testWidgets('A → B 기간/필터 탭 → C 급여 지연 예시', (tester) async {
    _setSize(tester, const Size(430, 900));
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    expect(find.text('내 현금흐름'), findsOneWidget);

    await tester.ensureVisible(find.text('일정 자세히 보기'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('일정 자세히 보기'));
    await tester.pumpAndSettle();
    expect(find.text('현금흐름 일정'), findsOneWidget);
    expect(find.text('목표일까지의 예정 흐름'), findsOneWidget);
    expect(find.text('월세'), findsOneWidget);

    await tester.tap(find.text('7일'));
    await tester.pumpAndSettle();
    expect(find.text('월세'), findsNothing);
    expect(find.text('이 기간에는 해당 유형의 항목이 없습니다.'), findsOneWidget);

    await tester.tap(find.text('30일'));
    await tester.pumpAndSettle();
    expect(find.text('원격 급여'), findsOneWidget);
    await tester.tap(find.text('수입'));
    await tester.pumpAndSettle();
    expect(find.text('월세'), findsNothing);
    expect(find.text('원격 급여'), findsOneWidget);

    await tester.ensureVisible(find.text('급여 지연 상황 비교 · 예시'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('급여 지연 상황 비교 · 예시'));
    await tester.pumpAndSettle();
    expect(find.text('급여 지연 상황 비교'), findsOneWidget);
    expect(find.text('₩2,755,000'), findsOneWidget);
    expect(find.textContaining('지연 시 3월 4일'), findsOneWidget);
  });

  testWidgets('넓은 화면에서도 A가 표시된다', (tester) async {
    _setSize(tester, const Size(1024, 768));
    await tester.pumpWidget(_app());
    await tester.pumpAndSettle();
    expect(find.text('내 현금흐름'), findsOneWidget);
    expect(find.text('KRW'), findsOneWidget);
    expect(find.text('VND'), findsOneWidget);
  });
}
