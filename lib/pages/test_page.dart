import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => TestPageState();
}

class TestPageState extends State<TestPage> {
  String displayText = '';
  String inputText = '';
  String lastOperator = '';
  

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('MY CALCULATOR'),
    ),
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
            padding: EdgeInsets.all(16.0),
            color: Colors.white, // Set background color to white
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                displayText,
                style: TextStyle(
                  color: Colors.black, // Set text color to black
                  fontSize: 36.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.only(left: 8.0, right: 8.0),
            color: Colors.white, // Set background color to white
            child: Column(
              children: [
                buildButtonRow(['C', '<']),
                buildButtonRow(['7', '8', '9', '÷']),
                buildButtonRow(['4', '5', '6', '×']),
                buildButtonRow(['1', '2', '3', '-']),
                buildButtonRow(['0', '+']),
                buildButtonRow(['=']),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}


  Widget buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons
            .map((button) => buildCalculatorButton(button))
            .toList(),
      ),
    );
  }

Widget buildCalculatorButton(String text) {
  Color buttonColor = isNumeric(text) ? Color(0xFFFFCC80) : Colors.white;

  if (text == '=') {
    buttonColor = Colors.orange;
  }

  return Expanded(
    child: Container(
      margin: EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: () {
          onButtonPressed(text);
        },
        style: ElevatedButton.styleFrom(
          primary: buttonColor, // ให้สีของปุ่มเลข 0-9 เป็นสีส้ม
          onPrimary: Colors.black,
          textStyle: TextStyle(fontSize: 24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(0.0),
            ),
          ),
        ),
        child: text == '<'
            ? Icon(Icons.backspace)
            : Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                ),
              ),
      ),
    ),
  );
}


bool isNumeric(String value) {
  if (value == null) {
    return false;
  }
  return double.tryParse(value) != null;
}
void onButtonPressed(String buttonText) {
  setState(() {
    if (buttonText == 'C') {
      inputText = '0';
      displayText = '';
    } else if (buttonText == '<') {
      if (inputText.isNotEmpty) {
        inputText = inputText.substring(0, inputText.length - 1);
      }
      if (inputText.isEmpty) {
        inputText = '0';
      }
    } else {
      if (inputText == '0') {
        // If the input is currently '0', replace it with the new button pressed.
        inputText = buttonText;
      } else {
        // Otherwise, append the button pressed to the input.
        inputText += buttonText;
      }
    }

    updateDisplayText();
  });
}


  void updateDisplayText() {
    setState(() {
      displayText = inputText;
    });
  }
  
}


