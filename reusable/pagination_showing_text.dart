import 'package:flutter/material.dart';
import 'package:smartcare_web/reusable/project_colors.dart';


class PaginationShowingText extends StatelessWidget {
  const PaginationShowingText({
    Key? key,
    required this.start,
    required this.end,
    required this.length,
  }) : super(key: key);

  final int start, end, length;

  @override
  Widget build(BuildContext context) {
    return Text("Showing $start - $end of $length",
        style: const TextStyle(color: ProjectColors.defaultBlack, fontSize: 15));
  }
}
