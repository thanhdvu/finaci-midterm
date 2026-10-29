// 화면 D — 빠른 기록 BottomSheet (UI 예시, 영구 저장 없음)
// ┌──────── 디자인 가이드 대응표: D 빠른 기록 ────────────────────────────────┐
// │ D-1 SegmentedButton                       수입·지출·이체 선택      P07     │
// │ D-2 TextField                              금액 입력                P02     │
// │ D-3 ChoiceChip                             거래 통화 선택           P02·P06 │
// │ D-4 ChoiceChip                             분류 선택                P07     │
// │ D-5 ListTile                               날짜 확인                P02     │
// │ D-6 FilledButton                           예시 추가 응답           P01·P10 │
// └─────────────────────────────────────────────────────────────────────────┘
import 'package:flutter/material.dart';

import '../widgets.dart';

enum _RecordType { expense, income, transfer }

class QuickAddBottomSheet extends StatefulWidget {
  const QuickAddBottomSheet({super.key});

  static Future<void> show(BuildContext context) async {
    final added = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: finaciCanvas,
      builder: (_) => const QuickAddBottomSheet(),
    );
    if (added == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('수업용 예시예요. 이 기록은 저장되지 않았습니다.')),
      );
    }
  }

  @override
  State<QuickAddBottomSheet> createState() => _QuickAddBottomSheetState();
}

class _QuickAddBottomSheetState extends State<QuickAddBottomSheet> {
  // STATE: 거래 종류·통화·분류 → D-1, D-3, D-4의 선택 표시만 변경
  _RecordType _type = _RecordType.expense;
  String _currency = 'KRW';
  String _category = '식비';

  List<String> get _categories => switch (_type) {
    _RecordType.expense => ['식비', '주거', '교통', '기타'],
    _RecordType.income => ['급여', '가족 지원', '기타'],
    _RecordType.transfer => ['계좌 간 이체'],
  };

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 16 + bottomInset),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        '빠른 기록',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: finaciInk,
                        ),
                      ),
                    ),
                    IconButton(
                      tooltip: '닫기',
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                SegmentedButton<_RecordType>(
                  segments: const [
                    ButtonSegment(
                      value: _RecordType.expense,
                      label: Text('지출'),
                    ),
                    ButtonSegment(value: _RecordType.income, label: Text('수입')),
                    ButtonSegment(
                      value: _RecordType.transfer,
                      label: Text('이체'),
                    ),
                  ],
                  selected: {_type},
                  // STATE: 선택한 거래 종류에 맞춰 화면 안의 분류 칩만 갱신
                  onSelectionChanged: (value) => setState(() {
                    _type = value.first;
                    _category = _categories.first;
                  }),
                ), // D-1 P07
                const SizedBox(height: 14),
                TextField(
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: InputDecoration(
                    labelText: '금액',
                    hintText: '금액 입력',
                      prefixText: switch (_currency) {
                        'KRW' => '₩ ',
                        'VND' => '₫ ',
                        'USD' => '\$ ',
                        'EUR' => '€ ',
                        _ => '¥ ',
                      },
                    filled: true,
                    fillColor: finaciSurface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: finaciBorder),
                    ),
                  ),
                ), // D-2 P02
                const SizedBox(height: 12),
                Text('거래 통화', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                    runSpacing: 8,
                  children: [
                    for (final currency in ['KRW', 'VND', 'USD', 'EUR', 'JPY'])
                      ChoiceChip(
                        label: Text(
                          currency,
                        ),
                        selected: _currency == currency,
                        onSelected: (_) => setState(() => _currency = currency),
                      ),
                  ],
                ), // D-3 P02 · P06
                const SizedBox(height: 12),
                Text('분류', style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  children: [
                    for (final category in _categories)
                      ChoiceChip(
                        label: Text(category),
                        selected: _category == category,
                        onSelected: (_) => setState(() => _category = category),
                      ),
                  ],
                ), // D-4 P07
                const SizedBox(height: 8),
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.calendar_today_outlined),
                    title: Text('날짜'),
                    trailing: Text('오늘'),
                  ),
                ), // D-5 P02
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () => Navigator.of(context).pop(true),
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('기록 추가'),
                  ),
                ), // D-6 P01 · P10
                const SizedBox(height: 6),
                Center(
                  child: Text(
                    '수업용 UI 예시 · 실제 저장은 하지 않습니다',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: finaciMuted),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

