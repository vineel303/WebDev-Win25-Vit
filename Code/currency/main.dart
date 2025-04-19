import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Currency Converter",
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
  String _output0 = "0 USD";
  String _output1 = "0 JPY";
  String _output2 = "0 Euro";
  late TextEditingController textEditingController;

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
        _output0 = "0 USD";
      } else {
        try {
          double result = userInput_asDouble! / 85.40;
          _output0 = "${result.toStringAsFixed(2)} USD";
        } catch (e) {
          _output0 = "Error";
        }
      }
    });
  }

  void _calculate1() {
    setState(() {
      String userInput_asString = textEditingController.text;
      double? userInput_asDouble = double.tryParse(userInput_asString);
      if (userInput_asString == "" || userInput_asDouble == 0) {
        _output1 = "0 JPY";
      } else {
        try {
          double result = userInput_asDouble! * 1.67;
          _output1 = "${result.toStringAsFixed(2)} JPY";
        } catch (e) {
          _output1 = "Error";
        }
      }
    });
  }

  void _calculate2() {
    setState(() {
      String userInput_asString = textEditingController.text;
      double? userInput_asDouble = double.tryParse(userInput_asString);
      if (userInput_asString == "" || userInput_asDouble == 0) {
        _output2 = "0 Euro";
      } else {
        try {
          double result = userInput_asDouble! / 97.11;
          _output2 = "${result.toStringAsFixed(2)} Euro";
        } catch (e) {
          _output2 = "Error";
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 240, 255, 0.97),
      appBar: AppBar(
        title: const Text(
          "Currency Converter",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: const Color.fromRGBO(191, 63, 255, 1),
        elevation: 1,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                _output1,
                textDirection: TextDirection.ltr,
                style: const TextStyle(
                  color: Color.fromRGBO(191, 63, 255, 1),
                  fontSize: 48,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                _output2,
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
                //onSubmitted: _calculate0_withStringArgument,
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
                  hintText: "INR",
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(191, 63, 255, 1),
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                  filled: true,
                  fillColor: Color.fromRGBO(63, 255, 191, 0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
              padding: const EdgeInsets.symmetric(
                horizontal: 650,
                vertical: 12,
              ),
              child: TextButton(
                onPressed: () {
                  _calculate0();
                  _calculate1();
                  _calculate2();
                },
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    Color.fromRGBO(255, 63, 191, 0.2),
                  ),
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  minimumSize: WidgetStatePropertyAll(
                    Size(double.infinity, 60),
                  ),
                ),
                child: const Text(
                  "Convert",
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
