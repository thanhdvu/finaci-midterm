// 화면 B — 현금흐름 일정 상세 (GET /plannedPayments, /outlook)
// ┌──────── 디자인 가이드 대응표: B 현금흐름 일정 상세 ───────────────────────────┐
// │ B-1 AppBar + BackButton                       현금흐름 일정          P03·P04 │
// │ B-2 DefaultTabController + TabBar             7일·30일·목표일까지    P07     │
// │ B-3 ListView + Card + ListTile                날짜별 예정 항목        P02·P06·P07│
// │ B-4 FilterChip                                전체·수입·지출          P07·P08 │
// │ B-5 Card + ListTile                           전망 포함/제외 기준     P01·P05 │
// │ B-6 Card + Text                               날짜별 잔액 예시        P01     │
// │ B-7 FutureBuilder + 상태 위젯                 불러오기 상태           P01·P09 │
// │ B-8 OutlinedButton → showModalBottomSheet     급여 지연 상황 비교     P07·P10 │
// │ B-9 NavigationBar                              Wallet형 하단 메뉴      P04·P07 │
// └──────────────────────────────────────────────────────────────────────────────┘
import 'package:flutter/material.dart';

import '../api.dart';
import '../models.dart';
import '../widgets.dart';
import 'c_result_sheet.dart';
import 'd_quick_add_sheet.dart';

enum _ScheduleRange {
  sevenDays('7일'),
  thirtyDays('30일'),
  goalDate('목표일까지');

  const _ScheduleRange(this.label);
  final String label;
}

enum _PaymentFilter { all, income, expense }

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, this.load = fetchScheduleData});

  final ScheduleLoader load;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<ScheduleData> _future = widget.load();
  _PaymentFilter _filter = _PaymentFilter.all;

  // STATE: GET 결과 상태 → B-7 로딩/오류/빈/목록 위젯
  void _retry() {
    setState(() => _future = widget.load());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _ScheduleRange.values.length,
      initialIndex: _ScheduleRange.goalDate.index,
      child: Scaffold(
        backgroundColor: finaciCanvas,
        appBar: AppBar(
          title: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FinaciMascot(size: 30),
              SizedBox(width: 6),
              Text('현금흐름 일정'),
            ],
          ), // B-1 P03 · P04
          bottom: TabBar(
            tabs: [
              for (final range in _ScheduleRange.values) Tab(text: range.label),
            ],
          ), // B-2 P07
        ),
        body: FutureBuilder<ScheduleData>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return const LoadingView(label: '예정 항목을 불러오는 중…'); // B-7 P01
            }
            if (snapshot.hasError) {
              return ErrorView(
                title: '일정을 불러오지 못했습니다.',
                message: '${snapshot.error}',
                onRetry: _retry,
              ); // B-7 P09
            }
            final data = snapshot.data;
            if (data == null || data.payments.isEmpty) {
              return const EmptyView(message: '등록된 예정 항목이 없습니다.'); // B-7 P01
            }
            return LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 760;
                return TabBarView(
                  children: [
                    for (final range in _ScheduleRange.values)
                      _RangePage(
                        range: range,
                        data: data,
                        filter: _filter,
                        wide: wide,
                        onFilterChanged: (filter) =>
                            setState(() => _filter = filter),
                      ),
                  ],
                );
              },
            );
          },
        ),
        // STATE: 현재 경로 → B-9 선택 표시; A 복귀는 Navigator.pop
        bottomNavigationBar: FinaciBottomNavigationBar(
          selectedIndex: 1,
          onDestinationSelected: (index) {
            switch (index) {
              case 0:
                Navigator.of(context).pop();
                break;
              case 1:
                break; // Planning is already visible.
              case 2:
                QuickAddBottomSheet.show(
                  context,
                ); // B-9 · Wallet quick-add pattern
                break;
              case 3:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('날짜별 잔액 통계는 대시보드에서 확인할 수 있어요.')),
                );
                break;
              case 4:
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('추가 메뉴는 이번 화면 기획 범위에 없어 데모로 표시합니다.'),
                  ),
                );
                break;
            }
          },
        ), // B-9 P04 · P07
      ),
    );
  }
}

class _RangePage extends StatelessWidget {
  const _RangePage({
    required this.range,
    required this.data,
    required this.filter,
    required this.wide,
    required this.onFilterChanged,
  });

