import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smartcare_web/system/api.dart';
import 'package:smartcare_web/reusable/content_container.dart';
import 'package:smartcare_web/reusable/custom_button.dart';
import 'package:smartcare_web/reusable/custom_dropdown.dart';
import 'package:smartcare_web/reusable/project_colors.dart';
import 'package:smartcare_web/praktikan_screen/pelaksanaan_screen.dart';
import 'package:smartcare_web/praktikan_screen/riwayat_nilai_screen.dart';
import '../reusable/app_bar.dart';
import '../reusable/custom_data_table.dart';
import '../reusable/custom_datepicker.dart';
import '../reusable/custom_datepicker_form_field.dart';
import '../reusable/custom_dropdown_form_field.dart';
import '../reusable/helpers.dart';
import '../reusable/list_pagination.dart';
import '../reusable/pagination_button.dart';
import '../reusable/pagination_showing_text.dart';
import '../reusable/pop_up_menu.dart';
import '../reusable/scroll_widget.dart';
import '../reusable/validators.dart';
import '../system/authentication.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class PilihJadwalScreen extends StatefulWidget {
  const PilihJadwalScreen({Key? key}) : super(key: key);

  @override
  _PilihJadwalScreenState createState() => _PilihJadwalScreenState();
}

class _PilihJadwalScreenState extends State<PilihJadwalScreen> {
  late CustomDatePickerController modul1DateController,
      modul2DateController,
      modul3DateController,
      modul4DateController;
  late CustomDropdownController<String> time1Controller,
      time2Controller,
      time3Controller,
      time4Controller;

  Choice _selectedChoice = choices[0];

