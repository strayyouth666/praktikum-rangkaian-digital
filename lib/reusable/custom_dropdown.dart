import 'dart:math';
import 'package:flutter/material.dart';
import 'package:smartcare_web/reusable/project_colors.dart';

import 'clickable_ripple.dart';
import 'content_container.dart';
import 'custom_input.dart';
import 'input_label.dart';
import 'loading_placeholder.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final void Function(T? value)? onChanged;
  final void Function(List<T> value)? onMultipleValuesChanged;
  final String? hint;
  final bool isExpanded,
      hintAtTheTop,
      required,
      searcheable,
      allowMultipleValues,
      enabled,
      canRetractValue;
  final CustomDropdownController<T>? controller;
  final Color? borderColor;
  final void Function()? dropDownOnTap;

  static Widget loadingPlaceholder({double? width}) => LoadingPlaceholder(
        height: 50,
        width: width ?? double.infinity,
      );

  static Widget dropdownContainer(
          {required Widget child,
          Color? borderColor,
          bool isExpanded = false}) =>
      Container(
          width: isExpanded ? double.infinity : null,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              border: Border.all(
                  color: borderColor ?? const Color(0xffdddddd), width: 1.5),
              borderRadius: BorderRadius.circular(10)),
          child: child);

  const CustomDropdown(
      {Key? key,
      required this.items,
      this.onChanged,
      this.hint,
      this.isExpanded = false,
      this.hintAtTheTop = false,
      this.dropDownOnTap,
      this.controller,
      this.required = false,
      this.borderColor,
      this.searcheable = false,
      this.allowMultipleValues = false,
      this.onMultipleValuesChanged,
      this.canRetractValue = false,
      this.enabled = false})
      : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  T? value;
  bool modifiedByUser = false;
  late CustomDropdownController<T> controller;

  onChanged(T? val) {
    setState(() {
      value = val;
      modifiedByUser = true;
    });

    controller.value = val;
    if (widget.onChanged != null) widget.onChanged!(val);
  }

  @override
  void initState() {
    super.initState();

    controller = widget.controller ?? CustomDropdownController<T>();
  }

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      if (widget.controller != null) {
        if (widget.controller!.value != null) {
          value = widget.controller!.value;
        }
      }
    }

    final valueCheck = widget.items.where((element) => element.value == value);
    var _items = widget.items;

    if (valueCheck.isEmpty) value = null;

    if (widget.canRetractValue) {
      _items = [
        DropdownMenuItem<T>(
            onTap: () => onChanged(null),
            child: Text("-- Select ${widget.hint} ---",
                style: const TextStyle(
                    color: Color.fromARGB(255, 182, 182, 182)))),
        ..._items
      ];
    }

    Widget dropdown = CustomDropdown.dropdownContainer(
      borderColor: widget.borderColor,
      child: DropdownButton<T>(
          onTap: widget.dropDownOnTap,
          underline: const SizedBox(),
          isExpanded: widget.isExpanded,
          isDense: true,
          value: value,
          hint: widget.hint != null
              ? Text(
                  widget.hintAtTheTop ? "Select ${widget.hint!}" : widget.hint!,
                )
              : null,
          items: _items,
          onChanged: onChanged),
    );

    if (widget.searcheable || widget.allowMultipleValues) {
      dropdown = _SearcheableCustomDropdown<T>(
          widget: widget,
          onChanged: onChanged,
          value: value,
          controller: controller,
          multipleValues: widget.allowMultipleValues);
    }

    if (widget.hintAtTheTop && widget.hint != null) {
      return InputLabel(
        label: widget.hint!,
        child: dropdown,
        required: widget.required,
      );
    }

    return dropdown;
  }
}

class _SearcheableCustomDropdown<T> extends StatefulWidget {
  const _SearcheableCustomDropdown(
      {Key? key,
      required this.widget,
      required this.onChanged,
      this.value,
      this.controller,
      required this.multipleValues})
      : super(key: key);

  final CustomDropdown<T> widget;
  final void Function(T? val) onChanged;
  final T? value;
  final CustomDropdownController<T>? controller;
  final bool multipleValues;

  @override
  State<_SearcheableCustomDropdown<T>> createState() =>
      __SearcheableCustomDropdownState<T>();
}

