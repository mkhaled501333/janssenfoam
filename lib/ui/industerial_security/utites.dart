import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/models/moderls.dart';

extension Dd on List<IndusterialSecurityModel> {
  List<IndusterialSecurityModel> filterFinalProductDateBetween(
    DateTime start,
    DateTime end,
  ) {
    return where((element) =>
        element.date.formatToInt() >= start.formatToInt() &&
        element.date.formatToInt() <= end.formatToInt()).toList();
  }

  List<IndusterialSecurityModel> filterwithpoints(List<String> points) {
    List<IndusterialSecurityModel> t = [];
    if (points.isNotEmpty) {
      for (var f in points) {
        for (var i in this) {
          if (i.place == f) {
            t.add(i);
          }
        }
      }
      return t;
    } else {
      return this;
    }
  }

  List<IndusterialSecurityModel> filterWithPerson(List<String> persons) {
    List<IndusterialSecurityModel> t = [];
    if (persons.isNotEmpty) {
      for (var f in persons) {
        for (var i in this) {
          if (i.who == f) {
            t.add(i);
          }
        }
      }
      return t;
    } else {
      return this;
    }
  }

  List<IndusterialSecurityModel> filterWithhours(List<String> hours) {
    List<IndusterialSecurityModel> t = [];
    if (hours.isNotEmpty) {
      for (var f in hours) {
        for (var i in this) {
          if (i.date.hour.toString() == f) {
            t.add(i);
          }
        }
      }
      return t;
    } else {
      return this;
    }
  }
}

class CustomDropDown extends StatelessWidget {
  CustomDropDown({
    super.key,
    required this.refrech,
    required this.items,
    required this.selecteditems,
    required this.tittle,
  });
  final String tittle;
  final Function refrech;
  final List<String> items;
  final List<String> selecteditems;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<String>(
        isExpanded: true,
        hint: Center(
          child: Text(
            tittle,
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).hintColor,
            ),
          ),
        ),
        items: items.toSet().map((item) {
          return DropdownMenuItem(
            value: item,
            //disable default onTap to avoid closing menu when selecting an item
            enabled: false,
            child: StatefulBuilder(
              builder: (context, menuSetState) {
                final isSelected = selecteditems.contains(item);
                return InkWell(
                  onTap: () {
                    isSelected
                        ? selecteditems.remove(item)
                        : selecteditems.add(item);

                    //This rebuilds the StatefulWidget to update the button's text
                    refrech();
                    //This rebuilds the dropdownMenu Widget to update the check mark
                    menuSetState(() {});
                  },
                  child: Container(
                    height: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      children: [
                        if (isSelected)
                          const Icon(Icons.check_box_outlined)
                        else
                          const Icon(Icons.check_box_outline_blank),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
        //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
        value: selecteditems.isEmpty ? null : selecteditems.last,
        onChanged: (value) {},
        selectedItemBuilder: (context) {
          return items.map(
            (item) {
              return Container(
                alignment: AlignmentDirectional.center,
                child: Text(
                  selecteditems.join(', '),
                  style: const TextStyle(
                    fontSize: 14,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              );
            },
          ).toList();
        },
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: const BorderRadius.all(Radius.circular(7)),
              color: const Color.fromARGB(255, 204, 225, 241)),
          padding: const EdgeInsets.only(left: 17, right: 8),
          height: 50,
          width: MediaQuery.of(context).size.width * .3,
        ),
        dropdownStyleData: const DropdownStyleData(
          maxHeight: 200,
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.zero,
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: textEditingController,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Container(
            height: 50,
            padding: const EdgeInsets.only(
              top: 8,
              bottom: 4,
              right: 8,
              left: 8,
            ),
            child: TextFormField(
              expands: true,
              maxLines: null,
              controller: textEditingController,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                hintText: 'Search for an item...',
                hintStyle: const TextStyle(fontSize: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          searchMatchFn: (item, searchValue) {
            return item.value.toString().contains(searchValue);
          },
        ));
  }
}
