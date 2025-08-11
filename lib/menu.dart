import 'package:flutter/material.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:provider/provider.dart';
import 'package:quran_app/colorscheme.dart';
import 'package:quran_app/counter.dart';
import 'package:quran_app/listen_quran.dart';
import 'package:quran_app/namaz_timing.dart';
import 'package:quran_app/provider.dart';
import 'package:quran_app/read_quran.dart';

class MenuItem{
  final String title;
  final IconData icon;
  final Widget destination;

  MenuItem({required this.title, required this.icon, required this.destination});
}

final List<MenuItem> menuItems = [
  MenuItem(
    title: "Read Quran",
    icon: FlutterIslamicIcons.solidQuran2,
    destination: SurahMenuWritten(),
  ),
  MenuItem(
    title: "Listen Quran",
    icon: Icons.headphones,
    destination: ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: SurahMenuAudio(),
    ),
  ),
  MenuItem(
    title: "Prayer Times",
    icon: FlutterIslamicIcons.solidPrayingPerson,
    destination: NamazTiming(),
  ),
  MenuItem(
    title: "Tasbeeh",
    icon: FlutterIslamicIcons.solidTasbihHand,
    destination: ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: TasbeehCounter(),
    ),
  ),
];

class MenuCard extends StatelessWidget {
  final MenuItem item;

  const MenuCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: primaryColorGold,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => item.destination),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
          child: Column(
            children: [
              Icon(item.icon, color: primaryColorBlue, size: 45),
              Text(
                item.title,
                style: TextStyle(
                  fontFamily: 'Lateef',
                  fontSize: 32,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColorBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            children: [
              Text(
                "خوش آمدید",
                style: TextStyle(
                  fontFamily: 'Lateef',
                  fontSize: 48,
                  color: primaryColorGold,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),

              // Scalable Menu
              Expanded(
                child: ListView.separated(
                  itemCount: menuItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    return MenuCard(item: menuItems[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