class __SearcheableCustomDropdownState<T>
    extends State<_SearcheableCustomDropdown<T>> {
  late OverlayEntry overlay;
  final layerLink = LayerLink();
  String query = '';
  String? joinedValuesFromMultiple;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.subtitle1;

    // if (joinedValuesFromMultiple == null &&
    //     widget.controller != null &&
    //     widget.controller!.multipleValues.isNotEmpty) {
    //   joinedValuesFromMultiple = widget.controller!.multipleValues.join(", ");
    // }

    return CompositedTransformFollower(
        link: layerLink,
        child: ClickableRipple(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              if (widget.widget.dropDownOnTap != null) {
                widget.widget.dropDownOnTap!();
              }

              setDropdownVisibility(visible: true);
            },
            child: CustomDropdown.dropdownContainer(
                borderColor: widget.widget.borderColor,
                isExpanded: widget.widget.isExpanded,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: widget.controller != null &&
                              widget.controller!.multipleValues.isNotEmpty
                          ? Builder(builder: (context) {
                              final children = <Widget>[];

                              for (final value
                                  in widget.controller!.multipleValues) {
                                for (final item in widget.widget.items) {
                                  if (item.value == value) {
                                    children.addAll([
                                      Flexible(
                                          child: DefaultTextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: ProjectColors
                                                      .defaultBlack),
                                              child: item.child)),
                                      const SizedBox(width: 2),
                                      const Text(", ")
                                    ]);
                                  }
                                }
                              }

                              return Row(children: children);
                            })
                          : Text(
                              joinedValuesFromMultiple ??
                                  widget.value?.toString() ??
                                  widget.widget.hint ??
                                  "Select item",
                              overflow: TextOverflow.ellipsis,
                              style: widget.value == null
                                  ? textStyle?.merge(const TextStyle(
                                      color: ProjectColors.lightBlack))
                                  : textStyle),
                    ),
                    const SizedBox(width: 5),
                    const Icon(Icons.arrow_drop_down)
                  ],
                ))));
  }

  OverlayEntry overlayBuilder() {
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final globalOffset = renderBox.localToGlobal(Offset.zero);
    final screenSize = MediaQuery.of(context).size;

    return OverlayEntry(builder: (context) {
      final filteredItems = widget.widget.items
          .where((element) => element.value
              .toString()
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();

      return GestureDetector(
          onTap: setDropdownVisibility,
          behavior: HitTestBehavior.translucent,
          child: SizedBox(
              width: screenSize.width,
              height: screenSize.height,
              child: Stack(children: [
                Positioned(
                    left: globalOffset.dx,
                    top: globalOffset.dy + size.height,
                    child: CompositedTransformFollower(
                        link: layerLink,
                        child: Material(
                          color: Colors.transparent,
                          child: ContentContainer(
                              padding: EdgeInsets.zero,
                              fluid: false,
                              width: size.width,
                              constraints: BoxConstraints(
                                  maxHeight: screenSize.height -
                                      globalOffset.dy -
                                      size.height -
                                      50),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: CustomInput(
                                        hint: "Search",
                                        prefixIcon: const Icon(Icons.search),
                                        onChanged: (val) {
                                          setState(() {
                                            query = val;
                                          });
                                        }),
                                  ),
                                  if (!widget.widget.allowMultipleValues)
                                    Flexible(
                                      child: ListView.builder(
                                          itemCount: filteredItems.length,
                                          padding:
                                              const EdgeInsets.only(bottom: 10),
                                          shrinkWrap: true,
                                          itemBuilder: ((context, index) {
                                            final item = filteredItems[index];
                                            return ClickableRipple(
                                                onTap: () {
                                                  if (!widget.multipleValues) {
                                                    widget
                                                        .onChanged(item.value);
                                                    setDropdownVisibility();
                                                  }
                                                },
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: item.child));
                                          })),
                                    )
                                  else
                                    Flexible(
                                        child:
                                            _CustomDropdownWithMultipleSelection<
                                                    T>(
                                                controller: widget.controller,
                                                query: query,
                                                filteredItems: filteredItems,
                                                onMultipleValuesChanged:
                                                    onMultipleValuesChanged,
                                                widget: widget.widget)),
                                ],
                              )),
                        )))
              ])));
    });
  }

  void onMultipleValuesChanged(List<T> values) {
    if (widget.widget.onMultipleValuesChanged != null) {
      widget.widget.onMultipleValuesChanged!(values);
    }

    setState(() {
      if (values.isEmpty) return joinedValuesFromMultiple = null;

      joinedValuesFromMultiple = values.join(", ");
    });
  }

  void setDropdownVisibility({bool visible = false}) {
    if (visible) {
      overlay = overlayBuilder();
      return Overlay.of(context).insert(overlay);
    }

    query = '';
    overlay.remove();

    if (widget.multipleValues) {
      onMultipleValuesChanged(widget.controller?.multipleValues ?? []);
    }
  }
}

class _CustomDropdownWithMultipleSelection<T> extends StatefulWidget {
  const _CustomDropdownWithMultipleSelection(
      {Key? key,
      this.controller,
      required this.widget,
      required this.query,
      required this.filteredItems,
      required this.onMultipleValuesChanged})
      : super(key: key);

  final CustomDropdownController<T>? controller;
  final CustomDropdown<T> widget;
  final String query;
  final List<DropdownMenuItem<T?>> filteredItems;
  final void Function(List<T> values) onMultipleValuesChanged;

  @override
  State<_CustomDropdownWithMultipleSelection<T>> createState() =>
      __CustomDropdownWithMultipleSelectionState<T>();
}

class __CustomDropdownWithMultipleSelectionState<T>
    extends State<_CustomDropdownWithMultipleSelection<T>> {
  List<T> selectedValues = [];

  void onChanged(T value) {
    final index = selectedValues.indexOf(value);
    final controller = widget.controller;
    final copy = selectedValues;

    if (index > -1) {
      copy.removeAt(index);
    } else {
      copy.add(value);
    }

    setState(() {
      controller?.multipleValues = copy;
      selectedValues = copy;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (selectedValues.isEmpty &&
        widget.controller != null &&
        widget.controller!.multipleValues.isNotEmpty) {
      selectedValues = widget.controller!.multipleValues;
    }

    final filteredItems = widget.filteredItems;

    return ListView.builder(
        itemCount: filteredItems.length,
        padding: const EdgeInsets.only(bottom: 10),
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          final item = filteredItems[index];
          final selected = selectedValues.contains(item.value);

          return ClickableRipple(
              onTap: () {
                onChanged(item.value!);
              },
              child: Container(
                  color: selected ? Colors.blue.withOpacity(.1) : null,
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    children: [
                      Expanded(child: item.child),
                      Visibility(
                        visible: selected,
                        child: Row(
                          children: const [
                            SizedBox(width: 3),
                            Icon(Icons.check, color: Colors.blue),
                          ],
                        ),
                      )
                    ],
                  )));
        }));
  }
}

class CustomDropdownController<T> {
  T? value;
  String id = String.fromCharCodes(
      List.generate(16, (index) => Random().nextInt(33) + 89));
  List<T> multipleValues = [];

  set initialValue(T? value) {
    this.value = this.value ?? value;
  }
}
