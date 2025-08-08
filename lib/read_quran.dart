import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/surah.dart';
import 'written_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'colorscheme.dart';

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
            "DeenOne",
            style: TextStyle(color: primaryColorGold, fontFamily: 'Lateef'),
          ),
          backgroundColor: primaryColorBlue,
          leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          color: primaryColorGold,
          onPressed: (){
            Navigator.pop(context);
          },
        )
        ),
        body: surahs.isEmpty
            ? Center(
                child: CircularProgressIndicator(color: primaryColorGold),
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
                      backgroundColor: primaryColorBlue,
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
