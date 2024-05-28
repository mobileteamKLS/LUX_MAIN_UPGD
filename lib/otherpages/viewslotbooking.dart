import 'package:luxair/widgets/headerclipper.dart';
import 'package:flutter/material.dart';

import '../language/appLocalizations.dart';
import '../language/model/lang_model.dart';

class ViewBookedSlots extends StatefulWidget {
  const ViewBookedSlots({ Key? key }) : super(key: key);

  @override
  State<ViewBookedSlots> createState() => _ViewBookedSlotsState();
}

class _ViewBookedSlotsState extends State<ViewBookedSlots> {
  @override
  Widget build(BuildContext context) {

    AppLocalizations? localizations = AppLocalizations.of(context);
    LangModel? localizeLangModel = localizations!.localizeLangModel;

  return Scaffold(
      body: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderClipperWave(
                  color1: Color(0xFF3383CD),
                  color2: Color(0xFF11249F),
                  headerText: "${localizeLangModel!.viewBookedSlot}")
            ]),
      ),
    );
  }
}