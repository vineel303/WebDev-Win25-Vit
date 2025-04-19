// THIS IS THE FINAL VERSION //

import 'package:flutter/material.dart';

///terminal///flutter pub add math_expressions
import 'package:math_expressions/math_expressions.dart';
//import 'package:flutter/services.dart';

///terminal///flutter pub add material_design_icons_flutter
///import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
///import 'package:calculator_suiren/Pages/Page0.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      ///remove const from MaterialApp, if changing things like theme, locale or navigation
      debugShowCheckedModeBanner: false,
      title: "Calculator Suiren",
      home: Homepage0(),
    );
  }
}

class Homepage0 extends StatefulWidget {
  const Homepage0({super.key});
  @override
  State<Homepage0> createState() => _Homepage0State();
}

class _Homepage0State extends State<Homepage0> {
  String _output0 = "0";
  late TextEditingController textEditingController;
  late final ShuntingYardParser shuntingYardParser = ShuntingYardParser();
  late final ContextModel contextModel = ContextModel();

  @override
  void initState() {
    textEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void _calculate0() {
    setState(() {
      String userInput_asString = textEditingController.text;
      double? userInput_asDouble = double.tryParse(userInput_asString);
      if (userInput_asString == "" || userInput_asDouble == 0) {
        _output0 = "0";
      } else {
        try {
          Expression expression = shuntingYardParser.parse(userInput_asString);
          double output0_asDouble = expression.evaluate(
            EvaluationType.REAL,
            contextModel,
          );
          String output0_asString = output0_asDouble.toStringAsFixed(9);
          _output0 = output0_asString
              .replaceAll(RegExp(r'0*$'), "")
              .replaceAll(RegExp(r'\.$'), "");
        } catch (e) {
          _output0 = "Error";
        }
      }
    });
  }

  void _calculate0_withStringArgument(String s) {
    _calculate0();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 240, 255, 0.97),
      appBar: AppBar(
        title: const Text(
          "Calculator Suiren",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: const Color.fromRGBO(191, 63, 255, 1),
        elevation: 1,

        ///leading: Icon(), ///functional icon on the left
        ///actions: [Icon(), Icon()], ///functional iconS on the right
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //
            //WIDGET 1
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                _output0,
                textDirection: TextDirection.ltr,
                style: const TextStyle(
                  color: Color.fromRGBO(191, 63, 255, 1),
                  fontSize: 48,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            //
            //WIDGET 2
            Container(
              ///margin: const EdgeInsets.all(0),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: TextField(
                controller: textEditingController,
                onSubmitted: _calculate0_withStringArgument,
                //
                ///keep this disabled///inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9().+\-*/]')),],
                keyboardType: TextInputType.visiblePassword,
                //
                style: const TextStyle(
                  color: Color.fromRGBO(191, 63, 255, 1),
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  hintText: "Expression",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(191, 63, 255, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(
                    Icons.sunny,
                    color: Color.fromRGBO(191, 63, 255, 1),
                    size: 24,
                  ),
                  /*
                  prefix: Icon(
                    MdiIcons.weatherFog,
                    color: Color.fromRGBO(191, 63, 255, 1),
                    size: 24,
                  ),
                  */
                  filled: true,
                  fillColor: Color.fromRGBO(63, 255, 191, 0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    borderSide: BorderSide(
                      color: Color.fromRGBO(63, 255, 191, 0.8),
                      style: BorderStyle.solid,
                      width: 2,
                      strokeAlign: BorderSide.strokeAlignInside,
                    ),
                  ),
                ),
              ),
            ),

            ///const SizedBox(height: 8,), ///to add heightOnly padding % this uses fewer resources
            //
            //WIDGET 3
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: TextButton(
                onPressed: _calculate0,
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Color.fromRGBO(255, 63, 191, 0.2),
                  ),
                  /*
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                  */
                  minimumSize: WidgetStatePropertyAll(
                    Size(double.infinity, 48),
                  ),
                ),
                child: const Text(
                  "Calculate",
                  style: TextStyle(
                    color: Color.fromRGBO(191, 63, 255, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
