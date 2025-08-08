import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/colorscheme.dart';
import 'written_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';
import 'provider.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'DeenOne',
          style: TextStyle(color: primaryColorGold, fontFamily: 'Lateef'),
        ),
        backgroundColor: primaryColorBlue,
        actions: [
          IconButton(
            icon: Icon(Icons.sunny, color: primaryColorGold),
            onPressed: Provider.of<AppProvider>(
              context,
              listen: false,
            ).changetheme,
          ),
        ],
        leading: IconButton(
          icon: Icon(CupertinoIcons.back),
          color: primaryColorGold,
          onPressed: () async {
            await _audioPlayer.stop();
            setState(() {});
            Navigator.pop(context);
          },
        ),
      ),
      body: surahs.isEmpty
          ? Center(child: CircularProgressIndicator(color: primaryColorGold))
          : ListView.builder(
              itemCount: surahs.length,
              itemBuilder: (context, index) {
                final surah = surahs[index];
                bool playingThis = isplaying && currentSurah == index + 1;
                return InkWell(
                  onTap: () => PlaySurah(index + 1),

                  child: ListTile(
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
                    trailing: IconButton(
                      onPressed: () => PlaySurah(index + 1),
                      icon: playingThis
                          ? Icon(Icons.pause, color: Colors.red)
                          : Icon(
                              Icons.play_arrow_outlined,
                              color: primaryColorBlue,
                            ),
                    ),
                  ),
                );
              },
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
