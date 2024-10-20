// ignore_for_file: public_member_api_docs, sort_constructors_first, camel_case_types
// ignore_for_file: must_be_immutable

import 'dart:typed_data';

import 'package:collection/collection.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/controllers/biscol.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/models/moderls.dart';

import 'package:provider/provider.dart';

class biscolView extends StatelessWidget {
  const biscolView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 9, 116, 238),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdwoenFOrArvhived(),
              const DatepickerFrom4(),
              const DatepickerTo4(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Dropdowen(),
              Dropdowen_Drivers(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Dropdowen_customers(),
              Dropdowen_prodcutName(),
            ],
          ),
          Consumer<Hivecontroller>(
            builder: (context, myType, child) {
              return Towdirectonscroll();
            },
          )
        ],
      ),
    );
  }
}

class Towdirectonscroll extends StatelessWidget {
  Towdirectonscroll({
    super.key,
  });

  final yourScrollController = ScrollController();
  final yourScrollController2 = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<Hivecontroller>(
      builder: (context, myType, child) {
        List<WieghtTecketMOdel> filterd = myType.allrecords.values
            .toList()
            .filterDataBetween(myType.pickedDateFrom!, myType.pickedDateTO!)
            .filtercarnums(myType.selectedCarNum)
            .filterdrivers(myType.selectedDrivers)
            .filtercustomers(myType.selectedcustomerName)
            .filterdeleted(myType.archived);
        return SizedBox(
          width: 980,
          child: Scrollbar(
            thumbVisibility: true,
            controller: yourScrollController,
            child: SingleChildScrollView(
              reverse: true,
              controller: yourScrollController,
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const RecordHeader(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.vertical -
                        294,
                    child: Scrollbar(
                      controller: yourScrollController2,
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        controller: yourScrollController2,
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: filterd
                              .map((e) => RecordWidg(
                                    ticket: e,
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class RecordWidg extends StatefulWidget {
  const RecordWidg({
    super.key,
    required this.ticket,
  });
  final WieghtTecketMOdel ticket;

  @override
  State<RecordWidg> createState() => _RecordWidgState();
}

class _RecordWidgState extends State<RecordWidg> {
  var showPhoto = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              showPhoto = !showPhoto;
            });
          },
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 70,
                  decoration: BoxDecoration(
                      border: Border.all(), color: Colors.amber.shade100),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: IconButton(
                          onPressed: () {
                            context.read<Hivecontroller>().canedit1 = false;

                            context
                                .read<Hivecontroller>()
                                .FillRecord(widget.ticket);
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.open_in_browser)),
                    ),
                  ),
                ),
                Container(
                  width: 70,
                  decoration: BoxDecoration(
                      border: Border.all(), color: Colors.amber.shade100),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text(
                        widget.ticket.wightTecket_serial.toString(),
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(), color: Colors.amber.shade100),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text(
                        '${widget.ticket.carNum}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(), color: Colors.amber.shade100),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text(
                        widget.ticket.driverName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(), color: Colors.amber.shade100),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text(
                        widget.ticket.customerName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(), color: Colors.amber.shade100),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text(
                        widget.ticket.prodcutName,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(), color: Colors.amber.shade100),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text(
                        '${widget.ticket.firstShot}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(), color: Colors.amber.shade100),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text(
                        '${widget.ticket.secondShot}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(), color: Colors.amber.shade100),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text(
                        '${widget.ticket.totalWeight}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  decoration: BoxDecoration(
                      border: Border.all(), color: Colors.amber.shade100),
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: Text(
                        '${widget.ticket.stockRequsition_serial}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ].reversed.toList(),
            ),
          ),
        ),
        showPhoto
            ? const SizedBox()
            : Column(
                children: [
                  const Text(
                    "عند الوزن الاول",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      InteractiveViewer(
                        child: Column(
                          children: [
                            Visibility(
                              visible: widget.ticket.synced == true &&
                                  widget
                                      .ticket.firstShotpiccam1Adress.isNotEmpty,
                              child: Image.network(
                                'http://192.168.1.225:8080/i?imageid=${widget.ticket.firstShotpiccam1Adress}',
                                width: 400,
                                height: 400,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Visibility(
                              visible: widget.ticket.synced == false,
                              child: Image.memory(
                                Uint8List.fromList(
                                    widget.ticket.firstShotpiccam1),
                                width: 400,
                                height: 400,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InteractiveViewer(
                        child: Column(
                          children: [
                            Visibility(
                              visible: widget.ticket.synced == true &&
                                  widget
                                      .ticket.firstShotpiccam2Adress.isNotEmpty,
                              child: Image.network(
                                'http://192.168.1.225:8080/i?imageid=${widget.ticket.firstShotpiccam2Adress}',
                                width: 400,
                                height: 400,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Visibility(
                              visible: widget.ticket.synced == false,
                              child: Image.memory(
                                Uint8List.fromList(
                                    widget.ticket.firstShotpiccam2),
                                width: 400,
                                height: 400,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "عند الوزن الثانى",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      InteractiveViewer(
                        child: Column(
                          children: [
                            Visibility(
                              visible: widget.ticket.synced == true &&
                                  widget.ticket.secondShotpiccam1Adress
                                      .isNotEmpty,
                              child: Image.network(
                                'http://192.168.1.225:8080/i?imageid=${widget.ticket.secondShotpiccam1Adress}',
                                width: 400,
                                height: 400,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Visibility(
                              visible: widget.ticket.synced == false,
                              child: Image.memory(
                                Uint8List.fromList(
                                    widget.ticket.secondShotpiccam1),
                                width: 400,
                                height: 400,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InteractiveViewer(
                        child: Column(
                          children: [
                            Visibility(
                              visible: widget.ticket.synced == true &&
                                  widget.ticket.secondShotpiccam2Adress
                                      .isNotEmpty,
                              child: Image.network(
                                'http://192.168.1.225:8080/i?imageid=${widget.ticket.secondShotpiccam2Adress}',
                                width: 400,
                                height: 400,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Visibility(
                              visible: widget.ticket.synced == false,
                              child: Image.memory(
                                Uint8List.fromList(
                                    widget.ticket.secondShotpiccam2),
                                width: 400,
                                height: 400,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
      ],
    );
  }
}

class RecordHeader extends StatelessWidget {
  const RecordHeader({super.key});
  final color = const Color.fromARGB(255, 197, 150, 8);
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 70,
            decoration: BoxDecoration(border: Border.all(), color: color),
            child: const Padding(
              padding: EdgeInsets.all(3.0),
              child: Center(
                child: Text(
                  'فتح',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Container(
            width: 70,
            decoration: BoxDecoration(border: Border.all(), color: color),
            child: const Padding(
              padding: EdgeInsets.all(3.0),
              child: Center(
                child: Text(
                  'م التذكره',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Container(
            width: 100,
            decoration: BoxDecoration(border: Border.all(), color: color),
            child: const Padding(
              padding: EdgeInsets.all(3.0),
              child: Center(
                child: Text(
                  'رقم السياره',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Container(
            width: 100,
            decoration: BoxDecoration(border: Border.all(), color: color),
            child: const Padding(
              padding: EdgeInsets.all(3.0),
              child: Center(
                child: Text(
                  'اسم السائق',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Container(
            width: 100,
            decoration: BoxDecoration(border: Border.all(), color: color),
            child: const Padding(
              padding: EdgeInsets.all(3.0),
              child: Center(
                child: Text(
                  'عميل / مورد',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Container(
            width: 100,
            decoration: BoxDecoration(border: Border.all(), color: color),
            child: const Padding(
              padding: EdgeInsets.all(3.0),
              child: Center(
                child: Text(
                  'الصنف',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Container(
            width: 100,
            decoration: BoxDecoration(border: Border.all(), color: color),
            child: const Padding(
              padding: EdgeInsets.all(3.0),
              child: Center(
                child: Text(
                  'الوزنه الاولى',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Container(
            width: 100,
            decoration: BoxDecoration(border: Border.all(), color: color),
            child: const Padding(
              padding: EdgeInsets.all(3.0),
              child: Center(
                child: Text(
                  'الوزنه الثانيه',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Container(
            width: 100,
            decoration: BoxDecoration(border: Border.all(), color: color),
            child: const Padding(
              padding: EdgeInsets.all(3.0),
              child: Center(
                child: Text(
                  '  الصافى ',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Container(
            width: 100,
            decoration: BoxDecoration(border: Border.all(), color: color),
            child: const Padding(
              padding: EdgeInsets.all(3.0),
              child: Center(
                child: Text(
                  'م اذن التحميل',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
        ].reversed.toList(),
      ),
    );
  }
}

class DatepickerFrom4 extends StatelessWidget {
  const DatepickerFrom4({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<Hivecontroller>().pickedDateFrom = DateTime.now();
    return Consumer<Hivecontroller>(
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
                    myType.Refrech_UI();
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
                        myType.pickedDateFrom!.formatt_yMd(),
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

class DatepickerTo4 extends StatelessWidget {
  const DatepickerTo4({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<Hivecontroller>().pickedDateFrom = DateTime.now();

    context.read<Hivecontroller>().pickedDateTO = DateTime.now();
    return Consumer<Hivecontroller>(
      builder: (context, myType, child) {
        if (myType.pickedDateFrom!.microsecondsSinceEpoch >
            myType.pickedDateTO!.microsecondsSinceEpoch) {
          myType.pickedDateTO = myType.pickedDateFrom;
        }
        return Column(
          children: [
            TextButton(
                onPressed: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: myType.pickedDateTO!,
                      firstDate: myType.pickedDateFrom!,
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    myType.pickedDateTO = pickedDate;
                    myType.Refrech_UI();
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
                        myType.pickedDateTO!.formatt_yMd(),
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

class Dropdowen extends StatelessWidget {
  Dropdowen({
    super.key,
  });
  String tittle = 'ارقام العربات';

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<Hivecontroller>(
      builder: (context, myType, child) {
        List<String> items = myType.allrecords.values
            .toList()
            .filterDataBetween(myType.pickedDateFrom!, myType.pickedDateTO!)
            .map((e) => e.carNum.toString())
            .toList();
        List<String> selecteditems = myType.selectedCarNum;
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
            items: items.toSet().toList().map((item) {
              return DropdownMenuItem(
                value: item,
                //disable default onTap to avoid closing menu when selecting an item
                enabled: false,
                child: StatefulBuilder(
                  builder: (context, menuSetState) {
                    final isSelected = selecteditems.contains(item);
                    return InkWell(
                      onTap: () {
                        print(item);
                        isSelected
                            ? selecteditems.remove(item)
                            : selecteditems.add(item);

                        //This rebuilds the StatefulWidget to update the button's text
                        myType.Refrech_UI();
                        //This rebuilds the dropdownMenu Widget to update the check mark
                        menuSetState(() {});
                      },
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  color: const Color.fromARGB(255, 204, 225, 241)),
              padding: const EdgeInsets.only(left: 16, right: 8),
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
      },
    );
  }
}

class Dropdowen_Drivers extends StatelessWidget {
  Dropdowen_Drivers({
    super.key,
  });
  String tittle = 'السائقين';

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<Hivecontroller>(
      builder: (context, myType, child) {
        List<String> items = myType.allrecords.values
            .toList()
            .filterDataBetween(myType.pickedDateFrom!, myType.pickedDateTO!)
            .map((e) => e.driverName.toString())
            .toList();
        List<String> selecteditems = myType.selectedDrivers;
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
            items: items.toSet().toList().map((item) {
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
                        myType.Refrech_UI();
                        //This rebuilds the dropdownMenu Widget to update the check mark
                        menuSetState(() {});
                      },
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  color: const Color.fromARGB(255, 204, 225, 241)),
              padding: const EdgeInsets.only(left: 16, right: 8),
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
      },
    );
  }
}

class Dropdowen_customers extends StatelessWidget {
  Dropdowen_customers({
    super.key,
  });
  String tittle = 'العملاء';

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<Hivecontroller>(
      builder: (context, myType, child) {
        List<String> items = myType.allrecords.values
            .toList()
            .filterDataBetween(myType.pickedDateFrom!, myType.pickedDateTO!)
            .map((e) => e.customerName.toString())
            .toList();
        List<String> selecteditems = myType.selectedcustomerName;
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
            items: items.toSet().toList().map((item) {
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
                        myType.Refrech_UI();
                        //This rebuilds the dropdownMenu Widget to update the check mark
                        menuSetState(() {});
                      },
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  color: const Color.fromARGB(255, 204, 225, 241)),
              padding: const EdgeInsets.only(left: 16, right: 8),
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
      },
    );
  }
}

class Dropdowen_prodcutName extends StatelessWidget {
  Dropdowen_prodcutName({
    super.key,
  });
  String tittle = 'الاصناف';

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<Hivecontroller>(
      builder: (context, myType, child) {
        List<String> items = myType.allrecords.values
            .toList()
            .filterDataBetween(myType.pickedDateFrom!, myType.pickedDateTO!)
            .map((e) => e.prodcutName.toString())
            .toList();
        List<String> selecteditems = myType.selectedProdcutName;
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
            items: items.toSet().toList().map((item) {
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
                        myType.Refrech_UI();
                        //This rebuilds the dropdownMenu Widget to update the check mark
                        menuSetState(() {});
                      },
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  color: const Color.fromARGB(255, 204, 225, 241)),
              padding: const EdgeInsets.only(left: 16, right: 8),
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
      },
    );
  }
}

class Dropdowen_doneOrNot extends StatelessWidget {
  Dropdowen_doneOrNot({
    super.key,
  });
  String tittle = 'مكتمل وغير مكتمل';

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<Hivecontroller>(
      builder: (context, myType, child) {
        List<String> items =
            myType.allrecords.values.map((e) => e.carNum.toString()).toList();
        List<String> selecteditems = myType.selectedCarNum;
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
            items: items.map((item) {
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
                        myType.Refrech_UI();
                        //This rebuilds the dropdownMenu Widget to update the check mark
                        menuSetState(() {});
                      },
                      child: Container(
                        height: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                  color: const Color.fromARGB(255, 204, 225, 241)),
              padding: const EdgeInsets.only(left: 16, right: 8),
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
      },
    );
  }
}

class DropdwoenFOrArvhived extends StatelessWidget {
  DropdwoenFOrArvhived({super.key});
  List<String> a = ['محزوف', 'غير محزوف', 'كل'];
  @override
  Widget build(BuildContext context) {
    return Consumer<Hivecontroller>(
      builder: (context, myType, child) {
        return DropdownButton(
            value: myType.archived,
            items: a
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ))
                .toList(),
            onChanged: (v) {
              myType.archived = v!;
              myType.Refrech_UI();
            });
      },
    );
  }
}

extension F on List<WieghtTecketMOdel> {
  List<WieghtTecketMOdel> filtercarnums(List<String> curnums) {
    List<WieghtTecketMOdel> l = [];
    if (curnums.isNotEmpty) {
      for (var f in curnums) {
        for (var i in this) {
          if (i.carNum.toString() == f) {
            l.add(i);
          }
        }
      }
      return l;
    } else {
      return this;
    }
  }

  List<WieghtTecketMOdel> filterdeleted(String archived) {
    if (archived == 'كل') {
      return this;
    } else if (archived == 'محزوف') {
      return where((e) =>
          e.actions
              .if_action_exist(WhigtTecketAction.archive_tecket.getTitle) ==
          true).toList();
    } else {
      return where((e) =>
          e.actions
              .if_action_exist(WhigtTecketAction.archive_tecket.getTitle) ==
          false).toList();
    }
  }

  List<WieghtTecketMOdel> filtercustomers(List<String> curnums) {
    List<WieghtTecketMOdel> l = [];
    if (curnums.isNotEmpty) {
      for (var f in curnums) {
        for (var i in this) {
          if (i.customerName.toString() == f) {
            l.add(i);
          }
        }
      }
      return l;
    } else {
      return this;
    }
  }

  List<WieghtTecketMOdel> filterdrivers(List<String> drivers) {
    List<WieghtTecketMOdel> l = [];
    if (drivers.isNotEmpty) {
      for (var f in drivers) {
        for (var i in this) {
          if (i.driverName.toString() == f) {
            l.add(i);
          }
        }
      }
      return l;
    } else {
      return this;
    }
  }

  List<WieghtTecketMOdel> filterDataBetween(DateTime from, DateTime to) {
    return where((e) =>
        e.actions
                .get_Date_of_action(WhigtTecketAction.create_newTicket.getTitle)
                .formatToInt() >=
            from.formatToInt() &&
        e.actions
                .get_Date_of_action(WhigtTecketAction.create_newTicket.getTitle)
                .formatToInt() <=
            to.formatToInt()).toList();
  }
}
