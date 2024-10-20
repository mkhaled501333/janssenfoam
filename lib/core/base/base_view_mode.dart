import 'package:flutter/material.dart';

abstract class BaseViewModel {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool validate() => formKey.currentState!.validate();

  TextEditingController blocknumbercontroller = TextEditingController();
  TextEditingController search = TextEditingController();
  TextEditingController codecontroller = TextEditingController();
  TextEditingController colercontroller = TextEditingController();
  TextEditingController densitycontroller = TextEditingController();
  TextEditingController hightncontroller = TextEditingController();
  TextEditingController widthcontroller = TextEditingController();
  TextEditingController lenthcontroller = TextEditingController();
  TextEditingController typecontroller = TextEditingController();
  TextEditingController tiitlecontroller = TextEditingController();
  TextEditingController scissorcontroller = TextEditingController();
  TextEditingController companycontroller = TextEditingController();
  TextEditingController amountcontroller = TextEditingController();
  TextEditingController cuttingordernum = TextEditingController();
  TextEditingController wightcontroller = TextEditingController();
  TextEditingController carnumber = TextEditingController();
  TextEditingController invoiceNum = TextEditingController();
  TextEditingController driverName = TextEditingController();
  TextEditingController whoLoad = TextEditingController();
  TextEditingController cummingFrom = TextEditingController();
  TextEditingController outTo = TextEditingController();
  TextEditingController notes = TextEditingController();
  TextEditingController blockdesription = TextEditingController();
  TextEditingController customerName = TextEditingController();
  TextEditingController customerSerial = TextEditingController();
  TextEditingController orderSerial = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController N = TextEditingController();
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();

  TextEditingController unit = TextEditingController();
  TextEditingController item = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController administrationRequstTheOrder = TextEditingController();
  TextEditingController purcheOrderRequester = TextEditingController();

  clearfields() {
    customerName.clear();
    orderSerial.clear();
    customerName.clear();
    colercontroller.clear();
    densitycontroller.clear();
    amountcontroller.clear();
    typecontroller.clear();
    hightncontroller.clear();
    widthcontroller.clear();
    lenthcontroller.clear();
    scissorcontroller.clear();
    companycontroller.clear();
    amountcontroller.clear();
    cuttingordernum.clear();
    wightcontroller.clear();
    carnumber.clear();
    driverName.clear();
    whoLoad.clear();
    customerName.clear();
    customerSerial.clear();
    invoiceNum.clear();
    from.clear();
    to.clear();
  }
}
