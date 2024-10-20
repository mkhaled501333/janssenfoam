// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/ui/industerial_security/utites.dart';
import 'package:provider/provider.dart';

import 'package:janssenfoam/app/extentions.dart';
import 'package:janssenfoam/models/moderls.dart';
import 'package:janssenfoam/ui/industerial_security/industerialSecurityController.dart';

class IndusterialSecurityReport extends StatelessWidget {
  const IndusterialSecurityReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [DatepickerTo4(), DatepickerFrom4()],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 200,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Consumer<IndusterialSecuritycontroller>(
                    builder: (context, myType, child) {
                      List<IndusterialSecurityModel> all = myType.all.values
                          .toList()
                          .filterFinalProductDateBetween(
                              myType.pickedDateFrom!, myType.pickedDateTO!)
                          .filterwithpoints(myType.selectedPoints)
                          .filterWithPerson(myType.selectedPersons)
                          .filterWithhours(myType.selectedhous);
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomDropDown(
                                items: all.map((e) => e.place).toSet().toList(),
                                refrech: myType.Refresh_the_UI,
                                selecteditems: myType.selectedPoints,
                                tittle: 'نقط',
                              ),
                              CustomDropDown(
                                items: all.map((e) => e.who).toSet().toList(),
                                refrech: myType.Refresh_the_UI,
                                selecteditems: myType.selectedPersons,
                                tittle: 'اشخاص',
                              ),
                              CustomDropDown(
                                items: all
                                    .map((e) => e.date.hour.toString())
                                    .toSet()
                                    .toList(),
                                refrech: myType.Refresh_the_UI,
                                selecteditems: myType.selectedhous,
                                tittle: 'ساعات',
                              ),
                            ],
                          ),
                          ...all.map((e) => RecordWidg(
                                e: e,
                              ))
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class RecordWidg extends StatefulWidget {
  const RecordWidg({
    super.key,
    required this.e,
  });
  final IndusterialSecurityModel e;

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
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                border: Border.all(), color: Colors.amber.shade100),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          widget.e.place,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          widget.e.who,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          widget.e.date.formatt2(),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    Text(
                      widget.e.note,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        showPhoto
            ? const SizedBox()
            : Column(
                children: [
                  InteractiveViewer(
                    child: Column(
                      children: [
                        Image.network(
                          'http://192.168.1.225:8080/industerialsecurity?imageid=${widget.e.ImageId}',
                          width: 400,
                          height: 400,
                          fit: BoxFit.fill,
                        ),
                      ],
                    ),
                  ),
                ],
              )
      ],
    );
  }
}

class DatepickerFrom4 extends StatelessWidget {
  const DatepickerFrom4({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<IndusterialSecuritycontroller>().pickedDateFrom =
        DateTime.now();
    return Consumer<IndusterialSecuritycontroller>(
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
    context.read<IndusterialSecuritycontroller>().pickedDateFrom =
        DateTime.now();

    context.read<IndusterialSecuritycontroller>().pickedDateTO = DateTime.now();
    return Consumer<IndusterialSecuritycontroller>(
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
                      initialDatePickerMode: DatePickerMode.day,
                      context: context,
                      initialDate: myType.pickedDateTO!,
                      firstDate: myType.pickedDateFrom!,
                      lastDate: DateTime.now());

                  if (pickedDate != null) {
                    myType.pickedDateTO = pickedDate;
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
