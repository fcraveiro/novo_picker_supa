import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppColor {
  static ThemeData tipo1 =
      FlexColorScheme.light(scheme: FlexScheme.hippieBlue).toTheme;
  static ThemeData tipo2 =
      FlexColorScheme.light(scheme: FlexScheme.aquaBlue).toTheme;
  static ThemeData tipo3 =
      FlexColorScheme.light(scheme: FlexScheme.indigo).toTheme;
}

class TemasController extends ChangeNotifier {
  int _number = 1;
  int get number => _number;
  incNumber() {
    _number = _number + 1;
    notifyListeners();
  }
}


/*


          Consumer<TemasController>(
        
builder: (BuildContext context, TemasController value, Widget child) {
return AppColor.tipo2};

          (WidgetTester tester) async {},
        );),
  }


Provider.of<TemasController>(context, listen: false).incNumber();


  */