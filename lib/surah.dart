import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'surah_model.dart';

class SurahPage extends StatefulWidget {
  final int number;
  const SurahPage({super.key, required this.number});

  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  SurahModel? surahArabic;
  SurahModel? surahTranslation;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchSurah();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text("Surah ${widget.number}")),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (surahArabic == null || surahTranslation == null) {
      return Scaffold(
        appBar: AppBar(title: Text("Surah ${widget.number}")),
        body: const Center(child: Text("Failed to load Surah")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          surahArabic!.data!.englishName ?? "Surah",
          style: TextStyle(color: Color(0xffe9c359), fontFamily: 'Lateef'),
        ),
        backgroundColor: Color(0xff231407),
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          color: Color(0xffe9c359),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [],
      ),
      body: ListView.builder(
        itemCount: surahArabic!.data!.ayahs!.length,
        itemBuilder: (context, index) {
          final arabicAyah = surahArabic!.data!.ayahs![index];
          final transAyah = surahTranslation!.data!.ayahs![index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    arabicAyah.text ?? "",
                    style: const TextStyle(fontSize: 26, fontFamily: 'Lateef'),
                    textAlign: TextAlign.right,
                  ),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      transAyah.text ?? "",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Color(0xff231407)),
        child: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.play_circle_outline_sharp),
              iconSize: 36,
              color: Color(0xffe9c359),
            ),
          ],
        ),
      ),
    );
  }

  void fetchSurah() async {
    final arabicUrl =
        'https://api.alquran.cloud/v1/surah/${widget.number}/ar.alafasy';
    final transUrl =
        'https://api.alquran.cloud/v1/surah/${widget.number}/en.asad';

    final arabicRes = await http.get(Uri.parse(arabicUrl));
    final transRes = await http.get(Uri.parse(transUrl));

    if (arabicRes.statusCode == 200 && transRes.statusCode == 200) {
      final arabicJson = jsonDecode(arabicRes.body);
      final transJson = jsonDecode(transRes.body);

      setState(() {
        surahArabic = SurahModel.fromJson(arabicJson);
        surahTranslation = SurahModel.fromJson(transJson);
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }
}
