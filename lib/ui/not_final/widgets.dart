import 'package:flutter/material.dart';
import '../../app/validation.dart';
import '../../core/commen/textformfield.dart';
import 'not_final_viewModer.dart';

showAlertDialog(
    BuildContext context, NotFinalViewModer vm, int i, String type) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('  ?'),
          content: SizedBox(
            height: 200,
            child: Column(children: [
              Form(
                key: vm.formKey,
                child: CustomTextFormField(
                  width: MediaQuery.of(context).size.width * .18,
                  keybordtupe: TextInputType.number,
                  hint: "وزن",
                  controller: vm.wightcontroller,
                  validator: Validation.validateothers,
                ),
              )
            ]),
          ),
          actions: [
            ElevatedButton(
                // style: ElevatedButton.styleFrom(primary: Colors.green),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No')),
            ElevatedButton(
                // style: ElevatedButton.styleFrom(primary: Colors.red),
                onPressed: () {
                  switch (i) {
                    case 0:
                      vm.add(context, type);
                      break;
                    case 1:
                      vm.addwithMinus(context, type);
                      break;
                  }
                  Navigator.pop(context);
                },
                child: const Text(
                  'yes',
                )),
          ],
        );
      });
}