  final _ScheduleRange range;
  final ScheduleData data;
  final _PaymentFilter filter;
  final bool wide;
  final ValueChanged<_PaymentFilter> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    final payments = data.payments
        .where((payment) => payment.visibleIn.contains(range.label))
        .where(
          (payment) => switch (filter) {
            _PaymentFilter.all => true,
            _PaymentFilter.income => payment.type == 'income',
            _PaymentFilter.expense => payment.type == 'expense',
          },
        )
        .toList();

    final list = _PaymentsList(payments: payments);
    final notes = _OutlookNotes(
      goalDate: data.outlook?.goalDate ?? '',
      projectedKrw: data.outlook?.projectedKrw ?? 0,
    );

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1120),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            Text(
              range == _ScheduleRange.goalDate
                  ? '목표일까지의 예정 흐름'
                  : '${range.label} 예정 흐름',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 4),
            Text(
              range == _ScheduleRange.goalDate
                  ? '등록한 반복 수입·지출을 날짜순으로 확인해요.'
                  : '${range.label} 범위에 등록된 항목을 확인해요.',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: finaciMuted),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              children: [
                _filterChip('전체', _PaymentFilter.all),
                _filterChip('수입', _PaymentFilter.income),
                _filterChip('지출', _PaymentFilter.expense),
              ],
            ), // B-4 P07 · P08
            const SizedBox(height: 14),
            if (wide)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 6, child: list),
                  const SizedBox(width: 18),
                  Expanded(
                    flex: 4,
                    child: Column(children: [notes, _ScenarioAction()]),
                  ),
                ],
              )
            else ...[
              list,
              const SizedBox(height: 12),
              notes,
              const SizedBox(height: 8),
              const _ScenarioAction(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _filterChip(String label, _PaymentFilter value) => FilterChip(
    label: Text(label),
    selected: filter == value,
    onSelected: (_) => onFilterChanged(value),
  );
}

class _PaymentsList extends StatelessWidget {
  const _PaymentsList({required this.payments});
  final List<PlannedPayment> payments;

  @override
  Widget build(BuildContext context) {
    if (payments.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: EmptyView(message: '이 기간에는 해당 유형의 항목이 없습니다.'),
        ),
      );
    }
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
            child: Text(
              '날짜별 예정 항목',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          for (final payment in payments) ...[
            ListTile(
              leading: CircleAvatar(
                backgroundColor:
                    (payment.type == 'income'
                            ? finaciPositive
                            : finaciAccentText)
                        .withValues(alpha: 0.12),
                child: Icon(
                  payment.type == 'income'
                      ? Icons.south_west_rounded
                      : Icons.north_east_rounded,
                  color: payment.type == 'income'
                      ? finaciPositive
                      : finaciAccentText,
                ),
              ),
              title: Text(
                payment.name,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                '${formatShortDate(payment.date)} · ${payment.currency} · ${payment.category}',
              ),
              trailing: Text(
                '${payment.type == 'income' ? '+' : '−'}${formatMoney(payment.currency, payment.amount)}',
                style: TextStyle(
                  color: payment.type == 'income'
                      ? finaciPositive
                      : finaciAccentText,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ), // B-3 P02 · P06 · P07
            if (payment != payments.last) const Divider(height: 1, indent: 72),
          ],
        ],
      ),
    );
  }
}

class _OutlookNotes extends StatelessWidget {
  const _OutlookNotes({required this.goalDate, required this.projectedKrw});
  final String goalDate;
  final int projectedKrw;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '목표일 잔액 예시',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  formatMoney('KRW', projectedKrw),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: finaciInk,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${formatLongDate(goalDate)} · KRW 환산 예시',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: finaciMuted),
                ),
              ],
            ),
          ),
        ), // B-6 P01
        const SizedBox(height: 12),
        Card(
          color: finaciAccentSurface,
          child: const ListTile(
            leading: Icon(Icons.info_outline_rounded, color: finaciAccentText),
            title: Text('전망에 포함된 범위'),
            subtitle: Text(
              '반복 등록 항목과 예시 환율 1 KRW = 20 VND를 반영했어요. 보장 잔액이 아니며 변동 지출, 환율 변화, 환전 수수료와 미입력 항목은 제외합니다.',
            ),
          ),
        ), // B-5 P01 · P05
      ],
    );
  }
}

class _ScenarioAction extends StatelessWidget {
  const _ScenarioAction();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () => ScenarioBottomSheet.show(context),
        icon: const Icon(Icons.compare_arrows_rounded),
        label: const Text('급여 지연 상황 비교 · 예시'),
      ),
    ),
  ); // B-8 P07 · P10
}
