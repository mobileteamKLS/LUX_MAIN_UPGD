import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:luxair/datastructure/vehicletoken.dart';
import 'package:luxair/widgets/customdialogue.dart';
import 'package:luxair/widgets/headerclipper.dart';
import 'package:luxair/widgets/headers.dart';

import '../constants.dart';
import '../global.dart';
import '../language/appLocalizations.dart';
import '../language/model/lang_model.dart';

class CheckInYard extends StatefulWidget {
  CheckInYard({Key? key}) : super(key: key);

  @override
  State<CheckInYard> createState() => _CheckInYardState();
}

class _CheckInYardState extends State<CheckInYard> {
  bool isSearched = false,
      isLoading = false,
      isValidTextBoxes = true,
      isSaving = false;
  String errMsgText = "";

  TextEditingController txtVTNO = new TextEditingController();
  TextEditingController txtVehicleNo = new TextEditingController();
  bool useMobileLayout = false;
  List<WalInTokenDetails> walkInTokensList = [];

  @override
  Widget build(BuildContext context) {

    AppLocalizations? localizations = AppLocalizations.of(context);
    LangModel? localizeLangModel = localizations!.localizeLangModel;

    var smallestDimension = MediaQuery.of(context).size.shortestSide;
    useMobileLayout = smallestDimension < 600;
    print("useMobileLayout");

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderClipperWave(
              color1: Color(0xFF3383CD),
              color2: Color(0xFF11249F),
              headerText: "${localizeLangModel!.easy} ${localizeLangModel.yard} ${localizeLangModel.checkIn}"),
          Expanded(
            child: Padding(
              padding: useMobileLayout
                  ? const EdgeInsets.only(left: 10.0, top: 8.0, right: 0.0)
                  : const EdgeInsets.only(left: 15.0, top: 20.0, right: 8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text("Enter number to search",
                    //     style: iPadGroupHeaderFontStyle),
                    // SizedBox(height: useMobileLayout ? 10 : 18),

                    useMobileLayout
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${localizeLangModel.search} by ${localizeLangModel.vehicleNo}",
                                style: mobileTextLabelFontStyle,
                              ),
                              //  SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(" ${localizeLangModel.oR} ", style: mobileHeaderFontStyle),
                                  //     SizedBox(width: 10),
                                  Text("${localizeLangModel.vehicle} ${localizeLangModel.tokenNo}",
                                      style: mobileTextLabelFontStyle),
                                ],
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Text(
                                "${localizeLangModel.search} by ${localizeLangModel.vehicleNo}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: useMobileLayout ? 10 : 18),
                              Text(
                                "${localizeLangModel.oR}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.normal,
                                  color: Color(0xFF11249F),
                                ),
                              ),
                              SizedBox(width: useMobileLayout ? 10 : 18),
                              Text(
                                "${localizeLangModel.vehicle} ${localizeLangModel.tokenNo}",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),

                    SizedBox(height: useMobileLayout ? 10 : 18),
                    useMobileLayout
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 48,
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: isValidTextBoxes
                                            ? Colors.grey.withOpacity(0.5)
                                            : Colors.red, //.withOpacity(0.1),
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    // margin: EdgeInsets.all(12),
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 8),
                                          child: Icon(
                                            Icons.search,
                                            color: Colors.grey,
                                            size: 28,
                                          ),
                                        ),
                                        new Expanded(
                                          child: TextField(
                                              keyboardType: TextInputType.text,
                                              controller: txtVehicleNo,
                                              textCapitalization:
                                                  TextCapitalization.characters,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "${localizeLangModel.pleaseEnter} ${localizeLangModel.vehicleNo}",
                                                hintStyle: TextStyle(
                                                    color: Colors.grey),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 8),
                                                isDense: true,
                                              ),
                                              style: mobileTextFontStyle),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "${localizeLangModel.oR}",
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              22, //18,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xFF11249F),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //SizedBox(height: 15),

