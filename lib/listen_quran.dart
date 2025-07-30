import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'written_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';

class SurahMenuAudio extends StatefulWidget {
  const SurahMenuAudio({super.key});

  @override
  State<SurahMenuAudio> createState() => _SurahMenuAudioState();
}

class _SurahMenuAudioState extends State<SurahMenuAudio> {
  List<Data> surahs = [];
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isplaying = false;
  int? currentSurah;

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
          backgroundColor: Color(0xff231407),
          leading: IconButton(
            icon: Icon(CupertinoIcons.back),
            color: Color(0xffe9c359),
            onPressed: ()async {
              await _audioPlayer.stop();
              setState(() {
                
              });
              Navigator.pop(context);
            },
          ),
          actions: [],
        ),
        body: surahs.isEmpty
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xffe9c359)),
              )
            : ListView.builder(
                itemCount: surahs.length,
                itemBuilder: (context, index) {
                  final surah = surahs[index];
                  bool playingThis = isplaying && currentSurah == index + 1;
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
                    trailing: IconButton(
                      onPressed: () => PlaySurah(index + 1),
                      icon: playingThis
                          ? Icon(Icons.pause, color: Colors.red)
                          : Icon(
                              Icons.play_arrow_outlined,
                              color: Color(0xffe9c359),
                            ),
                    ),
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

  void PlaySurah(int surahNumber) async {
    String padded = surahNumber.toString().padLeft(3, '0');
    String url = "https://server8.mp3quran.net/afs/$padded.mp3";

    if (isplaying && currentSurah == surahNumber) {
      await _audioPlayer.pause();
      setState(() {
        isplaying = false;
      });
    } else if (!isplaying && currentSurah == surahNumber) {
      await _audioPlayer.resume();
      setState(() {
        isplaying = true;
      });
    } else {
      await _audioPlayer.stop();
      await _audioPlayer.play(UrlSource(url));
      setState(() {
        isplaying = true;
        currentSurah = surahNumber;
      });
    }
  }
}
