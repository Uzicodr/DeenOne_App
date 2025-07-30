import 'package:flutter/material.dart';
import 'package:quran_app/surah.dart';
import 'written_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SurahMenuWritten extends StatefulWidget {
  const SurahMenuWritten({super.key});

  @override
  State<SurahMenuWritten> createState() => _SurahMenuWrittenState();
}

class _SurahMenuWrittenState extends State<SurahMenuWritten> {
  List<Data> surahs = [];

  @override
  void initState() {
    super.initState();
    FetchSurahs();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Quran App",
            style: TextStyle(color: Color(0xffe9c359), fontFamily: 'Lateef'),
          ),
          backgroundColor: Color(0xff231407),
        ),
        body: surahs.isEmpty
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xffe9c359)),
              )
            : ListView.builder(
                itemCount: surahs.length,
                itemBuilder: (context, index) {
                  final surah = surahs[index];
                  return ListTile(
                    title: Text(
                      surah.englishName.toString(),
                      style: TextStyle(fontFamily: 'Lateef'),
                    ),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage('assets/logo.png'),
                    ),
                    subtitle: Text(
                      surah.revelationType.toString(),
                      style: TextStyle(fontFamily: 'Lateef'),
                    ),
                    trailing: Text("Ayah: ${surah.numberOfAyahs.toString()}",style: TextStyle(fontFamily: 'Lateef',fontSize: 14),),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SurahPage(number: surah.number!),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }

  void FetchSurahs() async {
    final url = 'https://api.alquran.cloud/v1/surah';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final body = response.body;
      final json = jsonDecode(body);
      final QuranModel quranModel = QuranModel.fromJson(json);

      setState(() {
        surahs = quranModel.data ?? [];
      });
    } else {
      print('Failed to fetch data');
    }
  }
}
