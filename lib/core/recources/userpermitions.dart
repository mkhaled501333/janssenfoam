// ignore_for_file: constant_identifier_names

//صلاحيات المستخدمين

enum UserPermition {
  show_all,
  //البلوكات
  can_get_data_of_blocks,
  blocks_OUT,
  show_date_in_block_out_of_stock,
  delete_in_consume_block,
  can_edit_outTo,
  can_edit_saba,
  show_Reports_totals_of_blocks,
  show_Reports_consume_boock,
  show_Reports_details_of_block_stock,
  show_Reports_details_of_sizes_of_block_stock,
  show_Reports_every_serial,
  //المنتج التام
  can_get_data_of_final_prodcut,
  show_finalProdcut_stock,
  show_finalprodcut_importedFormcuttingUint,
  incert_in_finalProdcut_imorted,
  incert_unregular_in_importedfinal_prodcut,
  incert_underoperation,
  incert_notFinal_in_importedfinal_prodcut,
  incert_in_final_prodcutStock,
  incert_in_final_prodcutStock_From_Excel,
  delete_in_imported_finalprodcut,
  show_date_in_finalProduct_imported,
  can_aprove_from_quality,
  can_aprove_from_recive_from_final_prodcut,
  show_total_in_finalproduct,
  show_Reports_finalprodcut,
  delete_in_finalprodcut_details,
  allow_edit_in_details_finalProdcut,
  allow_edit_in_details_blocks,
  show_Reports_details_of_finalProdcut_stock,
  //الفواتير
  can_get_data_of_invoice,
  show_finalprodcut_invoice,
  show_finalprodcut_invoicemaking,
  show_setting_in_out_order,
  show_date_in_invoices,
//اومر الشغل
  can_get_data_of_orders,
  show_cutting_orders,
  show_cusotmer_name_in_cutting_order,
  show_cutting_order_notifications,
  incert_in_cutting_order,
  can_aprove_from_controll,
  can_aprove_from_calculation,
  can_print_in_cutting_order,
  can_edit_in_cutting_order,
  can_close_in_cutting_order,
  delete_in_cutting_order,
  full_Red_of_cuttingOrder,
  //الفرد
  can_get_data_of_fractions,
  can_get_data_of_subfractions,
  show_block_incetion,
  show_date_in_block_stock,
  incert_in_block_stock,
  //المقصات
  show_scissors,
  show_not_final_stock,
  show_add_new_category,
  show_Ohda_management,
  //الكيماويات
  show_chemicals_model,
  show_Chemical_category,
  can_get_data_of_chemicals,
  can_get_data_of_chemical_category,
  //العملاء
  can_get_data_of_customers,
  show_customers,
  incert_in_customers,
  show_search_in_customers,
// المشتروات
  can_get_data_of_purches,
  Show_purches_module,
  can_print_in_purche,
  sho_details_in_purchItem,
  can_make_new_purch_order,
  can_put_offer_in_purche,
  can_chose_from_offerPurches,
  can_approve_from_purchingManager,
  can_approve_from_financeManager,
  can_approve_from_generalManager,
//الامن الصناعى
  Industrial_Security,
// الجرد
  show_stcokCheck_moldule,
  can_get_data_of_stcokCheck,
//المقصات
  show_H1,
  show_H2,
  show_H3,
  show_R1,
  show_R2,
  show_R3,
  Rshow_bottomOFfinalproduct,
  Rshow_bottomOFFractions,
  Rshow_bottomOFNotfinl,
  can_delete_fractons_cutted_on_R,
  show_A1,
  Hide_sizeofblock_formmainviewin_H,
  //
  show_Reports_final_prodcutscisors,
  show_Reports_H,
  show_Reports_R,
  show_Reports_Comparison_Of_consumedAndResults,
  //
  show_users_actions,
  can_get_data_of_notfinals,
  show_massaging,
  not_working,
  chat,
  online_orders,
}

