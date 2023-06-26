import 'package:flutter/material.dart';

class ListPagination<T> extends StatefulWidget {
  const ListPagination(
      {Key? key,
        required this.builder,
        this.nextButtonText = "Next",
        this.prevButtonText = "Prev",
        this.buttonBuilder,
        required this.data,
        this.displayPerPage = 10})
      : super(key: key);

  final List<T> data;
  final Widget Function(
      List<T> data, Widget paginationButton, int start, int end, int length)
  builder;
  final String nextButtonText, prevButtonText;
  final Widget Function(
      void Function() onTap, String value, bool active, bool disabled)?
  buttonBuilder;
  final int displayPerPage;

  @override
  _ListPaginationState<T> createState() => _ListPaginationState<T>();
}

class _ListPaginationState<T> extends State<ListPagination<T>> {
  int currentPage = 1;

  Widget defaultButton(
      void Function() onTap, String value, bool active, bool disabled) {
    return ElevatedButton(
        onPressed: disabled ? null : onTap,
        child: Text(value,
            style: TextStyle(color: active ? Colors.white : Colors.blue)),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
                active ? Colors.blue : Colors.white)));
  }

  void changePage(int page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> paginationButtons = [];
    final data = widget.data;
    final totalData = data.length;
    final totalPage = (totalData / widget.displayPerPage).ceil();
    final Widget Function(
        void Function() onTap, String value, bool active, bool disabled)
    button = widget.buttonBuilder ?? defaultButton;

    const Widget expand =
    Text("...", style: TextStyle(color: Color(0xffaaaaaa)));

    paginationButtons.add(button(() => changePage(currentPage - 1),
        widget.prevButtonText, true, currentPage < 2));

    if (totalPage < 2) {
      return widget.builder(data, const SizedBox(), 1, totalData, totalData);
    }

    if (currentPage < 3 || (currentPage == 3 && totalPage == 3)) {
      paginationButtons
          .addAll(List.generate(totalPage > 3 ? 3 : totalPage, (index) {
        final page = index + 1;

        return button(() => changePage(page), page.toString(),
            currentPage == page, false);
      }));

      if (totalPage > 3) {
        paginationButtons
          ..add(expand)
          ..add(button(
                  () => changePage(totalPage), totalPage.toString(), false, false));
      }
    }

    if (currentPage >= 3 && totalPage > 3 && currentPage < totalPage - 1) {
      final middlePaginationButtons = [
        currentPage - 1,
        currentPage,
        currentPage + 1
      ];

      paginationButtons
        ..add(
          button(() => changePage(1), "1", false, false),
        )
        ..add(expand)
        ..addAll(middlePaginationButtons.map((e) =>
            button(() => changePage(e), e.toString(), currentPage == e, false)))
        ..add(expand)
        ..add(button(
                () => changePage(totalPage), totalPage.toString(), false, false));
    }

    if (totalPage > 3 && currentPage >= totalPage - 1) {
      final lastPaginationButtons = [totalPage - 2, totalPage - 1, totalPage];

      paginationButtons
        ..add(button(() => changePage(1), "1", false, false))
        ..add(expand)
        ..addAll(lastPaginationButtons.map((e) => button(
                () => changePage(e), e.toString(), currentPage == e, false)));
    }

    paginationButtons.add(button(() => changePage(currentPage + 1),
        widget.nextButtonText, true, currentPage == totalPage));

    final paginationButtonsWidget = Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 5,
        runSpacing: 5,
        direction: Axis.horizontal,
        children: paginationButtons);

    final startData = (currentPage - 1) * widget.displayPerPage;
    final endData =
    currentPage == totalPage ? null : currentPage * widget.displayPerPage;
    final paginatedData = data.sublist(startData, endData);

    return widget.builder(paginatedData, paginationButtonsWidget,
        startData < 1 ? 1 : startData, endData ?? totalData, totalData);
  }
}
