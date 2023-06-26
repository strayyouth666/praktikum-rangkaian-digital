// import 'package:flutter/material.dart';
// import 'package:smartcare_web/reusable/project_colors.dart';
// import 'package:smartcare_web/reusable/time_slots.dart';
// import 'adaptive_grid_view.dart';
// import 'api.dart';
// import 'cached_future_builder.dart';
// import 'clickable_ripple.dart';
// import 'custom_button.dart';
// import 'custom_datepicker.dart';
// import 'custom_dropdown.dart';
// import 'helpers.dart';
// import 'loading_placeholder.dart';
//
// class SelectTimeSlotDialog extends StatefulWidget {
//   const SelectTimeSlotDialog(
//       {Key? key,
//         required this.sessionDraft,
//         required this.timezoneOffset,
//         this.onChanged,
//         this.bookedTimeslots = const [],
//         this.exceptionBookedIndicator = const []})
//       : super(key: key);
//
//   final SessionDraft sessionDraft;
//   final double? timezoneOffset;
//   final void Function(SessionDraft draft)? onChanged;
//   final List<TimeSlotModel> bookedTimeslots, exceptionBookedIndicator;
//
//   static Widget durationDropdown(
//       {int duration = 24,
//         List<int>? durationDropdownItems,
//         CustomDropdownController<int>? controller}) {
//     return CustomDropdown<int>(
//         controller: controller,
//         hint: "Duration",
//         hintAtTheTop: true,
//         isExpanded: true,
//         items: durationDropdownItems?.map(durationDropdownBuilder).toList() ??
//             List.generate(duration, durationDropdownBuilder));
//   }
//
//   static DropdownMenuItem<int> durationDropdownBuilder(index) =>
//       DropdownMenuItem<int>(
//           child: Text("${index + 1} ${index > 0 ? "hours" : "hour"}"),
//           value: index + 1);
//
//   @override
//   State<SelectTimeSlotDialog> createState() => _SelectTimeSlotDialogState();
// }
//
// class _SelectTimeSlotDialogState extends State<SelectTimeSlotDialog> {
//   final timeSlots = List.generate(
//       24,
//           (index) => TimeSlot(
//           (index + 1) * 60,
//           Helpers.timeToString(TimeOfDay(hour: index, minute: 0)) +
//               " - " +
//               Helpers.timeToString(TimeOfDay(hour: index + 1, minute: 0))));
//   bool clicked = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final date = widget.sessionDraft.dateController.pickedDate!;
//
//     return ScrollWidget(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text("Select Time",
//               style: TextStyle(
//                   color: ProjectColors.defaultBlack,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16)),
//           const SizedBox(height: 15),
//           CachedFutureBuilder<TimeSlotsModel>(
//               name: "time_slots",
//               futureFunction: () => ,
//               builder: (context, snapshot) {
//                 if (snapshot.data == null) {
//                   return Column(
//                     children: List.generate(
//                         4,
//                             (index) => Column(
//                           children: [
//                             Row(
//                               children: const [
//                                 Expanded(
//                                     child: LoadingPlaceholder(height: 15)),
//                                 SizedBox(width: 5),
//                                 Expanded(
//                                     child: LoadingPlaceholder(height: 15)),
//                                 SizedBox(width: 5),
//                                 Expanded(
//                                     child: LoadingPlaceholder(height: 15)),
//                               ],
//                             ),
//                             const SizedBox(height: 5)
//                           ],
//                         )),
//                   );
//                 }
//
//                 return AdaptiveGridView(
//                   crossAxisCount: 3,
//                   mainAxisSpacing: 10,
//                   crossAxisSpacing: 10,
//                   children: timeSlots.map((time) {
//                     final slotStartTime = date.millisecondsSinceEpoch +
//                         ((time.interval - 60) * 60 * 1000);
//                     final slotEndTime = date.millisecondsSinceEpoch +
//                         (time.interval * 60 * 1000);
//                     final selected = time.interval >=
//                         widget.sessionDraft.selectedTimeOffset &&
//                         time.interval <=
//                             widget.sessionDraft.selectedTimeInterval;
//                     bool available = true;
//
//                     for (final time in [
//                       ...snapshot.data!.list,
//                       ...widget.bookedTimeslots
//                     ]) {
//                       final startTime = time.startTime.millisecondsSinceEpoch;
//                       final endTime = time.endTime.millisecondsSinceEpoch;
//                       final checkForException = widget.exceptionBookedIndicator
//                           .where((element) =>
//                       element.startTime.millisecondsSinceEpoch >=
//                           startTime &&
//                           element.endTime.millisecondsSinceEpoch >
//                               startTime &&
//                           element.endTime.millisecondsSinceEpoch <=
//                               endTime);
//
//                       if (checkForException.isNotEmpty) continue;
//
//                       if (slotStartTime >= startTime &&
//                           slotEndTime > startTime &&
//                           slotEndTime <= endTime) {
//                         available = false;
//                         break;
//                       }
//                     }
//
//                     if (selected && !available && clicked) {
//                       Future.microtask(() {
//                         setState(() {
//                           clicked = true;
//                           widget.sessionDraft
//                             ..selectedTimeOffset = 0
//                             ..selectedTimeInterval = 0;
//                         });
//                         ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(
//                                 backgroundColor: ProjectColors.red,
//                                 content: Text(
//                                     "One or more hours have been booked")));
//                       });
//                     } else if (selected && !available && !clicked) {
//                       available = true;
//                     }
//
//                     return Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             color: !available
//                                 ? const Color(0xFFDDDDDD)
//                                 : selected && available
//                                 ? ProjectColors.red
//                                 : Colors.white,
//                             border: Border.all(
//                                 color: selected && available
//                                     ? ProjectColors.red
//                                     : const Color(0xFFDDDDDD))),
//                         child: ClickableRipple(
//                           onTap: !available
//                               ? null
//                               : () {
//                             setState(() {
//                               clicked = true;
//                               widget.sessionDraft.selectedTimeOffset =
//                                   time.interval;
//                               widget.sessionDraft.selectedTimeInterval =
//                                   time.interval +
//                                       ((widget
//                                           .sessionDraft
//                                           .timeIntervalController
//                                           .value! -
//                                           1) *
//                                           60);
//                             });
//                           },
//                           borderRadius: BorderRadius.circular(5),
//                           child: Padding(
//                               padding: const EdgeInsets.all(10),
//                               child: FittedBox(
//                                 fit: BoxFit.scaleDown,
//                                 child: Text(time.label,
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                         color: selected && available
//                                             ? Colors.white
//                                             : null)),
//                               )),
//                         ));
//                   }).toList(),
//                 );
//               }),
//           const SizedBox(height: 10),
//           CustomButton(
//             isExpanded: true,
//             value: "Done",
//             onTap: () {
//               if (widget.onChanged != null) {
//                 widget.onChanged!(widget.sessionDraft);
//               }
//
//               Api.of(context).cache.remove("time_slots");
//               Navigator.of(context).pop();
//             },
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class SessionDraft {
//   late String name;
//   final CustomDatePickerController dateController =
//   CustomDatePickerController();
//   final CustomDropdownController<int> timeIntervalController =
//   CustomDropdownController<int>();
//   final CustomDropdownController<String> coachController =
//   CustomDropdownController<String>(),
//       exclusiveCoacheeController = CustomDropdownController<String>();
//   int selectedTimeInterval = 0, selectedTimeOffset = 0;
//   bool isDetail = false;
//
//   // SessionDraft({Session? session}) {
//   //   if (session != null) {
//   //     isDetail = true;
//   //     dateController.initialDate = DateTime(session.sessionStartTime.year,
//   //         session.sessionStartTime.month, session.sessionStartTime.day);
//   //     coachController.initialValue = session.coachId;
//   //     selectedTimeOffset = ((session.sessionStartTime.hour + 1) * 60).round();
//   //     selectedTimeInterval = (session.sessionEndTime.hour * 60).round();
//   //     timeIntervalController.initialValue = session.duration.inHours;
//   //
//   //     return;
//   //   }
//   //
//   //   final now = DateTime.now().toUtc();
//   //   dateController.initialDate = DateTime(now.year, now.month, now.day);
//   //   timeIntervalController.initialValue = 1;
//   // }
// }
//
// class SelectTimeSlotButton extends StatelessWidget {
//   const SelectTimeSlotButton(
//       {Key? key, required this.draft, required this.onTap})
//       : super(key: key);
//
//   final SessionDraft draft;
//   final void Function() onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     print(draft.selectedTimeInterval);
//
//     return CustomButton(
//         isExpanded: true,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text("Select Time"),
//             if (draft.selectedTimeInterval > 0)
//               Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   const SizedBox(width: 3),
//                   Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         draft.selectedTimeOffset - 60,
//                         draft.selectedTimeInterval
//                       ].map<Widget>((e) {
//                         return Card(
//                             child: Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: Text(Helpers.timeToString(
//                                   TimeOfDay.fromDateTime(
//                                       DateTime.fromMillisecondsSinceEpoch(
//                                           e * 60 * 1000)
//                                           .toUtc()))),
//                             ));
//                       }).toList()
//                         ..insert(1, const Text("-"))),
//                 ],
//               )
//           ],
//         ),
//         onTap: onTap);
//   }
// }
//
// class TimeSlot {
//   final int interval;
//   final String label;
//
//   TimeSlot(this.interval, this.label);
// }
