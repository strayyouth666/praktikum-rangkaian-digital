import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcare_web/reusable/project_colors.dart';
import 'package:smartcare_web/praktikan_screen/pelaksanaan_screen.dart';
import 'package:smartcare_web/praktikan_screen/riwayat_nilai_screen.dart';
import '../reusable/app_bar.dart';
import '../reusable/pop_up_menu.dart';
import '../system/authentication.dart';
import 'daftar_praktikum_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Choice _selectedChoice = choices[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ProjectColors.darkBlack,
        actions: [
          MaterialButton(
            child: Image.asset(
              'lib/assets/logo its.png',
              scale: 0.5,
              width: 50,
            ),
            onPressed: () {
              Get.to(const HomeScreen());
            },
          ),
          const SizedBox(
            width: 20,
          ),
          MaterialButton(
            child: Image.asset(
              'lib/assets/logoptki.png',
              scale: 0.5,
              width: 200,
            ),
            onPressed: () {
              Get.to(const HomeScreen());
            },
          ),
          const SizedBox(
            width: 100,
          ),
          MaterialButton(
            child: Image.asset(
              'lib/assets/Daftar Praktikum.png',
              scale: 0.5,
              width: 100,
            ),
            onPressed: () {
              Get.to(const DaftarPraktikumScreen());
            },
          ),
          const SizedBox(
            width: 50,
          ),
          MaterialButton(
            child: Image.asset(
              'lib/assets/Pelaksanaan.png',
              scale: 0.5,
              width: 80,
            ),
            onPressed: () {
              Get.to(const PelaksanaanScreen());
            },
          ),
          const SizedBox(
            width: 50,
          ),
          MaterialButton(
            child: Image.asset(
              'lib/assets/Riwayat Nilai.png',
              scale: 0.5,
              width: 80,
            ),
            onPressed: () {
              Get.to(const RiwayatNilaiScreen());
            },
          ),
          const SizedBox(
            width: 200,
          ),
          PopUpMenu(
            menuList: [
              PopupMenuItem(
                  child: ListTile(
                leading: const Icon(
                  Icons.logout,
                ),
                title: const Text("Log Out"),
                onTap: () {
                  Get.to(const LoginScreen());
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: ProjectColors.green,
                      content: Text("Log Out Successfull.")));
                  // Authentication().signOut();
                },
              ))
            ],
            icon: const Icon(Icons.account_circle),
          ),
          const SizedBox(
            width: 100,
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'lib/assets/kotak home1.png',
                  scale: 1.5,
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset('lib/assets/kotak home2.png', scale: 1.5),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _select(Choice choice) {
    setState(() {
      _selectedChoice = choice;
    });
  }
}

class Choice {
  const Choice({required this.title, required this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'Car', icon: Icons.directions_car),
  Choice(title: 'Bicycle', icon: Icons.directions_bike),
];
