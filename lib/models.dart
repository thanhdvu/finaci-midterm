// JSON models: field names mirror mock_server/db.json.

class OutlookSnapshot {
  const OutlookSnapshot({
    required this.id,
    required this.goalDate,
    required this.actualKrw,
    required this.projectedKrw,
    required this.balances,
    required this.actualTimeline,
    required this.forecastTimeline,
    required this.upcomingPayments,
    required this.goal,
  });

  final int id;
  final String goalDate;
  final int actualKrw;
  final int projectedKrw;
  final List<CurrencyBalance> balances;
  final List<BalancePoint> actualTimeline;
  final List<BalancePoint> forecastTimeline;
  final List<PlannedPayment> upcomingPayments;
  final SavingsGoal goal;

  static OutlookSnapshot? fromJson(Object? json) => switch (json) {
    {
      'id': int id,
      'goalDate': String goalDate,
      'actualKrw': int actualKrw,
      'projectedKrw': int projectedKrw,
      'balances': List<Object?> balances,
      'actualTimeline': List<Object?> actualTimeline,
      'forecastTimeline': List<Object?> forecastTimeline,
      'upcomingPayments': List<Object?> payments,
      'goal': Object? goal,
    } =>
      OutlookSnapshot(
        id: id,
        goalDate: goalDate,
        actualKrw: actualKrw,
        projectedKrw: projectedKrw,
        balances: balances.map(CurrencyBalance.fromJson).nonNulls.toList(),
        actualTimeline: actualTimeline
            .map(BalancePoint.fromJson)
            .nonNulls
            .toList(),
        forecastTimeline: forecastTimeline
            .map(BalancePoint.fromJson)
            .nonNulls
            .toList(),
        upcomingPayments: payments
            .map(PlannedPayment.fromJson)
            .nonNulls
            .toList(),
        goal: SavingsGoal.fromJson(goal) ?? SavingsGoal.empty,
      ),
    _ => null,
  };
}

class CurrencyBalance {
  const CurrencyBalance({required this.currency, required this.amount});
  final String currency;
  final int amount;

  static CurrencyBalance? fromJson(Object? json) => switch (json) {
    {'currency': String currency, 'amount': int amount} => CurrencyBalance(
      currency: currency,
      amount: amount,
    ),
    _ => null,
  };
}

class BalancePoint {
  const BalancePoint({
    required this.label,
    required this.amount,
    required this.barHeight,
  });
  final String label;
  final int amount;
  final int barHeight;

  static BalancePoint? fromJson(Object? json) => switch (json) {
    {'label': String label, 'amount': int amount, 'barHeight': int barHeight} =>
      BalancePoint(label: label, amount: amount, barHeight: barHeight),
    _ => null,
  };
}

class PlannedPayment {
  const PlannedPayment({
    required this.id,
    required this.date,
    required this.name,
    required this.category,
    required this.amount,
    required this.currency,
    required this.type,
    required this.source,
    required this.visibleIn,
  });

  final int id;
  final String date;
  final String name;
  final String category;
  final int amount;
  final String currency;
  final String type;
  final String source;
  final List<String> visibleIn;

  static PlannedPayment? fromJson(Object? json) => switch (json) {
    {
      'id': int id,
      'date': String date,
      'name': String name,
      'category': String category,
      'amount': int amount,
      'currency': String currency,
      'type': String type,
      'source': String source,
    } =>
      PlannedPayment(
        id: id,
        date: date,
        name: name,
        category: category,
        amount: amount,
        currency: currency,
        type: type,
        source: source,
        visibleIn: switch (json['visibleIn']) {
          List<Object?> visibleIn => visibleIn.whereType<String>().toList(),
          _ => const <String>[],
        },
      ),
    _ => null,
  };
}

class SavingsGoal {
  const SavingsGoal({
    required this.name,
    required this.savedAmount,
    required this.targetAmount,
    required this.currency,
    required this.dueDate,
    required this.progress,
  });

  static const empty = SavingsGoal(
    name: '',
    savedAmount: 0,
    targetAmount: 0,
    currency: 'KRW',
    dueDate: '',
    progress: 0,
  );

  final String name;
  final int savedAmount;
  final int targetAmount;
  final String currency;
  final String dueDate;
  final double progress;

  static SavingsGoal? fromJson(Object? json) => switch (json) {
    {
      'name': String name,
      'savedAmount': int savedAmount,
      'targetAmount': int targetAmount,
      'currency': String currency,
      'dueDate': String dueDate,
      'progress': num progress,
    } =>
      SavingsGoal(
        name: name,
        savedAmount: savedAmount,
        targetAmount: targetAmount,
        currency: currency,
        dueDate: dueDate,
        progress: progress.toDouble(),
      ),
    _ => null,
  };
}

typedef OutlookLoader = Future<List<OutlookSnapshot>> Function();

class ScheduleData {
  const ScheduleData({required this.payments, required this.outlook});
  final List<PlannedPayment> payments;
  final OutlookSnapshot? outlook;
}

typedef ScheduleLoader = Future<ScheduleData> Function();
