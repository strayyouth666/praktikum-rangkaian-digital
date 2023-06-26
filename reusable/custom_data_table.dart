import 'package:flutter/material.dart';

class CustomDataCell {
  final Widget child;
  final void Function()? onTap;

  CustomDataCell(this.child, {this.onTap});
}

class CustomDataRow {
  final List<CustomDataCell> cells;
  final bool? selected;
  final void Function(bool? selected)? onSelectChanged;
  final void Function()? onLongPress, onTap;
  final Color? color;

  CustomDataRow(
      {required this.cells,
        this.color,
        this.selected,
        this.onSelectChanged,
        this.onTap,
        this.onLongPress});
}

class CustomDataTable extends StatefulWidget {
  const CustomDataTable(
      {Key? key,
        this.headingRowColor,
        this.horizontalMargin,
        this.rowsColor,
        this.stripped = false,
        required this.columns,
        required this.rows,
        this.headingTextStyle,
        this.dataTextStyle,
        this.headingRowHeight,
        this.dataRowHeight,
        this.columnSpacing,
        this.decoration,
        this.border})
      : super(key: key);

  final List<DataColumn> columns;
  final List<CustomDataRow> rows;
  final Color? headingRowColor, rowsColor;
  final bool stripped;
  final TextStyle? headingTextStyle, dataTextStyle;
  final double? headingRowHeight,
      dataRowHeight,
      columnSpacing,
      horizontalMargin;
  final Decoration? decoration;
  final TableBorder? border;

  @override
  _CustomDataTableState createState() => _CustomDataTableState();
}

class _CustomDataTableState extends State<CustomDataTable> {
  @override
  Widget build(BuildContext context) {
    return DataTable(
        horizontalMargin: widget.horizontalMargin,
        columns: widget.columns,
        headingRowColor: MaterialStateProperty.all<Color>(
            widget.headingRowColor ?? Colors.white),
        headingTextStyle: widget.headingTextStyle,
        dataTextStyle: widget.dataTextStyle,
        headingRowHeight: widget.headingRowHeight,
        dataRowHeight: widget.dataRowHeight,
        decoration: widget.decoration,
        columnSpacing: widget.columnSpacing,
        border: widget.border,
        rows: widget.rows
            .asMap()
            .map((i, row) {
          Color rowColor = widget.rowsColor ?? Colors.white;

          if (widget.stripped && (i + 1) % 2 == 0) {
            rowColor = widget.rowsColor?.withOpacity(.3) ??
                const Color(0xffeeeeee);
          }

          rowColor = row.color ?? rowColor;

          return MapEntry<int, DataRow>(
              i,
              DataRow(
                  color: MaterialStateProperty.all<Color>(rowColor),
                  selected: row.selected ?? false,
                  cells: row.cells.map((cell) {
                    return DataCell(cell.child,
                        onTap: cell.onTap ?? row.onTap);
                  }).toList()));
        })
            .values
            .toList());
  }
}

