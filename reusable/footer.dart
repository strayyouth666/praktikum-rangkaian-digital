import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:smartcare_web/reusable/project_colors.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key, this.width}) : super(key: key);

  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      color: ProjectColors.blue,
      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 50),
      child: FutureBuilder<PackageInfo>(
          future: PackageInfo.fromPlatform(),
          builder: (context, snapshot) {
            if (snapshot.data == null) return const SizedBox();

            final info = snapshot.data!;

            return Text(
                "© 2022 The Spark Group Asia. All rights reserved v${info.version}+${info.buildNumber}",
                style: const TextStyle(color: Colors.white, fontSize: 13));
          }),
    );
  }
}
