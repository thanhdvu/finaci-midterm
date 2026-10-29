// 화면 A — 현금흐름 홈 (GET /outlook)
// ┌──────── 디자인 가이드 대응표: A 현금흐름 홈 ───────────────────────────────────┐
// │ A-1 AppBar + FinaciMascot                        finaci 제목줄         P04·P08 │
// │ A-2 LayoutBuilder + Card                        KRW/VND 계좌 요약      P02·P08 │
// │ A-3 SegmentedButton                             실제/예상 선택         P01     │
// │ A-4 Card + Row/Container                        날짜별 예상 잔액       P01·P08 │
// │ A-5 CustomScrollView + ListTile                 전망에 포함된 예정 항목 P06·P07 │
// │ A-6 Card + FinaciMascot + Text                   전망 범위 안내         P01·P05·P08 │
// │ A-7 Card + LinearProgressIndicator             저축 목표 요약         P01·P02 │
// │ A-8 FilledButton → Navigator.push              일정 자세히 보기       P07     │
// │ A-9 TextButton → showModalBottomSheet          급여 지연 상황 비교    P07·P10 │
// │ A-10 FutureBuilder + 상태 위젯                 불러오기 상태          P01·P09 │
// │ A-11 NavigationBar                              Wallet형 하단 메뉴      P04·P07 │
// └───────────────────────────────────────────────────────────────────────────────┘
import 'package:flutter/material.dart';

import '../api.dart';
import '../models.dart';
import '../widgets.dart';
import 'b_detail_screen.dart';
import 'c_result_sheet.dart';
import 'd_quick_add_sheet.dart';

enum _BalanceMode { forecast, actual }

class ListScreen extends StatefulWidget {
  const ListScreen({
    super.key,
    this.load = fetchOutlook,
    this.scheduleLoad = fetchScheduleData,
  });

  final OutlookLoader load;
  final ScheduleLoader scheduleLoad;

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  late Future<List<OutlookSnapshot>> _future = widget.load();
  _BalanceMode _mode = _BalanceMode.forecast;

  // STATE: 실제/예상 보기 → A-3 선택 표시, A-4 금액과 정적 차트
  void _retry() {
    setState(() {
      _future = widget.load();
    });
  }

