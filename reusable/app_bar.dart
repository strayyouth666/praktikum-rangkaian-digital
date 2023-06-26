import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcare_web/reusable/clickable_ripple.dart';
import 'package:smartcare_web/reusable/project_colors.dart';
import 'package:smartcare_web/reusable/user_popup.dart';
import 'package:smartcare_web/praktikan_screen/daftar_praktikum_screen.dart';
import 'package:smartcare_web/praktikan_screen/home_screen.dart';
import 'package:smartcare_web/praktikan_screen/pelaksanaan_screen.dart';
import 'package:smartcare_web/praktikan_screen/riwayat_nilai_screen.dart';
import 'package:dropdown_search/dropdown_search.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ProjectColors.darkBlack,
      width: 1280,
      height: 80,
      child: Row(
        children: [
          const SizedBox(
            width: 100,
          ),
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
              'lib/assets/Praktikum RDIG TKOMPUTER ITS.png',
              scale: 0.5,
              width: 200,
            ),
            onPressed: () {
              Get.to(const HomeScreen());
            },
          ),
          const SizedBox(
            width: 200,
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
          // ClickableRipple(
          //   onTap: PopupMenuButton<>,
          //   child: Image.asset('lib/assets/logo profile.png',
          //     scale: 0.5,
          //     width: 20,),
          // ),
        ],
      ),
    );
  }
}