                              SizedBox(height: 10),
                              Container(
                                height: 48,
                                width: MediaQuery.of(context).size.width / 1.2,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isValidTextBoxes
                                        ? Colors.grey.withOpacity(0.5)
                                        : Colors.red.withOpacity(0.5),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                // margin: EdgeInsets.all(12),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                        size: 28,
                                      ),
                                    ),
                                    new Expanded(
                                      child: TextField(
                                          keyboardType: TextInputType.text,
                                          controller: txtVTNO,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "${localizeLangModel.pleaseEnter} ${localizeLangModel.vehicle} ${localizeLangModel.tokenNo}",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 8, horizontal: 8),
                                            isDense: true,
                                          ),
                                          style: mobileTextFontStyle),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isValidTextBoxes
                                        ? Colors.grey.withOpacity(0.5)
                                        : Colors.red, //.withOpacity(0.10),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                // margin: EdgeInsets.all(12),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                        size: 32,
                                      ),
                                    ),
                                    new Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        controller: txtVehicleNo,
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        readOnly: isSaving ? true : false,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "${localizeLangModel.pleaseEnter} ${localizeLangModel.vehicleNo}",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          isDense: true,
                                        ),
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          color: Colors.black,
                                        ),
                                        onChanged: (value) {
                                          print(value.toString());
                                          isValidTextBoxes = true;
                                          if (txtVTNO.text.isNotEmpty)
                                            txtVTNO.text = "";
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: 20),
                              Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${localizeLangModel.oR}",
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF11249F),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 20),
                              Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: isValidTextBoxes
                                        ? Colors.grey.withOpacity(0.5)
                                        : Colors.red, //.withOpacity(0.5),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                // margin: EdgeInsets.all(12),
                                child: Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(left: 8),
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                        size: 32,
                                      ),
                                    ),
                                    new Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        controller: txtVTNO,
                                        textCapitalization:
                                            TextCapitalization.characters,
                                        readOnly: isSaving ? true : false,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "${localizeLangModel.pleaseEnter} ${localizeLangModel.vehicle} ${localizeLangModel.tokenNo}",
                                          hintStyle:
                                              TextStyle(color: Colors.grey),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 8),
                                          isDense: true,
                                        ),
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          color: Colors.black,
                                        ),
                                        onChanged: (value) {
                                          print(value.toString());
                                          isValidTextBoxes = true;
                                          if (txtVehicleNo.text.isNotEmpty)
                                            txtVehicleNo.text = "";
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),

                    SizedBox(height: useMobileLayout ? 10 : 18),
                    // SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (txtVTNO.text.isEmpty &&
                                txtVehicleNo.text.isEmpty) {
                              setState(() {
                                isValidTextBoxes = false;
                              });
                            } else {
                              setState(() {
                                isSearched = true;
                              });
                              if (txtVTNO.text.trim() == "")
                                getTokenDetailsByVehicleNo();
                              else
                                getTokenDetailsByVTNO(1);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)), //
                            padding: const EdgeInsets.all(0.0),
                          ),
                          child: Container(
                            height: useMobileLayout ? 48 : 70,
                            width: useMobileLayout
                                ? MediaQuery.of(context).size.width / 3.5
                                : MediaQuery.of(context).size.width / 5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(0xFF1220BC),
                                  Color(0xFF3540E8),
                                ],
                              ),
                            ),
                            child: Padding(
                              padding: useMobileLayout
                                  ? const EdgeInsets.only(top: 8.0, bottom: 8.0)
                                  : const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '${localizeLangModel.search}',
                                  style: TextStyle(
                                      fontSize: useMobileLayout
                                          ? MediaQuery.of(context).size.width /
                                              22
                                          : 24,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),

                          //Text('CONTAINED BUTTON'),
                        ),
                        SizedBox(width: 15),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isSearched = false;
                              txtVTNO.text = "";
                              txtVehicleNo.text = "";
                              walkInTokensList = [];
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)), //
                            padding: const EdgeInsets.all(0.0),
                          ),

                          child: Container(
                            height: useMobileLayout ? 48 : 70,
                            width: useMobileLayout
                                ? MediaQuery.of(context).size.width / 3.5
                                : MediaQuery.of(context).size.width / 5.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: useMobileLayout
                                  ? const EdgeInsets.only(top: 8.0, bottom: 8.0)
                                  : const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '${localizeLangModel.clear}',
                                  style: TextStyle(
                                      fontSize: useMobileLayout
                                          ? MediaQuery.of(context).size.width /
                                              22
                                          : 24,
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xFF1220BC)),
                                ),
                              ),
                            ),
                          ),
                          //Text('CONTAINED BUTTON'),
                        ),
                      ],
                    ),

                    isLoading
                        ? Column(
                            children: [
                              Center(
                                  child: Container(
                                      height: 100,
                                      width: 100,
                                      child: CircularProgressIndicator())),
                            ],
                          )
                        : Column(
                            children: [
                              useMobileLayout
                                  ? SizedBox(height: 15)
                                  : SizedBox(height: 30),
                              if (isSearched && walkInTokensList.length > 0)
                                Container(
                                  height: 1,
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  color: Color(0xFF0461AA),
                                ),
                              if (isSearched) SizedBox(height: 10),
                              if (isSearched && walkInTokensList.length > 0)
                                Text(
                                    "${localizeLangModel.confirm} ${localizeLangModel.your} ${localizeLangModel.slot} ${localizeLangModel.and} ${localizeLangModel.submit} ${localizeLangModel.For} ${localizeLangModel.yard} ${localizeLangModel.checkIn}",
                                    style: useMobileLayout
                                        ? mobileGroupHeaderFontStyle
                                        : iPadGroupHeaderFontStyle),
                              if (isSearched) SizedBox(height: 10),
                              if (isSearched)
                                SizedBox(
                                  width: useMobileLayout
                                      ? MediaQuery.of(context).size.width / 1.05
                                      : MediaQuery.of(context).size.width /
                                          1.05,
                                  child: useMobileLayout
                                      ? Card(
                                          color: Colors.yellow.shade100,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0,
                                                top: 8.0,
                                                bottom: 8.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                      child: Text('${localizeLangModel.vehicleNo}',
                                                          style:
                                                              mobileHeaderFontStyle),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2,
                                                      child: Text('TN34Y-82223',
                                                          style:
                                                              mobileYellowTextFontStyleBold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                      child: Text('${localizeLangModel.mode}',
                                                          style:
                                                              mobileHeaderFontStyle),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2,
                                                      child: Text('${localizeLangModel.exports}',
                                                          style:
                                                              mobileYellowTextFontStyleBold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                      child: Text('${localizeLangModel.driverName}',
                                                          style:
                                                              mobileHeaderFontStyle),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2,
                                                      child: Text(
                                                          'Johnathan Stark',
                                                          style:
                                                              mobileYellowTextFontStyleBold),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                      child: Text('${localizeLangModel.timeSlot}',
                                                          style:
                                                              mobileHeaderFontStyle),
                                                    ),
                                                    SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2,
                                                      child: Text(
                                                          '02-JUL-2022 16:00-17:00',
                                                          style:
                                                              mobileYellowTextFontStyleBold),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            for (WalInTokenDetails wtkn
                                                in walkInTokensList)
                                              Card(
                                                child: Column(
                                                  children: [
                                                    SizedBox(height: 8),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: 56,
                                                          child: Container(
                                                            height: 40,
                                                            color: Colors.yellow
                                                                .shade300,
                                                            child: Center(
                                                              child: Text(' ',
                                                                  style:
                                                                      iPadYellowTextFontStyleNormal),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                          child: Container(
                                                            height: 40,
                                                            color: Colors.yellow
                                                                .shade300,
                                                            child: Center(
                                                              child: Text(
                                                                  '${localizeLangModel.vehicleNo}',
                                                                  style:
                                                                      iPadYellowTextFontStyleNormal),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                          child: Container(
                                                            height: 40,
                                                            color: Colors.yellow
                                                                .shade300,
                                                            child: Center(
                                                              child: Text(
                                                                  '${localizeLangModel.driverName}',
                                                                  style:
                                                                      iPadYellowTextFontStyleNormal),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                          child: Container(
                                                            height: 40,
                                                            color: Colors.yellow
                                                                .shade300,
                                                            child: Center(
                                                              child: Text(
                                                                  '${localizeLangModel.mode}',
                                                                  style:
                                                                      iPadYellowTextFontStyleNormal),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                          child: Container(
                                                            height: 40,
                                                            color: Colors.yellow
                                                                .shade300,
                                                            child: Center(
                                                              child: Text(
                                                                  '${localizeLangModel.timeSlot}',
                                                                  style:
                                                                      iPadYellowTextFontStyleNormal),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                          width: 56,
                                                          child: Container(
                                                            height: 64,
                                                            color: Colors.yellow
                                                                .shade100,
                                                            child: Center(
                                                              child: Checkbox(
                                                                value: wtkn
                                                                    .isChecked,
                                                                onChanged:
                                                                    (newValue) {
                                                                  if (isSaving)
                                                                    return;
                                                                  setState(() {
                                                                    print(newValue
                                                                        .toString());
                                                                    if (newValue ==
                                                                        true)
                                                                      wtkn.isChecked =
                                                                          true;
                                                                    else
                                                                      wtkn.isChecked =
                                                                          false;
                                                                  });
                                                                },
                                                              ),

                                                              // Text(' ',
                                                              //     style:
                                                              //         iPadYellowTextFontStyleNormal),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                          child: Container(
                                                            height: 64,
                                                            color: Colors.yellow
                                                                .shade100,
                                                            child: Center(
                                                              child: Text(
                                                                  wtkn.VehicleRegNo
                                                                      .toUpperCase(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      iPadYellowTextFontStyleBold),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                          child: Container(
                                                            height: 64,
                                                            color: Colors.yellow
                                                                .shade100,
                                                            child: Center(
                                                              child: Text(
                                                                  wtkn.DriverName
                                                                      .toUpperCase(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      iPadYellowTextFontStyleBold),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              5,
                                                          child: Container(
                                                            height: 64,
                                                            color: Colors.yellow
                                                                .shade100,
                                                            child: Center(
                                                              child: Text(
                                                                  wtkn.Mode
                                                                      .toUpperCase(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      iPadYellowTextFontStyleBold),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              4,
                                                          child: Container(
                                                            height: 64,
                                                            color: Colors.yellow
                                                                .shade100,
                                                            child: Center(
                                                              child: Text(
                                                                  wtkn.SlotDate
                                                                      .toUpperCase(),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      iPadYellowTextFontStyleBold),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    // SizedBox(height: 10),
                                                    // Row(
                                                    //   mainAxisAlignment:
                                                    //       MainAxisAlignment.spaceEvenly,
                                                    //   crossAxisAlignment:
                                                    //       CrossAxisAlignment.start,
                                                    //   children: [
                                                    //     Column(
                                                    //       children: [
                                                    //         SizedBox(
                                                    //           width: MediaQuery.of(context)
                                                    //                   .size
                                                    //                   .width /
                                                    //               1.8,
                                                    //           child: Container(
                                                    //             height: 50,
                                                    //             color:
                                                    //                 Colors.yellow.shade300,
                                                    //             child: Center(
                                                    //               child: Text('Time Slot',
                                                    //                   style:
                                                    //                       iPadYellowTextFontStyleNormal),
                                                    //             ),
                                                    //           ),
                                                    //         ),
                                                    //         SizedBox(
                                                    //           width: MediaQuery.of(context)
                                                    //                   .size
                                                    //                   .width /
                                                    //               1.8,
                                                    //           child: Container(
                                                    //             height: 50,
                                                    //             color:
                                                    //                 Colors.yellow.shade100,
                                                    //             child: Center(
                                                    //               child: Text(
                                                    //                   '02-JUL-2022 16:00-17:00',
                                                    //                   style:
                                                    //                       iPadYellowTextFontStyleBold),
                                                    //             ),
                                                    //           ),
                                                    //         ),
                                                    //       ],
                                                    //     ),

                                                    //     // SizedBox(
                                                    //     //   width:
                                                    //     //       MediaQuery.of(context).size.width / 4,
                                                    //     //   child: Container(
                                                    //     //     height: 50,
                                                    //     //     color: Colors.yellow.shade300,
                                                    //     //     child: Center(
                                                    //     //       child: Text(
                                                    //     //         'HAWB No.',
                                                    //     //         style: TextStyle(
                                                    //     //             fontSize: 18,
                                                    //     //             fontWeight: FontWeight.bold,
                                                    //     //             color: Colors.black),
                                                    //     //       ),
                                                    //     //     ),
                                                    //     //   ),
                                                    //     // ),
                                                    //   ],
                                                    // ),

                                                    SizedBox(height: 8),
                                                  ],
                                                ),
                                              ),
                                            useMobileLayout
                                                ? SizedBox(height: 10)
                                                : SizedBox(height: 16),
                                            if (isSearched &&
                                                walkInTokensList.length > 0)
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
                                                    child: Container(
                                                      height: 100,
                                                      color: Colors.white,
                                                      child: ElevatedButton(
                                                        onPressed: () async {
                                                          if (isSaving) return;

                                                          List<String>
                                                              checkInSlotsList =
                                                              [];
                                                          for (WalInTokenDetails wtd
                                                              in walkInTokensList) {
                                                            if (wtd.isChecked)
                                                              checkInSlotsList
                                                                  .add(wtd
                                                                      .TokenNo);
                                                          }
                                                          if (checkInSlotsList
                                                              .isEmpty) {
                                                            showDialog(
                                                              context: context,
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  customAlertMessageDialog(
                                                                      title:
                                                                          "${localizeLangModel.no} ${localizeLangModel.record} ${localizeLangModel.selected}",
                                                                      description:
                                                                          "${localizeLangModel.selectAtleastOneRecordToPerformYardCheckIn}",
                                                                      buttonText:
                                                                          "${localizeLangModel.ok}",
                                                                      imagepath:
                                                                          'assets/images/warn.gif',
                                                                      isMobile:
                                                                          useMobileLayout),
                                                            );
                                                          } else {
                                                            var selectedVT =
                                                                json.encode(
                                                                    checkInSlotsList);
                                                            selectedVT =
                                                                selectedVT
                                                                    .toString()
                                                                    .replaceAll(
                                                                        "[",
                                                                        "");
                                                            selectedVT =
                                                                selectedVT
                                                                    .toString()
                                                                    .replaceAll(
                                                                        "]",
                                                                        "");

                                                            var abc =
                                                                await performYardCheckIn(
                                                                    checkInSlotsList);

                                                            if (abc == false) {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext context) => customAlertMessageDialog(
                                                                    title: errMsgText ==
                                                                            ""
                                                                        ? "${localizeLangModel.errorOccured}"
                                                                        : "${localizeLangModel.yardCheckIn} ${localizeLangModel.failed}",
                                                                    description: errMsgText ==
                                                                            ""
                                                                        ? "${localizeLangModel.errorOccuredWhilePerformingYardCheckIn}, ${localizeLangModel.tryAfterSometimeValidation}"
                                                                        : errMsgText,
                                                                    buttonText:
                                                                        "${localizeLangModel.ok}",
                                                                    imagepath:
                                                                        'assets/images/warn.gif',
                                                                    isMobile:
                                                                        useMobileLayout),
                                                              );
                                                            } else {
                                                              var dlgstatus =
                                                                  await showDialog(
                                                                context:
                                                                    context,
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    CustomDialog(
                                                                  title:
                                                                      '${localizeLangModel.yardCheckIn} ${localizeLangModel.success}',
                                                                  description:
                                                                      "${localizeLangModel.yardCheckInForVT}" +
                                                                          selectedVT +
                                                                          " ${localizeLangModel.hasBeenSentSuccessfully}",
                                                                  buttonText:
                                                                      "${localizeLangModel.ok}",
                                                                  imagepath:
                                                                      'assets/images/successchk.gif',
                                                                  isMobile:
                                                                      useMobileLayout,
                                                                ),
                                                              );
                                                              if (dlgstatus ==
                                                                  true) {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(
                                                                        true); // To close the form
                                                              }
                                                            }
                                                          }

                                                          // showDialog(
                                                          //   context: context,
                                                          //   builder: (BuildContext
                                                          //           context) =>
                                                          //       CustomDialog(
                                                          //     title:
                                                          //         "WIVT220627006",
                                                          //     description:
                                                          //         "Yard Check-in recorded successfully for VT# WIVT220627006. You will receive an SMS notification shortly \n\n Kindly proceed for Document Verification.",
                                                          //     buttonText: "Okay",
                                                          //     imagepath:
                                                          //         'assets/images/successchk.gif',
                                                          //     isMobile:
                                                          //         useMobileLayout,
                                                          //   ),
                                                          // );
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          elevation: 4.0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0)), //
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0.0),
                                                        ),
                                                        child: Container(
                                                          height: 100,
                                                          width: 250,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            gradient:
                                                                LinearGradient(
                                                              begin: Alignment
                                                                  .topRight,
                                                              end: Alignment
                                                                  .bottomLeft,
                                                              colors: [
                                                                isSaving
                                                                    ? Colors
                                                                        .grey
                                                                    : Color(
                                                                        0xFF1220BC),
                                                                isSaving
                                                                    ? Colors
                                                                        .grey
                                                                    : Color(
                                                                        0xFF3540E8),
                                                              ],
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 18.0,
                                                                    bottom:
                                                                        18.0),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                '${localizeLangModel.submit}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        24,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        //Text('CONTAINED BUTTON'),
                                                      ),
                                                    ),
                                                  ),
                                                  if (isSaving)
                                                    SizedBox(width: 20),
                                                  if (isSaving)
                                                    Center(
                                                        child: Container(
                                                            height: useMobileLayout
                                                                ? MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    13
                                                                : 90,
                                                            width: useMobileLayout
                                                                ? MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    13
                                                                : 90,
                                                            child:
                                                                CircularProgressIndicator()))
                                                ],
                                              ),
                                          ],
                                        ),
                                ),
                            ],
                          ),
                    if (isSearched)
                      if (useMobileLayout)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, right: 12.0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width / 2.5,
                              child: Container(
                                height: 50,
                                color: Colors.white,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // showSuccessMessage();

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          CustomDialog(
                                        title: "WIVT220627006",
                                        description:
                                            "${localizeLangModel.yardCheckIndonesuccessfully} ${localizeLangModel.For} VT# WIVT220627006. ${localizeLangModel.youWillReceiveSMSNotificationShortly}",
                                        buttonText: "${localizeLangModel.ok}",
                                        imagepath:
                                            'assets/images/successchk.gif',
                                        isMobile: useMobileLayout,
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 4.0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)), //
                                    padding: const EdgeInsets.all(0.0),
                                  ),
                                  child: Container(
                                    height: 70,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        colors: [
                                          Color(0xFF1220BC),
                                          Color(0xFF3540E8),
                                        ],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, bottom: 8.0),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Text('${localizeLangModel.submit}',
                                            style: buttonWhiteFontStyle),
                                      ),
                                    ),
                                  ),
                                  //Text('CONTAINED BUTTON'),
                                ),
                              ),
                            ),
                          ),
                        ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> performYardCheckIn(checkinList) async {
    //export 1 , import 2
    try {
      bool isValid = false;
      errMsgText = "";
      String responseTextUpdated = "";
      print(json.encode(checkinList));
      // if (isLoading) return;

      setState(() {
        isSaving = true;
      });

      var params = json.encode(checkinList);

      print(params);
      print(json.decode(params));

      var queryParams = {
        "TokenNos": json.decode(params),
      };

      await Global()
          .postData(
        Settings.SERVICES['PerformYardCheckIn'],
        queryParams,
      )
          .then((response) {
        print("data received ");
        print(json.decode(response.body)['d']);

        if (json.decode(response.body)['d'] == null) {
          isValid = true;
        } else {
          if (json.decode(response.body)['d'] == "null") {
            isValid = true;
          } else {
            var responseText = json.decode(response.body)['d'].toString();

            if (responseText.toLowerCase().contains("errormsg")) {
              responseTextUpdated =
                  responseText.toString().replaceAll("ErrorMSG", "");
              responseTextUpdated =
                  responseTextUpdated.toString().replaceAll(":", "");
              responseTextUpdated =
                  responseTextUpdated.toString().replaceAll("\"", "");
              responseTextUpdated =
                  responseTextUpdated.toString().replaceAll("{", "");
              responseTextUpdated =
                  responseTextUpdated.toString().replaceAll("}", "");
                  responseTextUpdated =
                  responseTextUpdated.toString().replaceAll("[", "");
                  responseTextUpdated =
                  responseTextUpdated.toString().replaceAll("]", "");
              print(responseTextUpdated.toString());
            }
            // print(responseText.toString().replaceAll("ErrorMSG", ""));
            // print(responseText.toString().replaceAll(":", ""));
            // print(responseText.toString().replaceAll("\"", ""));

            isValid = false;
          }
        }

        setState(() {
          isSaving = false;
          if (responseTextUpdated != "") errMsgText = responseTextUpdated;
        });
      }).catchError((onError) {
        setState(() {
          isSaving = false;
        });
        print(onError);
      });

      return isValid;
    } catch (Exc) {
      print(Exc);
      return false;
    }
  }

  getTokenDetailsByVTNO(modeType) async {
    //export 1 , import 2

    if (isLoading) return;

    walkInTokensList = [];

    setState(() {
      isLoading = true;
    });

    var queryParams = {
      "OperationType":
          txtVTNO.text.startsWith("I") ? "2" : "1", // modeType.toString(),
      "TokenNo": txtVTNO.text.trim(),
    };
    await Global()
        .postData(
      Settings.SERVICES['SearchByVTNO'],
      queryParams,
    )
        .then((response) {
      print("data received ");
      print(json.decode(response.body)['d']);

      var msg = json.decode(response.body)['d'];
      var resp = json.decode(msg).cast<Map<String, dynamic>>();

      setState(() {
        walkInTokensList = resp
            .map<WalInTokenDetails>((json) => WalInTokenDetails.fromJson(json))
            .toList();

        print(
            "length walkInTokensList = " + walkInTokensList.length.toString());
        isLoading = false;
      });
    }).catchError((onError) {
      setState(() {
        isLoading = false;
      });
      print(onError);
    });
  }

  getTokenDetailsByVehicleNo() async {
    //export 1 , import 2

    if (isLoading) return;

    walkInTokensList = [];

    setState(() {
      isLoading = true;
    });

    var queryParams = {
      "OperationType": "1",
      "VehicleNo": txtVehicleNo.text.trim(),
    };
    await Global()
        .postData(
      Settings.SERVICES['SearchByVehicleNO'],
      queryParams,
    )
        .then((response) {
      print("data received ");
      print(json.decode(response.body)['d']);

      var msg = json.decode(response.body)['d'];
      var resp = json.decode(msg).cast<Map<String, dynamic>>();

      setState(() {
        walkInTokensList = resp
            .map<WalInTokenDetails>((json) => WalInTokenDetails.fromJson(json))
            .toList();

        print(
            "length walkInTokensList = " + walkInTokensList.length.toString());
        isLoading = false;
      });
    }).catchError((onError) {
      setState(() {
        isLoading = false;
      });
      print(onError);
    });
  }
}
