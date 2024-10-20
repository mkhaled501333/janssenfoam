import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import '../../app/extentions.dart';
import 'stockCheckController.dart';

import 'package:provider/provider.dart';

class BoxOFReportForStockChek extends StatelessWidget {
  BoxOFReportForStockChek({super.key});
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'تقرير عمليات الجرد',
      'تقرير عمليات تحديث الكميات',
      'تقرير الاصناف الغير مجروده',
      'تقرير الاصناف الزائده',
      'تقرير الاصناف الناقصه ',
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
          Consumer<StokCheck_Controller>(
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
                    myType.Refresh_the_UI();
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

          //التاريخ
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DatepickerTo3(),
              DatepickerFrom3(),
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
        DatepickerTo3(),
        DatepickerFrom3(),

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

class DatepickerFrom3 extends StatelessWidget {
  const DatepickerFrom3({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<StokCheck_Controller>().pickedDateFrom = DateTime.now();
    return Consumer<StokCheck_Controller>(
      builder: (context, myType, child) {
        return Column(
          children: [
            TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: myType.pickedDateFrom,
                      firstDate: myType.AllDatesOfOfData().min,
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    myType.pickedDateFrom = pickedDate;
                    myType.Refresh_the_UI();
                  } else {}
                },
                child: Column(
                  children: [
                    const Text(
                      "من",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.teal),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        myType.pickedDateFrom!.formatt(),
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

class DatepickerTo3 extends StatelessWidget {
  const DatepickerTo3({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<StokCheck_Controller>().pickedDateFrom = DateTime.now();

    context.read<StokCheck_Controller>().pickedDateTo = DateTime.now();
    return Consumer<StokCheck_Controller>(
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
                      lastDate: myType.AllDatesOfOfData().max);

                  if (pickedDate != null) {
                    myType.pickedDateTo = pickedDate;
                    myType.Refresh_the_UI();
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
