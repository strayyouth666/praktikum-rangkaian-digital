import 'package:flutter/material.dart';
import 'package:smartcare_web/reusable/popup_dialog.dart';
import 'package:smartcare_web/reusable/project_colors.dart';

import 'clickable_ripple.dart';

class UserPopup extends StatelessWidget {
  const UserPopup({Key? key, this.userPopupShown = false}) : super(key: key);

  final bool userPopupShown;

  @override
  Widget build(BuildContext context) {
    // final api = Api.of(context);

    return PopupDialog(
        shown: userPopupShown,
        width: 200,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserPopupMenuList(
              icon: Icons.person,
              label: "Profile",
              onTap: () {
                // api.sidebarControllerState
                //     .setCurrentScreen(SidebarScreens.editUserProfile);
              },
            ),
            // const LineSeparator(),
            // UserPopupMenuList(
            //   icon: Icons.settings,
            //   label: "Change Password",
            //   onTap: () {
            //     Helpers.showModal(
            //         context: context,
            //         builder: (context) {
            //           final formKey = GlobalKey<FormState>();
            //           final oldPasswordController = TextEditingController(),
            //               newPasswordController = TextEditingController(),
            //               confirmPasswordController = TextEditingController();
            //
            //           return Form(
            //             key: formKey,
            //             child: Column(
            //               mainAxisSize: MainAxisSize.min,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 const Text("Change Password",
            //                     style: TextStyle(
            //                         color: ProjectColors.blue,
            //                         fontWeight: FontWeight.bold)),
            //                 const SizedBox(height: 20),
            //                 CustomInput(
            //                   obscureText: true,
            //                   showSeekButton: true,
            //                   controller: oldPasswordController,
            //                   hint: "Old Password",
            //                   isHintAboveForm: true,
            //                   validator: (val) => val!.isEmpty
            //                       ? Validators.emptyValueError
            //                       : null,
            //                 ),
            //                 const SizedBox(height: 10),
            //                 CustomInput(
            //                     obscureText: true,
            //                     showSeekButton: true,
            //                     controller: newPasswordController,
            //                     hint: "New Password",
            //                     isHintAboveForm: true,
            //                     validator: (val) {
            //                       if (val == null || val.isEmpty) {
            //                         return Validators.emptyValueError;
            //                       }
            //
            //                       if (!Validators(value: val)
            //                           .validatePassword()) {
            //                         return "Kindly follow the password requirements";
            //                       }
            //
            //                       return null;
            //                     }),
            //                 const SizedBox(height: 10),
            //                 CustomInput(
            //                   obscureText: true,
            //                   showSeekButton: true,
            //                   controller: confirmPasswordController,
            //                   hint: "Confirm New Password",
            //                   isHintAboveForm: true,
            //                   validator: (val) =>
            //                   val == newPasswordController.value.text
            //                       ? null
            //                       : "Password does not match",
            //                 ),
            //                 const SizedBox(height: 8),
            //                 const Text(
            //                     "Password requirements:\n- min. 8 characters\n- at least 1 uppercase letter\n- at least 1 number\n- at least 1 special character",
            //                     style: TextStyle(
            //                         color: ProjectColors.defaultBlack,
            //                         fontSize: 12)),
            //                 const SizedBox(height: 10),
            //                 CustomButton(
            //                     value: "Change Password",
            //                     onTap: () async {
            //                       if (!formKey.currentState!.validate()) return;
            //
            //                       await api.user.updatePassword(
            //                           oldPassword:
            //                           oldPasswordController.value.text,
            //                           password:
            //                           newPasswordController.value.text,
            //                           confirmPassword:
            //                           confirmPasswordController.value.text);
            //                       ScaffoldMessenger.of(context).showSnackBar(
            //                           const SnackBar(
            //                               content: Text(
            //                                   "Password has been successfully changed")));
            //                       Navigator.pop(context);
            //                     })
            //               ],
            //             ),
            //           );
            //         });
            //   },
            // ),
            // const LineSeparator(),
            UserPopupMenuList(
                icon: Icons.logout,
                label: "Logout",
                onTap: () {
                  // api.auth.logout();
                }),
          ],
        ));
  }
}

class UserPopupMenuList extends StatelessWidget {
  const UserPopupMenuList({
    Key? key,
    required this.icon,
    required this.label,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ClickableRipple(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          width: double.infinity,
          child: Row(
            children: [
              Icon(icon, color: ProjectColors.defaultBlack),
              const SizedBox(
                width: 10,
              ),
              Text(label, style: const TextStyle(color: Color(0xff777777)))
            ],
          ),
        ));
  }
}
