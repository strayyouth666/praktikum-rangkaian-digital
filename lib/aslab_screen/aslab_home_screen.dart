import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcare_web/aslab_screen/atur_jadwal_screen.dart';
import 'package:smartcare_web/aslab_screen/penilaian.dart';
import 'package:smartcare_web/aslab_screen/plotting_screen.dart';
import 'package:smartcare_web/aslab_screen/pop_up_screen.dart';
import 'package:smartcare_web/reusable/content_container.dart';
import 'package:smartcare_web/reusable/custom_input.dart';
import 'package:smartcare_web/reusable/input_label.dart';
import 'package:smartcare_web/reusable/project_colors.dart';
import 'package:smartcare_web/reusable/scroll_widget.dart';
import '../praktikan_screen/login_screen.dart';
import '../reusable/pop_up_menu.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_html/js.dart' as js;
import 'package:smartcare_web/abstract/form_ui.dart' as ui;

class AslabHomeScreen extends StatefulWidget {
  const AslabHomeScreen({Key? key}) : super(key: key);

  @override
  _AslabHomeScreenState createState() => _AslabHomeScreenState();
}

class _AslabHomeScreenState extends State<AslabHomeScreen> {
  final _keyHtml1 = GlobalKey();
  late js.JsObject connector1;
  String createdViewId1 = '1';
  late html.IFrameElement element1;
  Choice _selectedChoice = choices[0];
  late final TextEditingController pengumumanController;

  @override
  void initState() {
    super.initState();

    pengumumanController = TextEditingController();

    js.context["connect_content_to_flutter"] = (js.JsObject content) {
      connector1 = content;
    };

    element1 = html.IFrameElement()
      ..src = "/assets/html/editor.html"
      ..style.border = 'none';

    ui.platformViewRegistry
        .registerViewFactory(createdViewId1, (int viewId) => element1);
  }

  @override
  void dispose() {
    pengumumanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

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
              Get.to(const AslabHomeScreen());
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
              Get.to(const AslabHomeScreen());
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
              Get.to(const AturJadwalScreen());
            },
          ),
          const SizedBox(
            width: 50,
          ),
          MaterialButton(
            child: Image.asset(
              'lib/assets/Pelaksanaann.png',
              scale: 0.5,
              width: 80,
            ),
            onPressed: () {
              Get.to(const PlottingScreen());
            },
          ),
          const SizedBox(
            width: 50,
          ),
          MaterialButton(
            child: Image.asset(
              'lib/assets/Penilaiann.png',
              scale: 0.5,
              width: 60,
            ),
            onPressed: () {
              Get.to(const PenilaianScreen());
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
            Form(
              onChanged: () {
                formKey.currentState!.validate();
              },
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      children: [
                        ContentContainer(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50),
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          MaterialButton(
                                            child: const Icon(
                                              Icons.account_circle,
                                              size: 50,
                                            ),
                                            onPressed: () {},
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          SizedBox(
                                            width: 400,
                                            child: CustomInput(
                                              keyboardType: TextInputType.text,
                                              lineExpand: true,
                                              controller: pengumumanController,
                                              hint: "Tulis Pengumuman...",
                                              // required: true,
                                              // validator: (val) {
                                              //   return Validators(value: val!)
                                              //       .nonEmptyValueValidator();
                                              // },
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          MaterialButton(
                                            onPressed: () {},
                                            color: Colors.grey,
                                            child: Text(
                                              "KIRIM",
                                              style: GoogleFonts.lato(
                                                textStyle: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ContentContainer(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 70),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Pemberitahuan",
                                style: GoogleFonts.lato(
                                    textStyle: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
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
