// finaci v2 — GAI3008 중간고사 (Material 3 UI 프로토타입)
//
// ┌──────── 디자인 가이드 대응표: 앱 뼈대 ──────────────────────────────────────┐
// │ 번호 │ Flutter 위젯명        │ 비즈니스 명칭(한글)      │ 원칙(P번호)       │
// │ S-1  │ MaterialApp           │ finaci                   │ —                 │
// │ S-2  │ ThemeData(Material 3) │ finaci 브랜드 색          │ P04 일관성         │
// └────────────────────────────────────────────────────────────────────────────┘
// 화면 흐름(docs/디자인가이드.md 1장과 같게):
//   A 현금흐름 홈 ──쌓기(push)──▶ B 현금흐름 일정 [기간 탭]
//      A/B ──덮기(modal)──▶ C 급여 지연 시나리오(미리 정한 예시)
//      A/B 중앙 + ──덮기(modal)──▶ D 빠른 기록(저장 없는 예시)
// 기획 문서에 없는 화면은 만들지 않는다(감점). 화면을 늘리면 이 주석·가이드도 같이 고친다.
import 'package:flutter/material.dart';

import 'screens/a_list_screen.dart';
import 'widgets.dart';

void main() => runApp(const MidProjectApp());

class MidProjectApp extends StatelessWidget {
  const MidProjectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'finaci', // S-1
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'NotoSansKR',
        colorScheme: ColorScheme.fromSeed(
          seedColor: finaciPrimary,
          surface: finaciCanvas,
          primary: finaciPrimary,
          secondary: finaciAccent,
        ),
        scaffoldBackgroundColor: finaciCanvas,
        appBarTheme: const AppBarTheme(
          backgroundColor: finaciCanvas,
          foregroundColor: finaciInk,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          margin: EdgeInsets.zero,
          elevation: 0,
          color: finaciSurface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: finaciBorder),
          ),
        ),
        dividerTheme: const DividerThemeData(color: finaciBorder, thickness: 1),
        chipTheme: ChipThemeData(
          shape: const StadiumBorder(),
          side: const BorderSide(color: finaciBorder),
          selectedColor: finaciSage,
          backgroundColor: finaciSurface,
          labelStyle: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ), // S-2 P04
      home: const ListScreen(),
    );
  }
}
