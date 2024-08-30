import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String getServerFailureMsg(BuildContext context){
  return AppLocalizations.of(context)!.serverFailureMsg;
}

String getEmptyCacheMsg(BuildContext context){
  return AppLocalizations.of(context)!.emptyCacheMsg;
}

String getOfflineMsg(BuildContext context){
  return AppLocalizations.of(context)!.offlineMsg;
}

String getWrongUserMsg(BuildContext context){
  return AppLocalizations.of(context)!.wrongUserMsg;
}


 String serverFailureMsg = "Please try again later.";
const String emptyCacheMsg = "No data yet";
const String offlineMsg = "Please check your internet connection";
const String wrongUserMsg = 'User not found, please check your email and password';