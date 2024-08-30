import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

TextStyle getWhiteText(BuildContext context) {
  return TextStyle(
    fontSize: ResponsiveValue(
      context,
      conditionalValues: [
        Condition.equals(name: MOBILE, value: 12.0),
        Condition.equals(name: TABLET, value: 14.0),
        Condition.equals(name: DESKTOP, value: 16.0),
        Condition.largerThan(name: DESKTOP, value: 18.0),
      ],
      defaultValue: 12.0,
    ).value,
    color: Colors.white,
  );
}

TextStyle getBlackText(BuildContext context) {
  return TextStyle(
    fontSize: ResponsiveValue(
      context,
      conditionalValues: [
        Condition.equals(name: MOBILE, value: 12.0),
        Condition.equals(name: TABLET, value: 14.0),
        Condition.equals(name: DESKTOP, value: 16.0),
        Condition.largerThan(name: DESKTOP, value: 18.0),
      ],
      defaultValue: 12.0,
    ).value,
    color: Colors.black,
  );
}

TextStyle getBlueGreyText(BuildContext context) {
  return TextStyle(
    fontSize: ResponsiveValue(
      context,
      conditionalValues: [
        Condition.equals(name: MOBILE, value: 12.0),
        Condition.equals(name: TABLET, value: 14.0),
        Condition.equals(name: DESKTOP, value: 16.0),
        Condition.largerThan(name: DESKTOP, value: 18.0),
      ],
      defaultValue: 12.0,
    ).value,
    color: Colors.blueGrey,
  );
}

TextStyle getWhiteTitle(BuildContext context) {
  return TextStyle(
    fontSize: ResponsiveValue(
      context,
      conditionalValues: [
        Condition.equals(name: MOBILE, value: 14.0),
        Condition.equals(name: TABLET, value: 16.0),
        Condition.equals(name: DESKTOP, value: 18.0),
        Condition.largerThan(name: DESKTOP, value: 20.0),
      ],
      defaultValue: 14.0,
    ).value,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );
}

TextStyle getBlackTitle(BuildContext context) {
  return TextStyle(
    fontSize: ResponsiveValue(
      context,
      conditionalValues: [
        Condition.equals(name: MOBILE, value: 14.0),
        Condition.equals(name: TABLET, value: 16.0),
        Condition.equals(name: DESKTOP, value: 18.0),
        Condition.largerThan(name: DESKTOP, value: 20.0),
      ],
      defaultValue: 14.0,
    ).value,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
}

TextStyle getBlueGreyTitle(BuildContext context) {
  return TextStyle(
    fontSize: ResponsiveValue(
      context,
      conditionalValues: [
        Condition.equals(name: MOBILE, value: 14.0),
        Condition.equals(name: TABLET, value: 16.0),
        Condition.equals(name: DESKTOP, value: 18.0),
        Condition.largerThan(name: DESKTOP, value: 20.0),
      ],
      defaultValue: 14.0,
    ).value,
    color: Colors.blueGrey,
    fontWeight: FontWeight.bold,
  );
}
