// 공용 화면 조각 — GET을 쓰는 화면은 모두 이 세 상태를 그린다 (AGENTS.md MUST).
//   LoadingView  불러오는 중   P01 시스템 상태의 가시성 (예)
//   ErrorView    오류 + 다시 시도   P09 오류 인식·진단·복구 (예)
//   EmptyView    빈 목록 안내   P01 (예)
// 문구는 디자인 가이드의 명칭과 A/B 화면의 데이터 상태를 따른다.
import 'package:flutter/material.dart';

// finaci 브랜드 팔레트: 따뜻한 아이보리, 올리브, 세이지, 테라코타.
const finaciPrimary = Color(0xFF4F5B3A);
const finaciOlive = Color(0xFF687451);
const finaciPositive = Color(0xFF4F5B3A);
const finaciAccent = Color(0xFFB5674C);
const finaciInk = Color(0xFF292D27);
const finaciMuted = Color(0xFF686B61);
const finaciCanvas = Color(0xFFF7F4EC);
const finaciSurface = Color(0xFFFFFEFA);
const finaciSage = Color(0xFFE5E9DC);
const finaciCream = Color(0xFFF2E8D3);
const finaciBorder = Color(0xFFDCD7CB);
const finaciAccentSurface = Color(0xFFF4E6DE);
// Darker text/icon companion keeps small expense labels readable on light cards.
const finaciAccentText = Color(0xFF8F4D3A);

/// finaci ribbon mascot asset, used as a small contextual guide.
class FinaciMascot extends StatelessWidget {
  const FinaciMascot({super.key, this.size = 56});

  final double size;

  @override
  Widget build(BuildContext context) => Image.asset(
    'assets/mascot/finaci-explaining.png',
    width: size,
    height: size,
    fit: BoxFit.contain,
    semanticLabel: 'finaci 안내 캐릭터',
  );
}

/// Wallet-inspired navigation shell; destinations outside the planned A/B flow
/// return a short demo message instead of opening unplanned screens.
class FinaciBottomNavigationBar extends StatelessWidget {
  const FinaciBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) => NavigationBar(
    selectedIndex: selectedIndex,
    onDestinationSelected: onDestinationSelected,
    backgroundColor: finaciSurface,
    indicatorColor: finaciSage,
    destinations: const [
      NavigationDestination(
        icon: Icon(Icons.account_balance_wallet_outlined),
        selectedIcon: Icon(Icons.account_balance_wallet_rounded),
        label: '대시보드',
      ),
      NavigationDestination(
        icon: Icon(Icons.schedule_outlined),
        selectedIcon: Icon(Icons.schedule_rounded),
        label: '계획',
      ),
      NavigationDestination(
        icon: Icon(Icons.add_circle_rounded, size: 38, color: finaciPrimary),
        label: '추가',
      ),
      NavigationDestination(
        icon: Icon(Icons.bar_chart_outlined),
        selectedIcon: Icon(Icons.bar_chart_rounded),
        label: '통계',
      ),
      NavigationDestination(icon: Icon(Icons.more_horiz_rounded), label: '더보기'),
    ],
  );
}

String formatMoney(String currency, int amount) {
  final digits = amount.toString();
  final grouped = digits.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => ',',
  );
  return switch (currency) {
    'KRW' => '₩$grouped',
    'VND' => '₫$grouped',
    _ => '$grouped $currency',
  };
}

String formatShortDate(String isoDate) {
  final parts = isoDate.split('-');
  if (parts.length != 3) return isoDate;
  return '${parts[1]}월 ${int.tryParse(parts[2]) ?? parts[2]}일';
}

String formatLongDate(String isoDate) {
  final parts = isoDate.split('-');
  if (parts.length != 3) return isoDate;
  return '${parts[0]}년 ${int.tryParse(parts[1]) ?? parts[1]}월 ${int.tryParse(parts[2]) ?? parts[2]}일';
}

/// 로딩 상태
class LoadingView extends StatelessWidget {
  const LoadingView({super.key, this.label = '불러오는 중…'});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 12),
          Text(label),
        ],
      ),
    );
  }
}

/// 오류 상태: 무엇이 잘못됐는지 + 다시 시도 버튼
class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    this.title = '정보를 불러오지 못했습니다.',
    this.message = '',
    required this.onRetry,
  });

  final String title;
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off, size: 48),
            const SizedBox(height: 12),
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            if (message.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(message, textAlign: TextAlign.center),
            ],
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('다시 시도'),
            ),
          ],
        ),
      ),
    );
  }
}

/// 빈 상태: 목록이 비었을 때 안내
class EmptyView extends StatelessWidget {
  const EmptyView({super.key, this.message = '표시할 항목이 없습니다.'});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FinaciMascot(size: 72),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

/// 네트워크 이미지 — 실패해도 화면은 그대로 보이게
class NetImage extends StatelessWidget {
  const NetImage(this.url, {super.key, this.width, this.height});

  final String url;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stack) => SizedBox(
        width: width,
        height: height,
        child: const Icon(Icons.image_outlined, size: 40),
      ),
    );
  }
}
