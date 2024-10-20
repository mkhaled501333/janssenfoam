// ignore_for_file: camel_case_types, constant_identifier_names, camel_case_extensions

import 'package:janssenfoam/core/recources/strings_manager.dart';
import 'package:janssenfoam/models/moderls.dart';

enum BlockAction {
  create_block,
  consume_block,
  unconsume_block,
  recive_block_form_cuttingUnit,
  cut_block_on_H,
  UN_cut_block_on_H,
  archive_block,
}

extension fdg on BlockAction {
  ActionModel get add {
    switch (this) {
      case BlockAction.create_block:
        return ActionModel(
            action: "create_block",
            who: SringsManager.myemail,
            when: DateTime.now());
      case BlockAction.consume_block:
        return ActionModel(
            action: "consume_block",
            who: SringsManager.myemail,
            when: DateTime.now());
      case BlockAction.unconsume_block:
        return ActionModel(
            action: "unconsume_block",
            who: SringsManager.myemail,
            when: DateTime.now());
      case BlockAction.recive_block_form_cuttingUnit:
        return ActionModel(
            action: "recive_block_form_cuttingUnit",
            who: SringsManager.myemail,
            when: DateTime.now());
      case BlockAction.cut_block_on_H:
        return ActionModel(
            action: "cut_block_on_H",
            who: SringsManager.myemail,
            when: DateTime.now());
      case BlockAction.archive_block:
        return ActionModel(
            action: "archive_block",
            who: SringsManager.myemail,
            when: DateTime.now());
      case BlockAction.UN_cut_block_on_H:
        return ActionModel(
            action: "UN_cut_block_on_H",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getactionTitle {
    switch (this) {
      case BlockAction.UN_cut_block_on_H:
        return "UN_cut_block_on_H";
      case BlockAction.create_block:
        return "create_block";
      case BlockAction.consume_block:
        return "consume_block";
      case BlockAction.unconsume_block:
        return "unconsume_block";
      case BlockAction.recive_block_form_cuttingUnit:
        return "recive_block_form_cuttingUnit";
      case BlockAction.cut_block_on_H:
        return "cut_block_on_H";
      case BlockAction.archive_block:
        return "archive_block";
    }
  }
}

enum finalProdcutAction {
  incert_finalProduct_from_cutingUnit,
  final_prodcut_DidQalityCheck,
  out_order,
  archive_final_prodcut,
  recive_Done_Form_FinalProdcutStock,
  incert_finalProduct_from_Others,
  createInvoice,
  incert_From_StockChekRefresh
}

extension fsfs on finalProdcutAction {
  ActionModel get add {
    switch (this) {
      case finalProdcutAction.incert_finalProduct_from_cutingUnit:
        return ActionModel(
            action: "incert_finalProduct_from_cutingUnit",
            who: SringsManager.myemail,
            when: DateTime.now());
      case finalProdcutAction.out_order:
        return ActionModel(
            action: "out_order",
            who: SringsManager.myemail,
            when: DateTime.now());
      case finalProdcutAction.archive_final_prodcut:
        return ActionModel(
            action: "archive_final_prodcut",
            who: SringsManager.myemail,
            when: DateTime.now());
      case finalProdcutAction.recive_Done_Form_FinalProdcutStock:
        return ActionModel(
            action: "recive_Done_Form_FinalProdcutStock",
            who: SringsManager.myemail,
            when: DateTime.now());
      case finalProdcutAction.final_prodcut_DidQalityCheck:
        return ActionModel(
            action: "final_prodcut_DidQalityCheck",
            who: SringsManager.myemail,
            when: DateTime.now());
      case finalProdcutAction.incert_finalProduct_from_Others:
        return ActionModel(
            action: "incert_finalProduct_from_Others",
            who: SringsManager.myemail,
            when: DateTime.now());
      case finalProdcutAction.createInvoice:
        return ActionModel(
            action: "createInvoice",
            who: SringsManager.myemail,
            when: DateTime.now());
      case finalProdcutAction.incert_From_StockChekRefresh:
        return ActionModel(
            action: "incert_From_StockChekRefresh",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getactionTitle {
    switch (this) {
      case finalProdcutAction.incert_From_StockChekRefresh:
        return "incert_From_StockChekRefresh";
      case finalProdcutAction.incert_finalProduct_from_cutingUnit:
        return "incert_finalProduct_from_cutingUnit";
      case finalProdcutAction.out_order:
        return "out_order";
      case finalProdcutAction.archive_final_prodcut:
        return "archive_final_prodcut";
      case finalProdcutAction.recive_Done_Form_FinalProdcutStock:
        return "recive_Done_Form_FinalProdcutStock";
      case finalProdcutAction.final_prodcut_DidQalityCheck:
        return "final_prodcut_DidQalityCheck";
      case finalProdcutAction.incert_finalProduct_from_Others:
        return "incert_finalProduct_from_Others";
      case finalProdcutAction.createInvoice:
        return "createInvoice";
    }
  }
}

enum FractionActon {
  creat_fraction,
  archive_fraction,
  cut_fraction_OnHscissor,
  Uncut_fraction_OnHscissor,
  cut_fraction_OnRscissor,
  Uncut_fraction_OnRscissor,
  cut_fraction_OnAscissor,
  Uncut_fraction_OnAscissor
}

extension X5 on FractionActon {
  ActionModel get add {
    switch (this) {
      case FractionActon.creat_fraction:
        return ActionModel(
            action: "creat_fraction",
            who: SringsManager.myemail,
            when: DateTime.now());
      case FractionActon.archive_fraction:
        return ActionModel(
            action: "archive_fraction",
            who: SringsManager.myemail,
            when: DateTime.now());
      case FractionActon.cut_fraction_OnHscissor:
        return ActionModel(
            action: "cut_fraction_OnHscissor",
            who: SringsManager.myemail,
            when: DateTime.now());
      case FractionActon.cut_fraction_OnRscissor:
        return ActionModel(
            action: "cut_fraction_OnRscissor",
            who: SringsManager.myemail,
            when: DateTime.now());
      case FractionActon.cut_fraction_OnAscissor:
        return ActionModel(
            action: "cut_fraction_OnAscissor",
            who: SringsManager.myemail,
            when: DateTime.now());
      case FractionActon.Uncut_fraction_OnHscissor:
        return ActionModel(
            action: "Uncut_fraction_OnHscissor",
            who: SringsManager.myemail,
            when: DateTime.now());
      case FractionActon.Uncut_fraction_OnRscissor:
        return ActionModel(
            action: "Uncut_fraction_OnRscissor",
            who: SringsManager.myemail,
            when: DateTime.now());
      case FractionActon.Uncut_fraction_OnAscissor:
        return ActionModel(
            action: "Uncut_fraction_OnAscissor",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case FractionActon.Uncut_fraction_OnHscissor:
        return "Uncut_fraction_OnHscissor";
      case FractionActon.Uncut_fraction_OnRscissor:
        return "Uncut_fraction_OnRscissor";
      case FractionActon.Uncut_fraction_OnAscissor:
        return "Uncut_fraction_OnAscissor";
      case FractionActon.creat_fraction:
        return "creat_fraction";
      case FractionActon.archive_fraction:
        return "archive_fraction";
      case FractionActon.cut_fraction_OnHscissor:
        return "cut_fraction_OnHscissor";
      case FractionActon.cut_fraction_OnRscissor:
        return "cut_fraction_OnRscissor";
      case FractionActon.cut_fraction_OnAscissor:
        return "cut_fraction_OnAscissor";
    }
  }
}

enum InvoiceAction {
  creat_invoice,
  archive_invoice,
}

extension Xdf5 on InvoiceAction {
  ActionModel get add {
    switch (this) {
      case InvoiceAction.creat_invoice:
        return ActionModel(
            action: "creat_invoice",
            who: SringsManager.myemail,
            when: DateTime.now());
      case InvoiceAction.archive_invoice:
        return ActionModel(
            action: "archive_invoice",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case InvoiceAction.creat_invoice:
        return "creat_invoice";
      case InvoiceAction.archive_invoice:
        return "archive_invoice";
    }
  }
}

enum StockCheckAction {
  creat_new_StockCheck,
  refrechDone,
  archive_StockCheck,
}

extension DD34 on StockCheckAction {
  ActionModel get add {
    switch (this) {
      case StockCheckAction.creat_new_StockCheck:
        return ActionModel(
            action: "creat_new_StockCheck",
            who: SringsManager.myemail,
            when: DateTime.now());
      case StockCheckAction.archive_StockCheck:
        return ActionModel(
            action: "archive_StockCheck",
            who: SringsManager.myemail,
            when: DateTime.now());
      case StockCheckAction.refrechDone:
        return ActionModel(
            action: "refrechDone",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case StockCheckAction.refrechDone:
        return "refrechDone";
      case StockCheckAction.creat_new_StockCheck:
        return "creat_new_StockCheck";
      case StockCheckAction.archive_StockCheck:
        return "archive_StockCheck";
    }
  }
}

enum PurcheAction {
  creat_new_Purche,
  archive_Purche,
  create_new_purcheItem,
  add_purche_offer,
  archive_purche_offer,
  offer_chosen,
  Purche_approved_Financem,
  Purche_approved_generalm,
  Purche_approved_PurcheM,
}

extension Fdf on PurcheAction {
  ActionModel get add {
    switch (this) {
      case PurcheAction.creat_new_Purche:
        return ActionModel(
            action: "creat_new_Purche",
            who: SringsManager.myemail,
            when: DateTime.now());
      case PurcheAction.archive_Purche:
        return ActionModel(
            action: "archive_Purche",
            who: SringsManager.myemail,
            when: DateTime.now());
      case PurcheAction.create_new_purcheItem:
        return ActionModel(
            action: "create_new_purcheItem",
            who: SringsManager.myemail,
            when: DateTime.now());

      case PurcheAction.archive_purche_offer:
        return ActionModel(
            action: "archive_purche_offer",
            who: SringsManager.myemail,
            when: DateTime.now());
      case PurcheAction.offer_chosen:
        return ActionModel(
            action: "offer_chosen",
            who: SringsManager.myemail,
            when: DateTime.now());
      case PurcheAction.add_purche_offer:
        return ActionModel(
            action: "add_purche_offerm",
            who: SringsManager.myemail,
            when: DateTime.now());
      case PurcheAction.Purche_approved_Financem:
        return ActionModel(
            action: "Purche_approved_Financem",
            who: SringsManager.myemail,
            when: DateTime.now());
      case PurcheAction.Purche_approved_generalm:
        return ActionModel(
            action: "Purche_approved_generalm",
            who: SringsManager.myemail,
            when: DateTime.now());
      case PurcheAction.Purche_approved_PurcheM:
        return ActionModel(
            action: "Purche_approved_PurcheM",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case PurcheAction.add_purche_offer:
        return "add_purche_offer";
      case PurcheAction.create_new_purcheItem:
        return "create_new_purcheItem";
      case PurcheAction.archive_purche_offer:
        return "archive_purche_offer";
      case PurcheAction.offer_chosen:
        return "offer_chosen";

      case PurcheAction.creat_new_Purche:
        return "creat_new_Purche";
      case PurcheAction.archive_Purche:
        return "archive_Purche";
      case PurcheAction.Purche_approved_Financem:
        return "Purche_approved_Financem";
      case PurcheAction.Purche_approved_generalm:
        return "Purche_approved_generalm";
      case PurcheAction.Purche_approved_PurcheM:
        return "Purche_approved_PurcheM";
    }
  }
}

enum Chemical_Category {
  creat_new_Chemical_category,
  archive_Chemical_category,
}

extension CVF on Chemical_Category {
  ActionModel get add {
    switch (this) {
      case Chemical_Category.creat_new_Chemical_category:
        return ActionModel(
            action: "creat_new_Chemical_category",
            who: SringsManager.myemail,
            when: DateTime.now());
      case Chemical_Category.archive_Chemical_category:
        return ActionModel(
            action: "archive_Chemical_category",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case Chemical_Category.creat_new_Chemical_category:
        return "creat_new_Chemical_category";
      case Chemical_Category.archive_Chemical_category:
        return "archive_Chemical_category";
    }
  }
}

enum BlockCategoryAction {
  creat_new_block_category,
  archive_block_category,
}

extension ddsd on BlockCategoryAction {
  ActionModel get add {
    switch (this) {
      case BlockCategoryAction.creat_new_block_category:
        return ActionModel(
            action: "creat_new_block_category",
            who: SringsManager.myemail,
            when: DateTime.now());
      case BlockCategoryAction.archive_block_category:
        return ActionModel(
            action: "archive_block_category",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case BlockCategoryAction.creat_new_block_category:
        return "creat_new_block_category";
      case BlockCategoryAction.archive_block_category:
        return "archive_block_category";
    }
  }
}

enum VeiwingAction {
  openHomePage,
  Open_IcertIn_BlockModule,
  close_IcertIn_BlockModule,
}

extension Dsf on VeiwingAction {
  ActionModel get add {
    switch (this) {
      case VeiwingAction.Open_IcertIn_BlockModule:
        return ActionModel(
            action: "فتح اضافة الى البلوكات",
            who: SringsManager.myemail,
            when: DateTime.now());
      case VeiwingAction.close_IcertIn_BlockModule:
        return ActionModel(
            action: "غلق اضافة الى البلوكات",
            who: SringsManager.myemail,
            when: DateTime.now());

      case VeiwingAction.openHomePage:
        return ActionModel(
            action: "فتح الصفحة الرئيسيه",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case VeiwingAction.Open_IcertIn_BlockModule:
        return "فتح اضافة الى البلوكات";
      case VeiwingAction.close_IcertIn_BlockModule:
        return "غلق اضافة الى البلوكات";
      case VeiwingAction.openHomePage:
        return "فتح الصفحة الرئيسيه";
    }
  }
}

enum ChemicalAction {
  creat_new_ChemicalAction_item,
  creat_Out_ChemicalAction_item,
  archive_ChemicalAction_item,
}

extension DSD on ChemicalAction {
  ActionModel get add {
    switch (this) {
      case ChemicalAction.creat_new_ChemicalAction_item:
        return ActionModel(
            action: "creat_new_ChemicalAction_item",
            who: SringsManager.myemail,
            when: DateTime.now());
      case ChemicalAction.archive_ChemicalAction_item:
        return ActionModel(
            action: "archive_ChemicalAction_item",
            who: SringsManager.myemail,
            when: DateTime.now());
      case ChemicalAction.creat_Out_ChemicalAction_item:
        return ActionModel(
            action: "creat_Out_ChemicalAction_item",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case ChemicalAction.creat_new_ChemicalAction_item:
        return "creat_new_ChemicalAction_item";
      case ChemicalAction.archive_ChemicalAction_item:
        return "archive_ChemicalAction_item";
      case ChemicalAction.creat_Out_ChemicalAction_item:
        return "creat_Out_ChemicalAction_item";
    }
  }
}

enum NonFinalType {
  floors,
  aspects,
  secondDegree,
  ExcellentsecondDegree,
  Halek;
}

extension Dkk on NonFinalType {
  String get getactionTitle {
    switch (this) {
      case NonFinalType.floors:
        return "floors";
      case NonFinalType.aspects:
        return "aspects";
      case NonFinalType.secondDegree:
        return "secondDegree";
      case NonFinalType.ExcellentsecondDegree:
        return "ExcellentsecondDegree";
      case NonFinalType.Halek:
        return "Halek";
    }
  }
}

enum NotFinalAction {
  create_Not_final_cumingFrom_H,
  create_Not_final_cumingFrom_R,
  create_Not_final_cumingFrom_A,
}

extension SSS on NotFinalAction {
  ActionModel get add {
    switch (this) {
      case NotFinalAction.create_Not_final_cumingFrom_H:
        return ActionModel(
            action: "create_Not_final_cumingFrom_H",
            who: SringsManager.myemail,
            when: DateTime.now());
      case NotFinalAction.create_Not_final_cumingFrom_R:
        return ActionModel(
            action: "create_Not_final_cumingFrom_R",
            who: SringsManager.myemail,
            when: DateTime.now());
      case NotFinalAction.create_Not_final_cumingFrom_A:
        return ActionModel(
            action: "create_Not_final_cumingFrom_A",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case NotFinalAction.create_Not_final_cumingFrom_H:
        return "create_Not_final_cumingFrom_H";
      case NotFinalAction.create_Not_final_cumingFrom_R:
        return "create_Not_final_cumingFrom_R";
      case NotFinalAction.create_Not_final_cumingFrom_A:
        return "create_Not_final_cumingFrom_A";
    }
  }
}

enum customerAction {
  create_new_customer,
  archive_customer,
}

extension CCc on customerAction {
  ActionModel get add {
    switch (this) {
      case customerAction.create_new_customer:
        return ActionModel(
            action: "create_new_customer",
            who: SringsManager.myemail,
            when: DateTime.now());
      case customerAction.archive_customer:
        return ActionModel(
            action: "archive_customer",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case customerAction.create_new_customer:
        return "create_new_customer";
      case customerAction.archive_customer:
        return "archive_customer";
    }
  }
}

enum subfractionAction {
  create_new_subfraction,
  archive_subfraction,
  cut_subfraction_on_H,
  cut_subfraction_on_R,
  cut_subfraction_on_A,
  add_not_final_toSubfractions,
  remove_not_final_fromSubfractions
}

extension dfdff on subfractionAction {
  ActionModel get add {
    switch (this) {
      case subfractionAction.create_new_subfraction:
        return ActionModel(
            action: "create_new_subfraction",
            who: SringsManager.myemail,
            when: DateTime.now());
      case subfractionAction.archive_subfraction:
        return ActionModel(
            action: "archive_subfraction",
            who: SringsManager.myemail,
            when: DateTime.now());
      case subfractionAction.cut_subfraction_on_H:
        return ActionModel(
            action: "cut_subfraction_on_H",
            who: SringsManager.myemail,
            when: DateTime.now());
      case subfractionAction.cut_subfraction_on_R:
        return ActionModel(
            action: "cut_subfraction_on_R",
            who: SringsManager.myemail,
            when: DateTime.now());
      case subfractionAction.cut_subfraction_on_A:
        return ActionModel(
            action: "cut_subfraction_on_A",
            who: SringsManager.myemail,
            when: DateTime.now());
      case subfractionAction.add_not_final_toSubfractions:
        return ActionModel(
            action: "add_not_final_toSubfractions",
            who: SringsManager.myemail,
            when: DateTime.now());
      case subfractionAction.remove_not_final_fromSubfractions:
        return ActionModel(
            action: "remove_not_final_fromSubfractions",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case subfractionAction.remove_not_final_fromSubfractions:
        return "remove_not_final_fromSubfractions";
      case subfractionAction.add_not_final_toSubfractions:
        return "add_not_final_toSubfractions";
      case subfractionAction.cut_subfraction_on_A:
        return "cut_subfraction_on_A";
      case subfractionAction.cut_subfraction_on_R:
        return "cut_subfraction_on_R";
      case subfractionAction.cut_subfraction_on_H:
        return "cut_subfraction_on_H";
      case subfractionAction.create_new_subfraction:
        return "create_new_subfraction";
      case subfractionAction.archive_subfraction:
        return "archive_subfraction";
    }
  }
}

enum OrderAction {
  create_order,
  Archive_order,
  order_aproved_from_calculation,
  order_aproved_from_control,
  order_edit,
  order_colosed,
}

extension FF on OrderAction {
  ActionModel get add {
    switch (this) {
      case OrderAction.order_edit:
        return ActionModel(
            action: "order_edit",
            who: SringsManager.myemail,
            when: DateTime.now());
      case OrderAction.create_order:
        return ActionModel(
            action: "create_order",
            who: SringsManager.myemail,
            when: DateTime.now());
      case OrderAction.Archive_order:
        return ActionModel(
            action: "Archive_order",
            who: SringsManager.myemail,
            when: DateTime.now());
      case OrderAction.order_aproved_from_calculation:
        return ActionModel(
            action: "order_aproved_from_calculation",
            who: SringsManager.myemail,
            when: DateTime.now());
      case OrderAction.order_aproved_from_control:
        return ActionModel(
            action: "order_aproved_from_control",
            who: SringsManager.myemail,
            when: DateTime.now());
      case OrderAction.order_colosed:
        return ActionModel(
            action: "order_colosed",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case OrderAction.order_edit:
        return "order_edit";
      case OrderAction.create_order:
        return "create_order";
      case OrderAction.Archive_order:
        return "Archive_order";
      case OrderAction.order_aproved_from_calculation:
        return "order_aproved_from_calculation";
      case OrderAction.order_aproved_from_control:
        return "order_aproved_from_control";
      case OrderAction.order_colosed:
        return "order_colosed";
    }
  }
}

enum Appactions {
  open_Home_page,
  open_1_addToBlock,
  open_2_addTOFInalProdcut,
  open_3_blockOUtOfStock,
  open_4_importedFromScissros,
}

extension A323 on Appactions {
  ActionModel get add {
    switch (this) {
      case Appactions.open_Home_page:
        return ActionModel(
            action: "open_Home_page",
            who: SringsManager.myemail,
            when: DateTime.now());
      case Appactions.open_4_importedFromScissros:
        return ActionModel(
            action: "open_4_importedFromScissros",
            who: SringsManager.myemail,
            when: DateTime.now());
      case Appactions.open_1_addToBlock:
        return ActionModel(
            action: "open_1_addToBlock",
            who: SringsManager.myemail,
            when: DateTime.now());
      case Appactions.open_2_addTOFInalProdcut:
        return ActionModel(
            action: "open_2_addTOFInalProdcut",
            who: SringsManager.myemail,
            when: DateTime.now());
      case Appactions.open_3_blockOUtOfStock:
        return ActionModel(
            action: "open_3_blockOUtOfStock",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case Appactions.open_Home_page:
        return "open_Home_page";
      case Appactions.open_1_addToBlock:
        return "open_1_addToBlock";
      case Appactions.open_2_addTOFInalProdcut:
        return "open_2_addTOFInalProdcut";
      case Appactions.open_3_blockOUtOfStock:
        return "open_3_blockOUtOfStock";
      case Appactions.open_4_importedFromScissros:
        return "open_4_importedFromScissros";
    }
  }
}

enum UserAction {
  creat_user,
  archive_user,
}

extension Q12 on UserAction {
  ActionModel get add {
    switch (this) {
      case UserAction.creat_user:
        return ActionModel(
            action: "creat_user",
            who: SringsManager.myemail,
            when: DateTime.now());
      case UserAction.archive_user:
        return ActionModel(
            action: "archive_user",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case UserAction.creat_user:
        return "creat_user";
      case UserAction.archive_user:
        return "archive_user";
    }
  }
}

enum WhigtTecketAction {
  create_newTicket,
  create_fristWhight,
  create_secondWhigt,
  archive_tecket
}

extension dddfdfcv on WhigtTecketAction {
  ActionModel get add {
    switch (this) {
      case WhigtTecketAction.create_fristWhight:
        return ActionModel(
            action: "create_fristWhight",
            who: SringsManager.myemail,
            when: DateTime.now());
      case WhigtTecketAction.create_secondWhigt:
        return ActionModel(
            action: "create_secondWhigt",
            who: SringsManager.myemail,
            when: DateTime.now());
      case WhigtTecketAction.archive_tecket:
        return ActionModel(
            action: "archive_tecket",
            who: SringsManager.myemail,
            when: DateTime.now());
      case WhigtTecketAction.create_newTicket:
        return ActionModel(
            action: "create_newTicket",
            who: SringsManager.myemail,
            when: DateTime.now());
    }
  }

  String get getTitle {
    switch (this) {
      case WhigtTecketAction.create_newTicket:
        return "create_newTicket";
      case WhigtTecketAction.create_fristWhight:
        return "create_fristWhight";
      case WhigtTecketAction.create_secondWhigt:
        return "create_secondWhigt";
      case WhigtTecketAction.archive_tecket:
        return "archive_tecket";
    }
  }
}
