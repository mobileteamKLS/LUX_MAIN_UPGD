import 'package:flutter/material.dart';
import 'package:luxair/widgets/headerclipper.dart';
import 'package:luxair/widgets/headers.dart';

import '../language/appLocalizations.dart';
import '../language/model/lang_model.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    AppLocalizations? localizations = AppLocalizations.of(context);
    LangModel? localizeLangModel = localizations!.localizeLangModel;

    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

              HeaderClipperWave(color1:Color(0xFF3383CD),
                    color2:Color(0xFF11249F),headerText:       "How can we help you ?"),

          
       
          ]),
    );
  }
}
