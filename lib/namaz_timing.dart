import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:quran_app/colorscheme.dart';
import 'package:quran_app/namaz_time_model.dart';

class NamazTiming extends StatefulWidget {
  const NamazTiming({super.key});

  @override
  State<NamazTiming> createState() => _NamazTimingState();
}

class _NamazTimingState extends State<NamazTiming> {
  PrayerTimings? timings;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    try {
      final loc = await getLocation();
      final result = await fetchPrayerTimes(loc.latitude, loc.longitude);
      setState(() {
        timings = result;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<PrayerTimings> fetchPrayerTimes(double lat, double lon) async {
    final response = await http.get(
      Uri.parse(
        "https://api.aladhan.com/v1/timings?latitude=$lat&longitude=$lon&method=2",
      ),
    );

    if (response.statusCode == 200) {
      return PrayerTimings.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load prayer times');
    }
  }

  Future<Position> getLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) throw Exception("Location disabled");

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location denied");
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  Widget buildPrayerCard({
    required String title,
    required String time,
    required List<Color> gradientColors,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: gradientColors.last.withOpacity(0.4),
              blurRadius: 8,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'Lateef',
              fontSize: 28,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
          trailing: Text(
            time,
            style: TextStyle(
              fontFamily: 'Lateef',
              fontSize: 24,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Namaaz Timing',
          style: TextStyle(color: primaryColorGold, fontFamily: 'Lateef'),
        ),
        backgroundColor: primaryColorBlue,
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          color: primaryColorGold,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: timings == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                const SizedBox(height: 16),
                buildPrayerCard(
                  title: 'Fajr',
                  time: timings!.fajr ?? '-',
                  gradientColors: [Color(0xffb3e5fc), Color(0xfff8bbd0)],
                ),
                buildPrayerCard(
                  title: 'Dhuhr',
                  time: timings!.dhuhr ?? '-',
                  gradientColors: [Color(0xfffff176), Color(0xffffd54f)],
                ),
                buildPrayerCard(
                  title: 'Asr',
                  time: timings!.asr ?? '-',
                  gradientColors: [Color(0xffffe082), Color(0xffffb74d)],
                ),
                buildPrayerCard(
                  title: 'Maghrib',
                  time: timings!.maghrib ?? '-',
                  gradientColors: [Color(0xffff8a65), Color(0xffce93d8)],
                ),
                buildPrayerCard(
                  title: 'Isha',
                  time: timings!.isha ?? '-',
                  gradientColors: [Color(0xff3f51b5), Color(0xff1a237e)],
                ),
                const SizedBox(height: 16),
              ],
            ),
    );
  }
}
