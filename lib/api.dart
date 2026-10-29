// 데이터 가져오기 — GET만 사용한다. 영구 저장/업데이트 API는 없다.
// 모든 요청은 이 파일 안에 둔다.
//
// 서버 주소 (코드 수정 없이 실행할 때 바꾼다):
//   기본값  Android 에뮬레이터 → http://10.0.2.2:3000   그 외(Chrome·macOS·iOS 시뮬레이터) → http://localhost:3000
//   실기기  flutter run --dart-define=API_BASE=http://192.168.0.10:3000   (같은 Wi-Fi의 PC IP)
//   배포    flutter build web --dart-define=API_BASE=https://<프로젝트>.vercel.app/api   (가산점)
//   같은 웹 출처 배포: flutter build web --dart-define=API_BASE=/api
//
// 발표·데모용 상태 스위치 (로딩·오류·빈 상태를 눈으로 보여 주기):
//   --dart-define=DEMO_STATE=loading → 3초 늦게 응답 (로딩 상태)
//   --dart-define=DEMO_STATE=error   → 항상 실패 (오류 상태 + 다시 시도)
//   --dart-define=DEMO_STATE=empty   → 빈 목록 (빈 상태)
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'models.dart';

const _apiBaseOverride = String.fromEnvironment('API_BASE');

/// json-server 주소. API_BASE를 넘기면 그 값, 아니면 실행 대상에 맞는 기본값.
String get apiBase {
  if (_apiBaseOverride.isNotEmpty) {
    if (kIsWeb && _apiBaseOverride.startsWith('/')) {
      return Uri.base.resolve(_apiBaseOverride).toString();
    }
    return _apiBaseOverride;
  }
  // Android 에뮬레이터 안의 localhost는 에뮬레이터 자신 → PC는 10.0.2.2
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
    return 'http://10.0.2.2:3000';
  }
  return 'http://localhost:3000';
}

/// loading(=slow) · error · empty — 그 외 값이면 평소처럼 서버에서 가져온다.
const demoState = String.fromEnvironment('DEMO_STATE');

/// 화면에 그대로 보여 줄 수 있는 오류 문장
class ApiException implements Exception {
  const ApiException(this.message);
  final String message;

  @override
  String toString() => message;
}

/// GET {apiBase}/{path} → JSON 배열
Future<List<Object?>> _getList(String path) async {
  switch (demoState) {
    case 'loading' || 'slow':
      await Future<void>.delayed(const Duration(seconds: 3));
    case 'error':
      throw const ApiException('일시적으로 자료를 불러오지 못했습니다. 연결을 확인한 뒤 다시 시도해 주세요.');
    case 'empty':
      return const [];
  }
  final url = '$apiBase/$path';
  final http.Response res;
  try {
    res = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5));
  } on Exception catch (e) {
    debugPrint('[GET 실패] $url — $e');
    throw const ApiException(
      '연결을 확인한 뒤 다시 시도해 주세요. 잠시 후에도 같은 문제가 생기면 앱을 다시 열어 주세요.',
    );
  }
  if (res.statusCode != 200) {
    debugPrint('[GET 응답 오류] HTTP ${res.statusCode} $url');
    throw const ApiException('자료를 불러오는 중 문제가 생겼습니다. 잠시 후 다시 시도해 주세요.');
  }
  // 한글이 깨지지 않도록 bytes를 UTF-8로 직접 디코딩
  final Object? decoded;
  try {
    decoded = jsonDecode(utf8.decode(res.bodyBytes));
  } on FormatException catch (e) {
    debugPrint('[GET JSON 오류] $url — $e');
    throw const ApiException('자료를 표시하지 못했습니다. 잠시 후 다시 시도해 주세요.');
  }
  if (decoded is! List) {
    debugPrint('[GET 형식 오류] $url 응답이 배열이 아닙니다.');
    throw const ApiException('자료를 표시하지 못했습니다. 잠시 후 다시 시도해 주세요.');
  }
  return decoded;
}

/// A 현금흐름 홈: GET /outlook (정적으로 준비한 화면용 예시 데이터)
Future<List<OutlookSnapshot>> fetchOutlook() async {
  final list = await _getList('outlook');
  return list.map(OutlookSnapshot.fromJson).nonNulls.toList();
}

/// B 현금흐름 일정 상세: GET /plannedPayments
Future<List<PlannedPayment>> fetchPlannedPayments() async {
  final list = await _getList('plannedPayments');
  return list.map(PlannedPayment.fromJson).nonNulls.toList();
}

/// B 일정 화면: 이미 등록된 반복 항목과 전망 예시를 각각 읽는다.
Future<ScheduleData> fetchScheduleData() async {
  final results = await Future.wait([
    _getList('plannedPayments'),
    _getList('outlook'),
  ]);
  final payments = results[0].map(PlannedPayment.fromJson).nonNulls.toList();
  final outlooks = results[1].map(OutlookSnapshot.fromJson).nonNulls.toList();
  return ScheduleData(
    payments: payments,
    outlook: outlooks.isEmpty ? null : outlooks.first,
  );
}