  @override
  void initState() {
    super.initState();
    modul1DateController = CustomDatePickerController();
    modul2DateController = CustomDatePickerController();
    modul3DateController = CustomDatePickerController();
    modul4DateController = CustomDatePickerController();
    time1Controller = CustomDropdownController();
    time2Controller = CustomDropdownController();
    time3Controller = CustomDropdownController();
    time4Controller = CustomDropdownController();
  }

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
              Get.to(const PilihJadwalScreen());
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
        child: ScrollWidget(
          child: ContentContainer(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Pilih Jadwal Praktikum",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              decoration: TextDecoration.underline)),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Modul 1",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomDatePickerFormField(
                                  hint: "Tanggal Praktikum",
                                  label: "Tanggal Praktikum",
                                  isExpanded: true,
                                  required: true,
                                  controller: modul1DateController,
                                  // onDateChanged: (_) {
                                  //   setEndDate();
                                  // },
                                  validator: (val) {
                                    if (val == null) {
                                      return Validators.emptyValueError;
                                    }

                                    if (val.millisecondsSinceEpoch <=
                                        DateTime.now().millisecondsSinceEpoch) {
                                      return "Start date must be more than today";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                child: CustomDropdownFormField<String>(
                                  items: <String>[
                                    '13.00 - 14.00',
                                    '14.00 - 15.00',
                                    '15.00 - 16.00'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  controller: time1Controller,
                                  hint: "Jam Praktikum",
                                  isExpanded: true,
                                  required: true,
                                  validator: (val) => val == null
                                      ? Validators.emptyValueError
                                      : null,
                                  hintAtTheTop: true,
                                  onChanged: (_) {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Modul 2",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomDatePickerFormField(
                                  hint: "Tanggal Praktikum",
                                  label: "Tanggal Praktikum",
                                  isExpanded: true,
                                  required: true,
                                  controller: modul2DateController,
                                  // onDateChanged: (_) {
                                  //   setEndDate();
                                  // },
                                  validator: (val) {
                                    if (val == null) {
                                      return Validators.emptyValueError;
                                    }

                                    if (val.millisecondsSinceEpoch <=
                                        DateTime.now().millisecondsSinceEpoch) {
                                      return "Start date must be more than today";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                child: CustomDropdownFormField<String>(
                                  items: <String>[
                                    '13.00 - 14.00',
                                    '14.00 - 15.00',
                                    '15.00 - 16.00'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  controller: time2Controller,
                                  hint: "Jam Praktikum",
                                  isExpanded: true,
                                  required: true,
                                  validator: (val) => val == null
                                      ? Validators.emptyValueError
                                      : null,
                                  hintAtTheTop: true,
                                  onChanged: (_) {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Modul 3",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomDatePickerFormField(
                                  hint: "Tanggal Praktikum",
                                  label: "Tanggal Praktikum",
                                  isExpanded: true,
                                  required: true,
                                  controller: modul3DateController,
                                  // onDateChanged: (_) {
                                  //   setEndDate();
                                  // },
                                  validator: (val) {
                                    if (val == null) {
                                      return Validators.emptyValueError;
                                    }

                                    if (val.millisecondsSinceEpoch <=
                                        DateTime.now().millisecondsSinceEpoch) {
                                      return "Start date must be more than today";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                child: CustomDropdownFormField<String>(
                                  items: <String>[
                                    '13.00 - 14.00',
                                    '14.00 - 15.00',
                                    '15.00 - 16.00'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  controller: time3Controller,
                                  hint: "Jam Praktikum",
                                  isExpanded: true,
                                  required: true,
                                  validator: (val) => val == null
                                      ? Validators.emptyValueError
                                      : null,
                                  hintAtTheTop: true,
                                  onChanged: (_) {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Modul 4",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomDatePickerFormField(
                                  hint: "Tanggal Praktikum",
                                  label: "Tanggal Praktikum",
                                  isExpanded: true,
                                  required: true,
                                  controller: modul4DateController,
                                  // onDateChanged: (_) {
                                  //   setEndDate();
                                  // },
                                  validator: (val) {
                                    if (val == null) {
                                      return Validators.emptyValueError;
                                    }

                                    if (val.millisecondsSinceEpoch <=
                                        DateTime.now().millisecondsSinceEpoch) {
                                      return "Start date must be more than today";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 50,
                              ),
                              Expanded(
                                child: CustomDropdownFormField<String>(
                                  items: <String>[
                                    '13.00 - 14.00',
                                    '14.00 - 15.00',
                                    '15.00 - 16.00'
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  controller: time4Controller,
                                  hint: "Jam Praktikum",
                                  isExpanded: true,
                                  required: true,
                                  validator: (val) => val == null
                                      ? Validators.emptyValueError
                                      : null,
                                  hintAtTheTop: true,
                                  onChanged: (_) {},
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                  CustomButton(
                    value: "Submit",
                    onTap: () {
                      //Input data

                      // Map<String,String> dataToSave = {
                      //       'jam': time1Controller.toString(),
                      //       'tanggal': Helpers.dateToString(modul1DateController.pickedDate),
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: ProjectColors.green,
                          content: Text("Successfully added practicum.")));

                      Get.to(const HomeScreen());
                      Api services = Api();
                      // services.addJadwal(newCol: newCol);

                      // Add data to firestore
                      FirebaseFirestore.instance.collection('user').doc("");
                    },
                    color: Colors.blue.shade900,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _select(Choice choice) {
    setState(() {
      _selectedChoice = choice;
    });
  }

  // void setEndDate() {
  //   if (programTemplateController.value == null ||
  //       startDateController.pickedDate == null) return;
  //
  //   int duration = selectedTemplate!.duration; // month
  //   final startDate = startDateController.pickedDate!;
  //   final isNextMonth = startDate.day > 15;
  //   duration = duration;
  //   endDateController.date = DateTime(
  //       startDate.year, startDate.month + duration - (isNextMonth ? -1 : 0), 0);
  // }
}

class Choice {
  const Choice({required this.title, required this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = <Choice>[
  Choice(title: 'Profile', icon: Icons.people),
  Choice(title: 'Log Out', icon: Icons.logout),
];
