class PrayerTimings {
  final String fajr, dhuhr, asr, maghrib, isha;

  PrayerTimings({required this.fajr, required this.dhuhr, required this.asr, required this.maghrib, required this.isha});

  factory PrayerTimings.fromJson(Map<String, dynamic> json) {
    final timings = json['data']['timings'];
    return PrayerTimings(
      fajr: timings['Fajr'],
      dhuhr: timings['Dhuhr'],
      asr: timings['Asr'],
      maghrib: timings['Maghrib'],
      isha: timings['Isha'],
    );
  }

  get data => null;
}
