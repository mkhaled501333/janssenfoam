import 'package:flutter/material.dart';
import 'package:janssenfoam/core/base/base_view_mode.dart';
import '../../app/extentions.dart';
import 'non_final_controller.dart';
import '../../models/moderls.dart';
import 'package:provider/provider.dart';

class NotFinalViewModer extends BaseViewModel {
  add(BuildContext context, String type) {
    // if (formKey.currentState!.validate()) {
    //   NotFinal input = NotFinal(

    //     actions: [],
    //     notFinal_ID: DateTime.now().microsecondsSinceEpoch,
    //     wight: double.parse(wightcontroller.text),
    //     type: type,
    //   );
    //   context.read<NonFinalController>().add_to_not_FInals(input);
    //   clearfields();
    // }
  }

  addwithMinus(BuildContext context, String type) {
//     if (formKey.currentState!.validate()) {
//       NotFinal input = NotFinal(
// block_ID: ,
//         actions: [],
//         notFinal_ID: DateTime.now().microsecondsSinceEpoch,
//         wight: -double.parse(wightcontroller.text),
//         type: type,
//       );
//       context.read<NonFinalController>().add_to_not_FInals(input);

//       clearfields();
//     }
  }

  get(String v) {
    switch (v) {
      case "جوانب ":
        return "aspects";
      case "ارضيات":
        return "floors";
      case " هالك":
        return "Halek";
      case " درجة ثانيه":
        return "secondDegree";
      case " درجه ثانيه ممتازه":
        return "ExcellentsecondDegree";
    }
  }

//الحصول على البيانات
  data_for_type(BuildContext context, String type, List<NotFinal> notFinals) {
    var a = notFinals
        .where((element) => element.type == get(type))
        .map((e) => e.wight);
    return a.isEmpty ? a : a.reduce((a, b) => a + b).removeTrailingZeros;
  }

  delete(BuildContext context, int id) {
    context.read<NonFinalController>().delete_not_FInals(id);
  }
}
