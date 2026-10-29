// 화면 C — 급여 지연 상황 비교 (미리 작성한 예시 응답)
// ┌──────── 디자인 가이드 대응표: C 급여 지연 시나리오 ────────────────────────────┐
// │ C-1 showModalBottomSheet + IconButton         시나리오 닫기         P03     │
// │ C-2 Text                                       질문                   P02     │
// │ C-3 LayoutBuilder + Card                       기본/지연 잔액 예시    P01     │
// │ C-4 Card + FinaciMascot + Text                 예시 응답 안내         P10     │
// │ C-5 Card + Text                                가정/미포함 항목       P01·P05 │
// └──────────────────────────────────────────────────────────────────────────────┘
import 'package:flutter/material.dart';

import '../widgets.dart';

class ScenarioBottomSheet extends StatelessWidget {
  const ScenarioBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: finaciCanvas,
      builder: (_) => const ScenarioBottomSheet(),
    ); // C-1 P03
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text('급여 지연 상황 비교', style: text.headlineSmall),
                      ),
                      IconButton(
                        tooltip: '닫기',
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '2월 25일 아르바이트 급여가 7일 늦어지면?',
                    style: text.titleMedium,
                  ), // C-2 P02
                  const SizedBox(height: 4),
                  Text(
                    '예정 입금일 2월 25일 · 지연 시 3월 4일\n목표일 ${formatLongDate('2027-02-28')} 기준',
                    style: text.bodyMedium?.copyWith(color: finaciMuted),
                  ),
                  const SizedBox(height: 16),
                  constraints.maxWidth >= 560
                      ? const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _ScenarioResultCard(isDelayed: false),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: _ScenarioResultCard(isDelayed: true),
                            ),
                          ],
                        )
                      : const Column(
                          children: [
                            _ScenarioResultCard(isDelayed: false),
                            SizedBox(height: 10),
                            _ScenarioResultCard(isDelayed: true),
                          ],
                        ), // C-3 P01
                  const SizedBox(height: 12),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '이 예시에서 보는 점',
                            style: text.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            '이 경우 급여 ₩380,000이 목표일 뒤에 들어와요. 목표일까지 쓸 수 있는 예상 금액이 줄어드는 예시입니다. 목표일 전에 입금되는 지연이라면 이 비교 결과와 달라질 수 있어요.',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Card(
                    color: finaciSage,
                    child: const Padding(
                      padding: EdgeInsets.all(14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FinaciMascot(size: 64),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'finaci의 시나리오 안내',
                                  style: TextStyle(
                                    color: finaciPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '수업용 예시 응답입니다. 실제 AI 호출이나 금융 조언이 아니며, 표시 금액도 미리 정한 값입니다.',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ), // C-4 P10
                  const SizedBox(height: 8),
                  Card(
                    color: finaciAccentSurface,
                    child: const ListTile(
                      leading: Icon(
                        Icons.info_outline_rounded,
                        color: finaciAccentText,
                      ),
                      title: Text('가정과 제외 항목'),
                      subtitle: Text(
                        '1 KRW = 20 VND의 고정 예시 환율과 등록된 고정 항목만 반영했어요. 변동 지출, 환율 변화, 환전 수수료와 미입력 항목은 제외합니다. 예상값은 보장 잔액이 아닙니다.',
                      ),
                    ),
                  ), // C-5 P01 · P05
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ScenarioResultCard extends StatelessWidget {
  const _ScenarioResultCard({required this.isDelayed});
  final bool isDelayed;

  @override
  Widget build(BuildContext context) {
    final color = isDelayed ? finaciAccentText : finaciPositive;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isDelayed
                      ? Icons.schedule_rounded
                      : Icons.check_circle_outline_rounded,
                  color: color,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    isDelayed ? '급여 7일 지연' : '예정일 입금',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(
              isDelayed ? '₩2,755,000' : '₩3,135,000',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: finaciInk,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '목표일 잔액 예시',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: finaciMuted),
            ),
            const SizedBox(height: 12),
            Text(
              isDelayed
                  ? '목표 ₩3,000,000보다 ₩245,000 부족한 예시'
                  : '목표 ₩3,000,000보다 ₩135,000 남는 예시',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