extension QQ on UserPermition {
  String get getTitle {
    switch (this) {
      case UserPermition.online_orders:
        return "موديول الاوردرات الاونلاين";
      case UserPermition.chat:
        return "موديول المراسله و الطلبات";
      case UserPermition.Industrial_Security:
        return "موديول الامن الصناعى";
      case UserPermition.can_edit_in_cutting_order:
        return "التعديل فى اوامر الشغل";
      case UserPermition.show_cutting_order_notifications:
        return "عرض اشعارات اوامر التشغيل";
      case UserPermition.full_Red_of_cuttingOrder:
        return "امر التشغيل احمر ب الكامل حال عدم الموافقه";
      case UserPermition.can_edit_outTo:
        return "امكانية تعديل جهة الصرف";
      case UserPermition.show_stcokCheck_moldule:
        return "اظهار موديول الجرد";
      case UserPermition.can_get_data_of_stcokCheck:
        return "can_get_data_of_stcokCheck";
      case UserPermition.Hide_sizeofblock_formmainviewin_H:
        return "اخفاء مقاس البلوك فى المقص الراسى";
      case UserPermition.can_get_data_of_subfractions:
        return "can_get_data_of_subfractions";
      case UserPermition.can_delete_fractons_cutted_on_R:
        return "امكانية حذف الفرد المقصوصه على الدائرى";
      case UserPermition.show_total_in_finalproduct:
        return "اظهار الاجمالى فى وارد المخزن من المقصات";

      case UserPermition.incert_underoperation:
        return "Rاضافة شغل مرحله اخرى";
      case UserPermition.Rshow_bottomOFfinalproduct:
        return "Rزر اضافه الى الصادر";
      case UserPermition.Rshow_bottomOFFractions:
        return "Rزر اضافه الى الوراد";
      case UserPermition.Rshow_bottomOFNotfinl:
        return "Rزر اضافه الى دون التام";
      case UserPermition.show_A1:
        return "show_A1";
      case UserPermition.show_Ohda_management:
        return "موديول ادارة العهد";

      case UserPermition.can_get_data_of_purches:
        return "can_get_data_of_Purches";
      case UserPermition.Show_purches_module:
        return "اظهار موديول المشتريات";
      case UserPermition.can_print_in_purche:
        return "طباعة طلب الشراء";
      case UserPermition.sho_details_in_purchItem:
        return "عرض التفاصيل فى طلب الشراء";
      case UserPermition.can_make_new_purch_order:
        return "امكانية عمل طلب شراء جديد";
      case UserPermition.can_put_offer_in_purche:
        return "امكانية اظافة عروض فى طلب الشراء";
      case UserPermition.can_chose_from_offerPurches:
        return "امكانية الاختيار من العروض فى طلب الشراء";
      case UserPermition.can_approve_from_purchingManager:
        return "موافقة مدير المشتريات";
      case UserPermition.can_approve_from_financeManager:
        return "موافقة مدير الماليه";
      case UserPermition.can_approve_from_generalManager:
        return "موافقة المدير العام";

      case UserPermition.incert_in_final_prodcutStock_From_Excel:
        return "اضافه الى رصيد منتج تام من خلال ملف اكسل";
      case UserPermition.incert_notFinal_in_importedfinal_prodcut:
        return "اضافة شغل غير تام فى وارد تام المقصات";
      case UserPermition.show_H1:
        return "H1";
      case UserPermition.show_H2:
        return "H2";
      case UserPermition.show_H3:
        return "H3";
      case UserPermition.show_R1:
        return "R1";
      case UserPermition.show_R2:
        return "R2";
      case UserPermition.show_R3:
        return "R3";
      case UserPermition.show_Reports_Comparison_Of_consumedAndResults:
        return "عرض تقرير مقارنة الانتاج بالمصروف";
      case UserPermition.show_Chemical_category:
        return "تكويد اصناف فى الكيماويات";
      case UserPermition.can_get_data_of_chemical_category:
        return "can_get_data_of_chemical_category";
      case UserPermition.can_get_data_of_chemicals:
        return "can_get_data_of_chemicals";
      case UserPermition.show_add_new_category:
        return "عرض تسجيل صنف جديد";
      case UserPermition.show_setting_in_out_order:
        return "عرض الاعدادات فى صرف منتج تام";
      case UserPermition.show_Reports_H:
        return "عرض تقرير  المقصات الراسى";
      case UserPermition.show_Reports_R:
        return "عرض تقرير المقصات الدائرى";
      case UserPermition.show_Reports_details_of_sizes_of_block_stock:
        return "عرض تقرير  تفاصيل مقاسات البلوكات";
      case UserPermition.show_Reports_every_serial:
        return "عرض تقرير صبات البلوكات";
      case UserPermition.allow_edit_in_details_blocks:
        return "امكانية التعديل فى تفاصيل البلوكات";
      case UserPermition.show_cusotmer_name_in_cutting_order:
        return "عرض اسم العميل فى اوامر التشغيل";
      case UserPermition.show_search_in_customers:
        return "عرض البحث فى العملاء";
      case UserPermition.show_date_in_invoices:
        return " التاريخ فى ازون التحميل";
      case UserPermition.delete_in_finalprodcut_details:
        return "المسح فى تفاصيل تام الصنع";
      case UserPermition.show_all:
        return "show_all";
      case UserPermition.show_block_incetion:
        return "اضافه الى البلوكات";
      case UserPermition.blocks_OUT:
        return "صرف بلوكات";
      case UserPermition.show_cutting_orders:
        return "اوامر التشغيل";
      case UserPermition.show_finalProdcut_stock:
        return "رصيد منتح تام";
      case UserPermition.show_finalprodcut_importedFormcuttingUint:
        return "وارد تام المقصات";
      case UserPermition.show_finalprodcut_invoice:
        return "اذون صرف منتج تام";
      case UserPermition.show_finalprodcut_invoicemaking:
        return "صرف منتج تام";
      case UserPermition.show_customers:
        return "العملاء";
      case UserPermition.show_massaging:
        return "المراسله والطلبات";
      case UserPermition.show_users_actions:
        return "show_users_actions";
      case UserPermition.show_scissors:
        return "المقصات";
      case UserPermition.show_Reports_finalprodcut:
        return "تقارير منتج تام";
      case UserPermition.show_Reports_final_prodcutscisors:
        return "تقارير منتج تام لكل مقص";
      case UserPermition.show_Reports_totals_of_blocks:
        return "تقارير اجماليات البلوكات";
      case UserPermition.show_Reports_consume_boock:
        return "تقارير صرف بلوكات";
      case UserPermition.show_Reports_details_of_block_stock:
        return "تفاصيل مخزن البلوكات";
      case UserPermition.show_Reports_details_of_finalProdcut_stock:
        return "تفاصيل مخزن منتج تام";
      case UserPermition.incert_in_finalProdcut_imorted:
        return "امكانيه الاضافه الى وارد تام المقصات";
      case UserPermition.incert_in_block_stock:
        return "امكانيه الاضافه الى مخزن البلوك";

      case UserPermition.incert_in_final_prodcutStock:
        return "امكانيه الاضافه الى مخزن المنتج التام";
      case UserPermition.incert_in_cutting_order:
        return "الاضافه الى اوامر التشغيل";
      case UserPermition.incert_in_customers:
        return "الاضافه الى العملاء";

      case UserPermition.delete_in_cutting_order:
        return "المسح او الاغلاق فى اوامر التشغيل";
      case UserPermition.delete_in_consume_block:
        return "المسح فى صرف بلوكات";
      case UserPermition.show_date_in_block_out_of_stock:
        return "التاريخ فى صرف البلوكات";
      case UserPermition.allow_edit_in_details_finalProdcut:
        return "التعديل فى تفاصيل منتج تام";
      case UserPermition.show_date_in_finalProduct_imported:
        return "التاريخ فى  وارد تام المقصات";
      case UserPermition.show_date_in_block_stock:
        return "التاريخ فى رصيد البلوكات";
      case UserPermition.can_print_in_cutting_order:
        return "امكانية الطباعه فى اوامر التشغيل";
      case UserPermition.can_close_in_cutting_order:
        return "امكانية الاغلاق فى اوامر التشغيل";
      case UserPermition.can_aprove_from_controll:
        return "امكانية الموافقه من جهة الكنترل";
      case UserPermition.can_aprove_from_quality:
        return "امكانية الموافقه من جهة الجوده";
      case UserPermition.can_aprove_from_recive_from_final_prodcut:
        return "امكانية الاستلام من جهة مخزن تام";
      case UserPermition.can_aprove_from_calculation:
        return "امكانية الموافقه من جهة الحسابات";
      case UserPermition.delete_in_imported_finalprodcut:
        return "امكانية المسح فى وارد تام المقصات";
      case UserPermition.incert_unregular_in_importedfinal_prodcut:
        return "اضافة مقاسات شاذه فى وارد تام المقصات";
      case UserPermition.show_not_final_stock:
        return "مخزن دون التام";
      case UserPermition.not_working:
        return "اخرى";
      case UserPermition.can_get_data_of_blocks:
        return "can_get_data_of_blocks";
      case UserPermition.can_get_data_of_final_prodcut:
        return "can_get_data_of_final_prodcut";
      case UserPermition.can_get_data_of_invoice:
        return "can_get_data_of_invoice";
      case UserPermition.can_get_data_of_customers:
        return "can_get_data_of_customers";
      case UserPermition.can_get_data_of_orders:
        return "can_get_data_of_orders";
      case UserPermition.can_get_data_of_fractions:
        return "can_get_data_of_fractions";
      case UserPermition.can_get_data_of_notfinals:
        return "can_get_data_of_notfinals";
      case UserPermition.show_chemicals_model:
        return "موديول  الكيماويات";
      case UserPermition.can_edit_saba:
        return "تعديل الصبه";
    }
  }
}
