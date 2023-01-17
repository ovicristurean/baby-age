class PregnancyProgress {
  final int weeks;
  final int days;
  final int totalNumberOfDays;
  final Trimester trimester;

  PregnancyProgress({
    required this.weeks,
    required this.days,
    required this.totalNumberOfDays,
    required this.trimester,
  });
}

enum Trimester {
  ONE(1),
  TWO(2),
  THREE(3),
  INVALID(0);

  final int number;

  const Trimester(this.number);
}
