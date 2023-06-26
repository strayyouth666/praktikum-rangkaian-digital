import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartcare_web/aslab_screen/penilaian.dart';
import 'package:smartcare_web/aslab_screen/pop_up_screen.dart';
import 'package:smartcare_web/reusable/content_container.dart';
import 'package:smartcare_web/reusable/custom_datepicker.dart';
import 'package:smartcare_web/reusable/custom_dropdown.dart';
import 'package:smartcare_web/reusable/custom_dropdown_form_field.dart';
import 'package:smartcare_web/reusable/custom_input.dart';
import 'package:smartcare_web/reusable/input_label.dart';
import 'package:smartcare_web/reusable/project_colors.dart';
import 'package:smartcare_web/reusable/scroll_widget.dart';
import '../praktikan_screen/login_screen.dart';
import '../reusable/custom_button.dart';
import '../reusable/custom_data_table.dart';
import '../reusable/custom_datepicker_form_field.dart';
import '../reusable/list_pagination.dart';
import '../reusable/pagination_button.dart';
import '../reusable/pagination_showing_text.dart';
import '../reusable/pop_up_menu.dart';
import 'package:universal_html/html.dart' as html;
import 'package:universal_html/js.dart' as js;
import 'package:smartcare_web/abstract/form_ui.dart' as ui;
import 'package:flutter_localizations/flutter_localizations.dart';

import '../reusable/validators.dart';
import 'aslab_home_screen.dart';
import 'atur_jadwal_screen.dart';

final today = DateUtils.dateOnly(DateTime.now());

class Calendar extends StatelessWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CalendarDatePicker2 Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      supportedLocales: const [
        Locale('en', ''),
        Locale('zh', ''),
        Locale('he', ''),
        Locale('es', ''),
        Locale('ru', ''),
      ],
    );
  }
}

class PlottingScreen extends StatefulWidget {
  const PlottingScreen({Key? key}) : super(key: key);

  @override
  _PlottingScreenState createState() => _PlottingScreenState();
}

class _PlottingScreenState extends State<PlottingScreen> {
  final _keyHtml1 = GlobalKey();
  late js.JsObject connector1;
  String createdViewId1 = '1';
  late html.IFrameElement element1;
  Choice _selectedChoice = choices[0];
  late final TextEditingController pengumumanController;
  late final CustomDropdownController<String> namaController,
      praktikumController,
      modulController,
      waktuController;
  late final CustomDatePickerController praktikumDateController;

  late final CalendarDatePicker2 calendarDatePicker2;

  late List<DateTime?> _multiDatePickerValueWithDefaultValue = [
    DateTime(today.year, today.month, today.day),
  ];

  List<DateTime?> _dialogCalendarPickerValue = [
    DateTime(today.year, today.month, today.day),
  ];

