// ignore_for_file: file_names, non_constant_identifier_names, empty_catches, avoid_function_literals_in_foreach_calls

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:janssenfoam/core/recources/enums.dart';
import 'package:janssenfoam/models/moderls.dart';

class PurchesController extends ChangeNotifier {
  getDataOfPurchesrr() {
    try {
      FirebaseDatabase.instance
          .ref("Purche")
          .orderByKey()
          .onValue
          .listen((event) {
        purchesOrders.clear();
        initalData.clear();
        if (event.snapshot.value != null) {
          Map<Object?, Object?> map =
              event.snapshot.value as Map<Object?, Object?>;
          for (var item in map.values.toList()) {
            initalData.add(PurcheOrder.fromJson(item.toString()));
          }
          purchesOrders.addAll(initalData);
        }

        notifyListeners();
      });
    } catch (e) {}
  }

  List<PurcheOrder> purchesOrders = [];
  List<PurcheOrder> initalData = [];

  Add_purche_item(PurcheOrder purcheOrder) async {
    for (var element in purcheOrder.items) {
      element.purcheOrder_Id = purcheOrder.Id;
    }
    try {
      FirebaseDatabase.instance
          .ref("Purche/${purcheOrder.Id}")
          .set(purcheOrder.toJson());
    } catch (e) {}
  }

  aprove_on_purchOrder_form_finance(PurcheOrder purcheOrder) async {
    purcheOrder.actions.add(PurcheAction.Purche_approved_Financem.add);
    try {
      FirebaseDatabase.instance
          .ref("Purche/${purcheOrder.Id}")
          .set(purcheOrder.toJson());
    } catch (e) {}
  }

  aprove_on_purchOrder_form_GeneralManager(PurcheOrder purcheOrder) async {
    purcheOrder.actions.add(PurcheAction.Purche_approved_generalm.add);
    try {
      FirebaseDatabase.instance
          .ref("Purche/${purcheOrder.Id}")
          .set(purcheOrder.toJson());
    } catch (e) {}
  }

  aprove_on_purchOrder_form_PurcheManager(PurcheOrder purcheOrder) async {
    purcheOrder.actions.add(PurcheAction.Purche_approved_PurcheM.add);
    try {
      FirebaseDatabase.instance
          .ref("Purche/${purcheOrder.Id}")
          .set(purcheOrder.toJson());
    } catch (e) {}
  }

  Add_purche_item_offer(PurcheItem p, PurcheItemOffers f) async {
    PurcheOrder purcheOrder =
        purchesOrders.firstWhere((element) => element.Id == p.purcheOrder_Id);
    PurcheItem l = purcheOrder.items.firstWhere((h) => h.item_Id == p.item_Id);
    l.offers.add(f);

    try {
      FirebaseDatabase.instance
          .ref("Purche/${purcheOrder.Id}")
          .set(purcheOrder.toJson());
    } catch (e) {}
  }

  chose_offer(PurcheItemOffers f) async {
    PurcheOrder purcheOrder =
        purchesOrders.firstWhere((element) => element.Id == f.purcheOrder_Id);

    PurcheItem l = purcheOrder.items.firstWhere((h) => h.item_Id == f.item_Id);

    PurcheItemOffers m = l.offers
        .firstWhere((r) => r.PurcheItemOffers_Id == f.PurcheItemOffers_Id);
    m.actions.add(PurcheAction.offer_chosen.add);

    try {
      FirebaseDatabase.instance
          .ref("Purche/${purcheOrder.Id}")
          .set(purcheOrder.toJson());
    } catch (e) {}
  }

  remove_offer(PurcheItemOffers f) async {
    PurcheOrder purcheOrder =
        purchesOrders.firstWhere((element) => element.Id == f.purcheOrder_Id);

    PurcheItem l = purcheOrder.items.firstWhere((h) => h.item_Id == f.item_Id);

    PurcheItemOffers m = l.offers
        .firstWhere((r) => r.PurcheItemOffers_Id == f.PurcheItemOffers_Id);
    m.actions.removeWhere((element) => element.action == "offer_chosen");

    try {
      FirebaseDatabase.instance
          .ref("Purche/${purcheOrder.Id}")
          .set(purcheOrder.toJson());
    } catch (e) {}
  }

  Refrech_UI() {
    notifyListeners();
  }
}
