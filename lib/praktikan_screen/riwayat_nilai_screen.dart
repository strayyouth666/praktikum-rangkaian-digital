import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcare_web/reusable/project_colors.dart';
import 'package:smartcare_web/praktikan_screen/pelaksanaan_screen.dart';
import '../reusable/app_bar.dart';
import '../reusable/content_container.dart';
import '../reusable/custom_button.dart';
import '../reusable/custom_data_table.dart';
import '../reusable/list_pagination.dart';
import '../reusable/pagination_button.dart';
import '../reusable/pagination_showing_text.dart';
import '../reusable/pop_up_menu.dart';
import '../reusable/scroll_widget.dart';
import '../system/authentication.dart';
import 'daftar_praktikum_screen.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class RiwayatNilaiScreen extends StatefulWidget {
  const RiwayatNilaiScreen({Key? key}) : super(key: key);

  @override
  _RiwayatNilaiScreenState createState() => _RiwayatNilaiScreenState();
}

class _RiwayatNilaiScreenState extends State<RiwayatNilaiScreen> {
  Choice _selectedChoice = choices[0];
  @override
  Widget build(BuildContext context) {
    final testSlicing = [
      CustomDataCell(const Text("Praktikum A")),
      CustomDataCell(const Text("2 September 2022 - 16 September 2022")),
      CustomDataCell(CustomButton(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        color: ProjectColors.green,
        child: const Text(
          "A",
          style: TextStyle(fontSize: 12),
        ),
        onTap: () {},
      )),
    ];

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
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: ContentContainer(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 200, vertical: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Text("Riwayat Nilai",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.underline)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListPagination<CustomDataRow>(
                        data: List.generate(
                            5, (index) => CustomDataRow(cells: testSlicing)),
                        buttonBuilder: paginationButton,
                        builder: (paginatedData, paginationButtons, start, end,
                            length) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ScrollWidget(
                                scrollDirection: Axis.horizontal,
                                child: CustomDataTable(
                                    stripped: true,
                                    columns: const [
                                      DataColumn(
                                        label: Text(
                                          "Nama Praktikum",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Periode Praktikum",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Text(
                                          "Nilai",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                    rows: paginatedData),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  PaginationShowingText(
                                      start: start, end: end, length: length),
                                  paginationButtons,
                                ],
                              )
                            ],
                          );
                        })
                  ],
                ),
              ),
            ),
          ),
        ));
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
