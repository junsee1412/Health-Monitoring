class DataMonitor {
  final int hr;
  final int spO2;
  final int rr;
  final int abp;
  final String date = DateTime.now().toString();

  DataMonitor({
    required this.hr,
    required this.spO2,
    required this.rr,
    required this.abp,
  });

  Map<String, dynamic> toMap() {
    return {
      'hr': hr,
      'spO2': spO2,
      'rr': rr,
      'abp': abp,
      'date': date
    };
  }
}