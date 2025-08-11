import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quran_app/surah.dart';
import 'written_model.dart';
class SurahSearchDelegate extends SearchDelegate {
  final List<Data> surahs;
  SurahSearchDelegate(this.surahs);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = surahs
        .where((surah) =>
            surah.englishName!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildList(results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = surahs
        .where((surah) =>
            surah.englishName!.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildList(suggestions);
  }

  Widget _buildList(List<Data> list) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final surah = list[index];
        return ListTile(
          title: Text(surah.englishName.toString(),
              style: TextStyle(fontFamily: 'Lateef')),
          subtitle: Text(surah.revelationType.toString(),
              style: TextStyle(fontFamily: 'Lateef')),
          trailing: Text("Ayah: ${surah.numberOfAyahs}",
              style: TextStyle(fontFamily: 'Lateef')),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SurahPage(number: surah.number!)),
            );
          },
        );
      },
    );
  }
}