  final testSlicing = [
    CustomDataCell(const Text("2 September 2023")),
    CustomDataCell(const Text("1")),
    CustomDataCell(const Text("1, 2")),
    CustomDataCell(Center(
      child: CustomButton(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 6),
        color: ProjectColors.blue,
        child: const Text(
          "BUKA",
          style: TextStyle(fontSize: 8),
        ),
        onTap: () {
          Get.to(const PopUpScreen());
        },
      ),
    )),
  ];

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = values[0].toString().replaceAll('00:00:00.000', '');
        final endDate = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText = '$startDate to $endDate';
      } else {
        return 'null';
      }
    }

    return valueText;
  }

  Widget _buildDefaultMultiDatePickerWithValue() {
    final config = CalendarDatePicker2Config(
      calendarType: CalendarDatePicker2Type.multi,
      selectedDayHighlightColor: Colors.indigo,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 10),
        const Text(
          'Pilih Tanggal Praktikum',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        CalendarDatePicker2(
          config: config,
          initialValue: _multiDatePickerValueWithDefaultValue,
          onValueChanged: (values) =>
              setState(() => _multiDatePickerValueWithDefaultValue = values),
        ),
        const SizedBox(height: 10),
        Wrap(
          children: [
            const Text('Dipilih:  '),
            const SizedBox(width: 10),
            Text(
              _getValueText(
                config.calendarType,
                _multiDatePickerValueWithDefaultValue,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 10,
              softWrap: false,
            ),
          ],
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  _buildCalendarDialogButton() {
    const dayTextStyle =
        TextStyle(color: Colors.black, fontWeight: FontWeight.w700);
    final weekendTextStyle =
        TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w600);
    final anniversaryTextStyle = TextStyle(
      color: Colors.red[400],
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );
    final config = CalendarDatePicker2WithActionButtonsConfig(
        dayTextStyle: dayTextStyle,
        calendarType: CalendarDatePicker2Type.multi,
        selectedDayHighlightColor: Colors.purple[800],
        closeDialogOnCancelTapped: true,
        firstDayOfWeek: 1,
        weekdayLabelTextStyle: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold,
        ),
        controlsTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        centerAlignModePickerButton: true,
        customModePickerButtonIcon: const SizedBox(),
        selectedDayTextStyle: dayTextStyle.copyWith(color: Colors.white),
        dayTextStylePredicate: ({required date}) {
          TextStyle? textStyle;
          if (date.weekday == DateTime.saturday ||
              date.weekday == DateTime.sunday) {
            textStyle = weekendTextStyle;
          }
          if (DateUtils.isSameDay(date, DateTime(2021, 1, 25))) {
            textStyle = anniversaryTextStyle;
          }
          return textStyle;
        },
        dayBuilder: ({
          required date,
          textStyle,
          decoration,
          isSelected,
          isDisabled,
          isToday,
        }) {
          Widget? dayWidget;
          if (date.day == date.weekday) {
            dayWidget = Container(
              decoration: decoration,
              child: Center(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Text(
                      MaterialLocalizations.of(context).formatDecimal(date.day),
                      style: textStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 27.5),
                      child: Container(
                        height: 4,
                        width: 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color:
                              isSelected == true ? Colors.black : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return dayWidget;
        });
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              final values = await showCalendarDatePicker2Dialog(
                context: context,
                barrierColor: Colors.grey,
                config: config,
                dialogSize: const Size(325, 400),
                borderRadius: BorderRadius.circular(15),
                initialValue: _dialogCalendarPickerValue,
                dialogBackgroundColor: Colors.white,
              );
              if (values != null) {
                // ignore: avoid_print
                print(_getValueText(
                  config.calendarType,
                  values,
                ));
                setState(() {
                  _dialogCalendarPickerValue = values;
                });
              }
            },
            child: const Text('Pilih Tanggal Praktikum'),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    pengumumanController = TextEditingController();
    namaController = CustomDropdownController<String>();
    modulController = CustomDropdownController<String>();
    waktuController = CustomDropdownController<String>();
    praktikumController = CustomDropdownController<String>();
    praktikumDateController = CustomDatePickerController();
    calendarDatePicker2 = CalendarDatePicker2(
      config: CalendarDatePicker2Config(),
      initialValue: const [],
    );

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
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
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
                      child: ContentContainer(
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 70),
                                child: Column(
                                  children: [
                                    Text(
                                      "Plotting Praktikum",
                                      style: GoogleFonts.lato(
                                          textStyle: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        CustomDropdown<String>(
                                            isExpanded: true,
                                            hint: "Nama Praktikum",
                                            hintAtTheTop: true,
                                            controller: namaController,
                                            onChanged: (val) {
                                              js.context.callMethod(
                                                  'setIframesVisibility',
                                                  [true]);
                                              setState(() {});
                                            },
                                            items: const [
                                              DropdownMenuItem<String>(
                                                  value: "Rangkaian Digital",
                                                  child: Text(
                                                      "Rangkaian Digital")),
                                              DropdownMenuItem<String>(
                                                  value: "Dasar Pemrograman",
                                                  child: Text(
                                                      "Dasar Pemrograman")),
                                              DropdownMenuItem<String>(
                                                  value:
                                                      "Pengolahan Sinyal Digital",
                                                  child: Text(
                                                      "Pengolahan Sinyal Digital")),
                                            ]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Flexible(
                                              child: CustomDropdownFormField<
                                                  String>(
                                                items: <String>[
                                                  '12-03-2023',
                                                  '13-03-2023',
                                                  '14-03-2023'
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                controller: praktikumController,
                                                hint: "Tanggal Praktikum",
                                                isExpanded: true,
                                                // required: true,
                                                // validator: (val) => val == null
                                                //     ? Validators.emptyValueError
                                                //     : null,
                                                hintAtTheTop: true,
                                                onChanged: (_) {},
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: CustomDropdownFormField<
                                                  String>(
                                                items: <String>[
                                                  '13.00 - 14.00',
                                                  '14.00 - 15.00',
                                                  '15.00 - 16.00'
                                                ].map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                allowMultipleValues: true,
                                                controller: waktuController,
                                                hint: "Jam Praktikum",
                                                isExpanded: true,
                                                // required: true,
                                                // validator: (val) => val == null
                                                //     ? Validators.emptyValueError
                                                //     : null,
                                                hintAtTheTop: true,
                                                onChanged: (_) {},
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Flexible(
                                              child: CustomDropdownFormField<
                                                  String>(
                                                isExpanded: true,
                                                hint: "Jumlah Modul",
                                                hintAtTheTop: true,
                                                controller: modulController,
                                                dropDownOnTap: () {
                                                  js.context.callMethod(
                                                      'setIframesVisibility',
                                                      [false]);
                                                },
                                                onChanged: (val) {
                                                  js.context.callMethod(
                                                      'setIframesVisibility',
                                                      [true]);
                                                },
                                                validator: (val) => val == null
                                                    ? Validators.emptyValueError
                                                    : null,
                                                items:
                                                    List.generate(4, (index) {
                                                  index++;

                                                  return DropdownMenuItem<
                                                          String>(
                                                      value: index.toString(),
                                                      child:
                                                          Text("Modul $index"));
                                                }),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Tabel Jadwal Asisten Praktikum",
                                          style: GoogleFonts.lato(
                                              textStyle: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: MaterialButton(
                                            height: 30,
                                            color: Colors.black,
                                            onPressed: () {
                                              Get.to(const PopUpScreen());
                                              // ScaffoldMessenger.of(context)
                                              //     .showSnackBar(const SnackBar(
                                              //         backgroundColor:
                                              //             ProjectColors.green,
                                              //         content: Text(
                                              //             "Successfully to added schedule.")));
                                            },
                                            child: const Text(
                                              "LIHAT",
                                              style: TextStyle(
                                                  fontSize: 8,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: ListPagination<CustomDataRow>(
                                          data: List.generate(
                                              1,
                                              (index) => CustomDataRow(
                                                  cells: testSlicing)),
                                          buttonBuilder: paginationButton,
                                          builder: (paginatedData,
                                              paginationButtons,
                                              start,
                                              end,
                                              length) {
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ScrollWidget(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: CustomDataTable(
                                                      stripped: true,
                                                      columns: const [
                                                        DataColumn(
                                                          label: Text(
                                                            "Tanggal Praktikum",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        DataColumn(
                                                          label: Text(
                                                            "Sesi",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        DataColumn(
                                                          label: Text(
                                                            "Modul",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                        DataColumn(
                                                          label: Text(
                                                            "Keterangan",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                      rows: paginatedData),
                                                ),
                                                const SizedBox(height: 20),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    PaginationShowingText(
                                                        start: start,
                                                        end: end,
                                                        length: length),
                                                    paginationButtons,
                                                  ],
                                                )
                                              ],
                                            );
                                          }),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    MaterialButton(
                                      color: Colors.green,
                                      onPressed: () {
                                        Get.to(const AslabHomeScreen());
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor:
                                                    ProjectColors.green,
                                                content: Text(
                                                    "Successfully to added schedule.")));
                                      },
                                      child: const Text(
                                        "BUAT",
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