  void _openSchedule() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => DetailScreen(load: widget.scheduleLoad),
      ),
    ); // A-8 P07
  }

  void _openScenario() {
    ScenarioBottomSheet.show(context); // A-9 P07 · P10
  }

  void _onBottomDestination(int index) {
    switch (index) {
      case 0:
        break; // Dashboard is already visible.
      case 1:
        _openSchedule();
        break;
      case 2:
        QuickAddBottomSheet.show(context); // A-11 · Wallet quick-add pattern
        break;
      case 3:
        _showNavigationMessage('날짜별 잔액 통계는 대시보드에서 확인할 수 있어요.');
        break;
      case 4:
        _showNavigationMessage('추가 메뉴는 이번 화면 기획 범위에 없어 데모로 표시합니다.');
        break;
    }
  }

  void _showNavigationMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: finaciCanvas,
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FinaciMascot(size: 34),
            SizedBox(width: 6),
            Text('finaci'),
          ],
        ), // A-1 P04 · P08
        centerTitle: false,
        actions: [
          IconButton(
            tooltip: '알림 예시',
            onPressed: () => ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text('수업용 예시 화면입니다.'))),
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: FutureBuilder<List<OutlookSnapshot>>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const LoadingView(label: '현금흐름을 불러오는 중…'); // A-10 P01
          }
          if (snapshot.hasError) {
            return ErrorView(
              title: '현금흐름을 불러오지 못했습니다.',
              message: '${snapshot.error}',
              onRetry: _retry,
            ); // A-10 P09
          }
          final records = snapshot.data ?? const <OutlookSnapshot>[];
          if (records.isEmpty) {
            return const EmptyView(message: '표시할 현금흐름 예시가 없습니다.'); // A-10 P01
          }
          return _HomeContent(
            data: records.first,
            mode: _mode,
            onModeChanged: (mode) => setState(() => _mode = mode),
            onOpenSchedule: _openSchedule,
            onOpenScenario: _openScenario,
          );
        },
      ),
      // STATE: 현재 경로 → A-11 선택 표시; A/B만 실제 이동으로 연결
      bottomNavigationBar: FinaciBottomNavigationBar(
        selectedIndex: 0,
        onDestinationSelected: _onBottomDestination,
      ), // A-11 P04 · P07
    );
  }
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.data,
    required this.mode,
    required this.onModeChanged,
    required this.onOpenSchedule,
    required this.onOpenScenario,
  });

  final OutlookSnapshot data;
  final _BalanceMode mode;
  final ValueChanged<_BalanceMode> onModeChanged;
  final VoidCallback onOpenSchedule;
  final VoidCallback onOpenScenario;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return LayoutBuilder(
      // Adaptive: the page uses available width, not a device-type check.
      builder: (context, constraints) {
        final wide = constraints.maxWidth >= 760;
        final overview = _ForecastCard(
          data: data,
          mode: mode,
          onModeChanged: onModeChanged,
        );
        final payments = _UpcomingPaymentsCard(data: data);
        final goal = _SavingsGoalCard(goal: data.goal);
        final scope = const _ForecastScopeCard();
        final actions = _HomeActions(
          onOpenSchedule: onOpenSchedule,
          onOpenScenario: onOpenScenario,
        );

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1120),
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('내 현금흐름', style: textTheme.headlineMedium),
                        const SizedBox(height: 4),
                        Text(
                          '현재 잔액과 목표일까지의 예정 흐름을 확인해요.',
                          style: textTheme.bodyMedium?.copyWith(
                            color: finaciMuted,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _BalanceCards(balances: data.balances), // A-2 P02 · P08
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                  sliver: SliverToBoxAdapter(
                    child: wide
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 6,
                                child: Column(
                                  children: [
                                    overview,
                                    const SizedBox(height: 12),
                                    payments,
                                  ],
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                flex: 4,
                                child: Column(
                                  children: [
                                    goal,
                                    const SizedBox(height: 12),
                                    scope,
                                    const SizedBox(height: 12),
                                    actions,
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              overview,
                              const SizedBox(height: 12),
                              payments,
                              const SizedBox(height: 12),
                              goal,
                              const SizedBox(height: 12),
                              scope,
                              const SizedBox(height: 12),
                              actions,
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _BalanceCards extends StatelessWidget {
  const _BalanceCards({required this.balances});
  final List<CurrencyBalance> balances;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth >= 760
            ? 3
            : constraints.maxWidth >= 320
            ? 2
            : 1;
        final itemWidth = (constraints.maxWidth - (columns - 1) * 12) / columns;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (final balance in balances)
              SizedBox(
                width: itemWidth,
                height: 146,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.account_balance_wallet_outlined,
                              size: 19,
                              color: finaciOlive,
                            ),
                            const SizedBox(width: 7),
                            Text(
                              balance.currency == 'KRW'
                                  ? '한국 계좌'
                                  : balance.currency == 'VND'
                                  ? '베트남 계좌'
                                  : '계좌 예시',
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    color: finaciInk,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          balance.currency,
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: finaciMuted),
                        ),
                        const SizedBox(height: 8),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            formatMoney(balance.currency, balance.amount),
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(
                                  color: finaciInk,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '입출금 계좌 · 예시',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: finaciMuted),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            SizedBox(
              width: columns == 2 ? constraints.maxWidth : itemWidth,
              height: columns == 2 ? 88 : 146,
              child: Card(
                color: finaciSage,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('수업용 예시예요. 실제 계좌는 추가되지 않습니다.'),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: columns == 2
                        ? const Row(
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: finaciPrimary,
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '계좌 추가',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(height: 3),
                                    Text('다른 국가 · 통화'),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.chevron_right_rounded,
                                color: finaciPrimary,
                              ),
                            ],
                          )
                        : const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.add_circle_outline,
                                color: finaciPrimary,
                              ),
                              SizedBox(height: 8),
                              Text(
                                '계좌 추가',
                                style: TextStyle(fontWeight: FontWeight.w700),
                              ),
                              SizedBox(height: 3),
                              Text('다른 국가 · 통화'),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ForecastCard extends StatelessWidget {
  const _ForecastCard({
    required this.data,
    required this.mode,
    required this.onModeChanged,
  });

  final OutlookSnapshot data;
  final _BalanceMode mode;
  final ValueChanged<_BalanceMode> onModeChanged;

  @override
  Widget build(BuildContext context) {
    final isForecast = mode == _BalanceMode.forecast;
    final points = isForecast ? data.forecastTimeline : data.actualTimeline;
    final balance = isForecast ? data.projectedKrw : data.actualKrw;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '날짜별 잔액 · KRW 환산',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              isForecast
                  ? '목표일까지 예상 · ${formatLongDate(data.goalDate)}'
                  : '현재까지 실제 · 예시 기록',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: finaciMuted),
            ),
            const SizedBox(height: 14),
            SegmentedButton<_BalanceMode>(
              segments: const [
                ButtonSegment(value: _BalanceMode.forecast, label: Text('예상')),
                ButtonSegment(value: _BalanceMode.actual, label: Text('실제')),
              ],
              selected: {mode},
              onSelectionChanged: (selected) => onModeChanged(selected.first),
            ), // A-3 P01
            const SizedBox(height: 18),
            Text(
              formatMoney('KRW', balance),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: finaciInk,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              isForecast ? '예상값이며 보장 잔액이 아닙니다.' : '계좌별 잔액을 고정 예시 환율로 합친 값입니다.',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: finaciAccentText),
            ), // A-4 P01 · P05
            const SizedBox(height: 18),
            _TimelineBars(points: points), // A-4 P01 · P08
            const SizedBox(height: 10),
            Text(
              '예시 환율 1 KRW = 20 VND · 2026.10.28 기준',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: finaciMuted),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimelineBars extends StatelessWidget {
  const _TimelineBars({required this.points});
  final List<BalancePoint> points;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 142,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final (index, point) in points.indexed)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: point.barHeight.toDouble(),
                      decoration: BoxDecoration(
                        color: index == points.length - 1
                            ? finaciPositive
                            : finaciOlive.withValues(alpha: 0.82),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      point.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(color: finaciMuted),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _UpcomingPaymentsCard extends StatelessWidget {
  const _UpcomingPaymentsCard({required this.data});
  final OutlookSnapshot data;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '전망에 포함된 예정 항목',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Icon(Icons.link_rounded, color: finaciPositive, size: 20),
                const SizedBox(width: 6),
                Text(
                  '등록 항목 재사용',
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: finaciPositive),
                ),
              ],
            ),
            const SizedBox(height: 6),
            for (final payment in data.upcomingPayments.take(3))
              _PaymentTile(payment: payment), // A-5 P06 · P07
          ],
        ),
      ),
    );
  }
}

