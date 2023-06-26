// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:smartcare_web/reusable/validators.dart';
//
// import '../model/modul_model.dart';
// import '../system/api.dart';
// import 'custom_dropdown.dart';
// import 'custom_dropdown_form_field.dart';
//
//
// class ModulDropdown extends StatelessWidget {
//   const ModulDropdown(
//       {Key? key,
//         this.controller,
//         this.required = true,
//         this.hint,
//         this.canRetractValue = false,
//         this.onChanged,
//         this.onTap})
//       : super(key: key);
//
//   final CustomDropdownController<String>? controller;
//   final bool required, canRetractValue;
//   final String? hint;
//   final void Function(String?)? onChanged;
//   final void Function()? onTap;
//
//   @override
//   Widget build(BuildContext context) {
//     final api = get modulSubs;
//
//     return FutureBuilder<ModulModel>(
//         future: ,
//         builder: (context, snapshot) {
//           if (snapshot.data == null) {
//             return CustomDropdown.loadingPlaceholder();
//           }
//           final modul = snapshot.data!.list.map((e) {
//             return DropdownMenuItem(
//               value: e.id,
//               child: Text(e.name),
//             );
//           }).toList();
//           return CustomDropdownFormField<String>(
//               controller: controller,
//               items: modul,
//               canRetractValue: canRetractValue,
//               dropDownOnTap: onTap,
//               validator: (val) =>
//               val == null && required ? Validators.emptyValueError : null,
//               hint: hint ?? "Coach",
//               hintAtTheTop: true,
//               required: required,
//               isExpanded: true,
//               onChanged: (val) => onChanged == null
//                   ? null
//                   : onChanged!(
//                   val,
//                   val == null
//                       ? null
//                       : snapshot.data!.list
//                       .where((element) => element.id == val)
//                       .first));
//         });
//   }
// }
//
