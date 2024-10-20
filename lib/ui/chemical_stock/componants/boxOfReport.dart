import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/ui/chemical_stock/chemecalsModels.dart';
import '../../../app/extentions.dart';
import '../ChemicalsController.dart';
import '../../../controllers/dropDowen_controller.dart';

import 'package:provider/provider.dart';

class BoxOFReport extends StatelessWidget {
  BoxOFReport({super.key});
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'تقرير الكمية المتوفره فقط',
      'تقرير حركة المخزون',
      'تقرير الوارد فقط',
      'تقرير المنصرف فقط ',
      "تقرير الكميه الموشكة على الانتهاء"
    ];
    //value of report type

    return Container(
      height: MediaQuery.of(context).size.height * .25,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 204, 241, 252),
              Color.fromARGB(255, 202, 243, 239),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          border: Border.all(width: 2, color: Colors.teal),
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          //نوع التقرير
          Consumer<dropDowenContoller>(
            builder: (context, myType, child) {
              return DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  isExpanded: true,
                  hint: const Center(
                    child: Text(
                      'نوع التقرير',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurpleAccent,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  items: items
                      .map((String item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ))
                      .toList(),
                  value: myType.selectedreport,
                  onChanged: (String? value) {
                    myType.selectedreport = value;
                    myType.Refrsh_ui();
                  },
                  buttonStyleData: ButtonStyleData(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 50,
                    width: MediaQuery.of(context).size.width * .8,
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    height: 40,
                  ),
                ),
              );
            },
          ),
          //العائلات والاصناف
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<Chemicals_controller>(
                builder: (context, myType, child) {
                  List<ChemicalsModel> l = myType.chiemicals
                      .filterItemsPasedONFamilys(context, myType.selctedFamilys)
                      .filterItemsPasedONnames(context, myType.selctedNames);
                  return Row(
                    children: [
                      DropdownButton2<String>(
                          isExpanded: true,
                          hint: Center(
                            child: Text(
                              'كل العائلات',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                          items: l
                              .map((e) => e.family)
                              .toSet()
                              .toList()
                              .map((item) {
                            return DropdownMenuItem(
                              value: item,
                              //disable default onTap to avoid closing menu when selecting an item
                              enabled: false,
                              child: StatefulBuilder(
                                builder: (context, menuSetState) {
                                  final isSelected =
                                      myType.selctedFamilys.contains(item);
                                  return InkWell(
                                    onTap: () {
                                      isSelected
                                          ? myType.selctedFamilys.remove(item)
                                          : myType.selctedFamilys.add(item);

                                      //This rebuilds the StatefulWidget to update the button's text
                                      myType.Refresh_Ui();
                                      //This rebuilds the dropdownMenu Widget to update the check mark
                                      menuSetState(() {});
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          if (isSelected)
                                            const Icon(Icons.check_box_outlined)
                                          else
                                            const Icon(
                                                Icons.check_box_outline_blank),
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
                          value: myType.selctedFamilys.isEmpty
                              ? null
                              : myType.selctedFamilys.last,
                          onChanged: (value) {},
                          selectedItemBuilder: (context) {
                            return l.map((e) => e.family).toSet().toList().map(
                              (item) {
                                return Container(
                                  alignment: AlignmentDirectional.center,
                                  child: Text(
                                    myType.selctedFamilys.join(', '),
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                                color:
                                    const Color.fromARGB(255, 204, 225, 241)),
                            padding: const EdgeInsets.only(left: 16, right: 8),
                            height: 40,
                            width: MediaQuery.of(context).size.width * .46,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 60,
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
                              return item.value
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchValue.toLowerCase());
                            },
                          )),
                      DropdownButton2<String>(
                          isExpanded: true,
                          hint: Center(
                            child: Text(
                              'كل الاصناف',
                              style: TextStyle(
                                fontSize: 18,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ),
                          items:
                              l.map((e) => e.name).toSet().toList().map((item) {
                            return DropdownMenuItem(
                              value: item,
                              //disable default onTap to avoid closing menu when selecting an item
                              enabled: false,
                              child: StatefulBuilder(
                                builder: (context, menuSetState) {
                                  final isSelected =
                                      myType.selctedNames.contains(item);
                                  return InkWell(
                                    onTap: () {
                                      isSelected
                                          ? myType.selctedNames.remove(item)
                                          : myType.selctedNames.add(item);

                                      //This rebuilds the StatefulWidget to update the button's text
                                      myType.Refresh_Ui();
                                      //This rebuilds the dropdownMenu Widget to update the check mark
                                      menuSetState(() {});
                                    },
                                    child: Container(
                                      height: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: Row(
                                        children: [
                                          if (isSelected)
                                            const Icon(Icons.check_box_outlined)
                                          else
                                            const Icon(
                                                Icons.check_box_outline_blank),
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
                          value: myType.selctedNames.isEmpty
                              ? null
                              : myType.selctedNames.last,
                          onChanged: (value) {},
                          selectedItemBuilder: (context) {
                            return l.map((e) => e.name).toSet().toList().map(
                              (item) {
                                return Container(
                                  alignment: AlignmentDirectional.center,
                                  child: Text(
                                    myType.selctedNames.join(', '),
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(6)),
                                color:
                                    const Color.fromARGB(255, 204, 225, 241)),
                            padding: const EdgeInsets.only(left: 16, right: 8),
                            height: 40,
                            width: MediaQuery.of(context).size.width * .48,
                          ),
                          dropdownStyleData: const DropdownStyleData(
                            maxHeight: 200,
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 50,
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
                              return item.value
                                  .toString()
                                  .toLowerCase()
                                  .contains(searchValue.toLowerCase());
                            },
                          )),
                    ],
                  );
                },
              ),
            ].reversed.toList(),
          ),
          //التاريخ
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const DatepickerTo33(),
              context.read<dropDowenContoller>().selectedreport ==
                      'تقرير الكمية المتوفره فقط'
                  ? const SizedBox()
                  : const DatepickerFrom33(),
            ],
          ),
        ],
      ),
    );
  }
}

class DateSetting extends StatelessWidget {
  DateSetting({
    super.key,
  });

  final List<String> items2 = [
    'حتى يوم',
    'خلال يوم',
    'خلال شهر',
    'خلال السنه',
    "خلال مده "
  ];
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // DatepickerTo2(),
        // DatepickerFrom2(),

        // Padding(
        //   padding: const EdgeInsets.only(top: 22),
        //   child: SizedBox(
        //     width: 100,
        //     height: 50,
        //     child: DropdownButtonFormField2<String>(
        //       decoration: const InputDecoration(
        //           label: Text("التاريخ"),
        //           contentPadding: EdgeInsets.symmetric(vertical: 16),
        //           border: OutlineInputBorder(),
        //           disabledBorder: OutlineInputBorder(
        //               borderSide: BorderSide(color: Colors.teal)),
        //           enabledBorder: OutlineInputBorder(
        //               borderSide:
        //                   BorderSide(width: 1.3, color: Colors.teal))),
        //       hint: const Text(
        //         'حتى اليوم',
        //         style: TextStyle(fontSize: 14),
        //       ),
        //       items: items2
        //           .map((item) => DropdownMenuItem<String>(
        //                 value: item,
        //                 child: Center(
        //                   child: Text(
        //                     item,
        //                     style: const TextStyle(
        //                       fontSize: 14,
        //                     ),
        //                   ),
        //                 ),
        //               ))
        //           .toList(),
        //       validator: (value) {
        //         if (value == null) {
        //           return 'Please select value.';
        //         }
        //         return null;
        //       },
        //       onChanged: (value) {
        //         //Do something when selected item is changed.
        //       },
        //       onSaved: (value) {},
        //       buttonStyleData: const ButtonStyleData(
        //         padding: EdgeInsets.only(right: 8),
        //       ),
        //       iconStyleData: const IconStyleData(
        //         icon: Icon(
        //           Icons.arrow_drop_down,
        //           color: Colors.black45,
        //         ),
        //         iconSize: 22,
        //       ),
        //       dropdownStyleData: DropdownStyleData(
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(15),
        //         ),
        //       ),
        //       menuItemStyleData: const MenuItemStyleData(
        //         padding: EdgeInsets.symmetric(horizontal: 2),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class DatepickerFrom33 extends StatelessWidget {
  const DatepickerFrom33({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<Chemicals_controller>().pickedDateFrom = DateTime.now();
    return Consumer<Chemicals_controller>(
      builder: (context, myType, child) {
        return const Column(
          children: [
            // TextButton(
            //     onPressed: () async {
            //       DateTime? pickedDate = await showDatePicker(
            //           context: context,
            //           initialDate: myType.pickedDateFrom,
            //           firstDate: myType.AllDatesOfOfData().min,
            //           lastDate: DateTime.now());

            //       if (pickedDate != null) {
            //         myType.pickedDateFrom = pickedDate;
            //         myType.Refresh_Ui();
            //       } else {}
            //     },
            //     child: Column(
            //       children: [
            //         const Text(
            //           "من",
            //           style:
            //               TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //         ),
            //         Container(
            //           padding: const EdgeInsets.all(6),
            //           decoration: BoxDecoration(
            //               border: Border.all(width: 1, color: Colors.teal),
            //               borderRadius: BorderRadius.circular(5)),
            //           child: Text(
            //             myType.pickedDateFrom!.formatt(),
            //             style: const TextStyle(
            //                 fontSize: 15,
            //                 color: Color.fromARGB(255, 97, 92, 92),
            //                 fontWeight: FontWeight.bold),
            //           ),
            //         ),
            //       ],
            //     )),
          ],
        );
      },
    );
  }
}

class DatepickerTo33 extends StatelessWidget {
  const DatepickerTo33({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<Chemicals_controller>().pickedDateFrom = DateTime.now();

    context.read<Chemicals_controller>().pickedDateTo = DateTime.now();
    return Consumer<Chemicals_controller>(
      builder: (context, myType, child) {
        if (myType.pickedDateFrom!.microsecondsSinceEpoch >
            myType.pickedDateTo!.microsecondsSinceEpoch) {
          myType.pickedDateTo = myType.pickedDateFrom;
        }
        return Column(
          children: [
            TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: myType.pickedDateTo!,
                      firstDate: myType.pickedDateFrom!,
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    myType.pickedDateTo = pickedDate;
                    myType.Refresh_Ui();
                  } else {}
                },
                child: Column(
                  children: [
                    const Text(
                      "الى",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.teal),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        myType.pickedDateTo!.formatt(),
                        style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 97, 92, 92),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )),
          ],
        );
      },
    );
  }
}