class _PaymentTile extends StatelessWidget {
  const _PaymentTile({required this.payment});
  final PlannedPayment payment;

  @override
  Widget build(BuildContext context) {
    final income = payment.type == 'income';
    final color = income ? finaciPositive : finaciAccentText;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.12),
        child: Icon(
          income ? Icons.south_west_rounded : Icons.north_east_rounded,
          color: color,
          size: 20,
        ),
      ),
      title: Text(
        payment.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text('${formatShortDate(payment.date)} · ${payment.source}'),
      trailing: Text(
        '${income ? '+' : '−'}${formatMoney(payment.currency, payment.amount)}',
        style: TextStyle(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _SavingsGoalCard extends StatelessWidget {
  const _SavingsGoalCard({required this.goal});
  final SavingsGoal goal;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: finaciSage,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.flag_outlined, color: finaciPositive),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '저축 목표',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Text(
                  '목표 1개',
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(color: finaciPositive),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              goal.name,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              '${formatMoney(goal.currency, goal.savedAmount)} / ${formatMoney(goal.currency, goal.targetAmount)}',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: goal.progress,
              minHeight: 8,
              borderRadius: BorderRadius.circular(8),
              backgroundColor: Colors.white,
              color: finaciPositive,
            ), // A-7 P01 · P02
            const SizedBox(height: 8),
            Text(
              '목표일 ${formatLongDate(goal.dueDate)} · 예시 데이터',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: finaciMuted),
            ),
          ],
        ),
      ),
    );
  }
}

class _ForecastScopeCard extends StatelessWidget {
  const _ForecastScopeCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: finaciAccentSurface,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FinaciMascot(size: 68),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'finaci의 안내',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: finaciPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '등록된 고정 수입·지출만 반영해요. VND는 고정 예시 환율로 환산합니다. 변동 지출, 환율 변화, 환전 수수료와 미입력 항목은 제외했어요.',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: finaciInk),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ); // A-6 P01 · P05 · P08
  }
}

class _HomeActions extends StatelessWidget {
  const _HomeActions({
    required this.onOpenSchedule,
    required this.onOpenScenario,
  });
  final VoidCallback onOpenSchedule;
  final VoidCallback onOpenScenario;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FilledButton.icon(
            onPressed: onOpenSchedule,
            icon: const Icon(Icons.calendar_month_outlined),
            label: const Text('일정 자세히 보기'),
          ),
          TextButton.icon(
            onPressed: onOpenScenario,
            icon: const Icon(Icons.auto_awesome_outlined),
            label: const Text('급여 지연 상황 비교 · 예시'),
          ),
        ],
      ),
    );
  }
}
