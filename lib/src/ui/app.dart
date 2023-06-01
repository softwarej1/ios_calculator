import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calcurator/src/components/black_button.dart';
import 'package:flutter_calcurator/src/components/gray_button.dart';

import 'package:flutter_calcurator/src/components/orange_button.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String previousNumber = '';
  String currentNumber = '';
  String selectedOperation = '';
  String result = '0';
  bool isButtonClicked = false;
  bool isButton1Clicked = false;
  bool isButton2Clicked = false;
  bool isButton3Clicked = false;
  bool isButton4Clicked = false;

  void _onButtonPressed(String buttonText) {
    setState(() {
      switch (buttonText) {
        case '÷':
        case 'x':
        case '-':
        case '+':
          if (previousNumber != '') {
            _calculateResult();
          } else {
            previousNumber = currentNumber;
          }
          currentNumber = '';
          selectedOperation = buttonText;
          break;
        case '+/-':
          currentNumber = convertStringToDouble(currentNumber) < 0
              ? currentNumber.replaceAll('-', '')
              : '-$currentNumber';
          result = currentNumber;
          break;
        case '%':
          currentNumber =
              (convertStringToDouble(currentNumber) / 100).toString();
          result = currentNumber;
          break;
        case '=':
          _calculateResult();
          previousNumber = '';
          selectedOperation = '';
          break;
        case 'AC':
          _resetCalculator();
          break;
        default:
          currentNumber = currentNumber + buttonText;
          result = currentNumber;
          break;
      }
    });
  }

  void _calculateResult() {
    double _previousNumber = convertStringToDouble(previousNumber);
    double _currentNumber = convertStringToDouble(previousNumber);

    switch (selectedOperation) {
      case '÷':
        _previousNumber = _previousNumber / _currentNumber;
        break;
      case 'x':
        _previousNumber = _previousNumber * _currentNumber;
        break;
      case '-':
        _previousNumber = _previousNumber - _currentNumber;
        break;
      case '+':
        _previousNumber = _previousNumber + _currentNumber;
        break;
      default:
        break;
    }

    currentNumber =
        (_previousNumber % 1 == 0 ? _previousNumber.toInt() : _previousNumber)
            .toString();
    result = currentNumber;
  }

  void _resetCalculator() {
    result = '0';
    previousNumber = '';
    currentNumber = '';
    selectedOperation = '';
  }

  double convertStringToDouble(String number) {
    return double.tryParse(number) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: 3,
                child: _result(),
              ),
              Expanded(
                flex: 7,
                child: _buttons(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _result() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Align(
        alignment: Alignment.bottomRight,
        child: SelectableText(
          result,
          style: const TextStyle(
              fontSize: 70, fontWeight: FontWeight.w300, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buttons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _firstRow(),
        _secondRow(),
        _thirdRow(),
        _fourthRow(),
        _fifthRow(),
      ],
    );
  }

  Widget _firstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GrayButton(
          onPressed: () {
            _onButtonPressed('AC');
          },
          child: const Text(
            'AC',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
        GrayButton(
          onPressed: () {
            _onButtonPressed('+/-');
          },
          child: const Text(
            '+/-',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
        GrayButton(
          onPressed: () {
            _onButtonPressed('%');
          },
          child: const Text(
            '%',
            style: TextStyle(fontSize: 30, color: Colors.black),
          ),
        ),
        OrangeButton(
          isClick: isButton1Clicked,
          icon: Icon(
            CupertinoIcons.divide,
            color: isButton1Clicked ? Colors.orange : Colors.white,
            size: 35,
          ),
          onPressed: () {
            isButton1Clicked = !isButton1Clicked;
            isButton2Clicked = false;
            isButton3Clicked = false;
            isButton4Clicked = false;

            _onButtonPressed('÷');
          },
          activeIcon: Icon(
            CupertinoIcons.divide,
            color: !isButton1Clicked ? Colors.white : Colors.orange,
            size: 35,
          ),
        ),
      ],
    );
  }

  Widget _secondRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BlackButton(
          onPressed: () {
            _onButtonPressed('7');
          },
          type: Type.ROUND,
          child: '7',
        ),
        BlackButton(
          onPressed: () {
            _onButtonPressed('8');
          },
          type: Type.ROUND,
          child: '8',
        ),
        BlackButton(
          onPressed: () {
            _onButtonPressed('9');
          },
          type: Type.ROUND,
          child: '9',
        ),
        OrangeButton(
          isClick: isButton2Clicked,
          icon: Icon(
            CupertinoIcons.multiply,
            color: isButton2Clicked ? Colors.orange : Colors.white,
            size: 35,
          ),
          onPressed: () {
            isButton2Clicked = !isButton1Clicked;
            isButton1Clicked = false;
            isButton3Clicked = false;
            isButton4Clicked = false;

            _onButtonPressed('x');
          },
          activeIcon: Icon(
            CupertinoIcons.multiply,
            color: !isButton2Clicked ? Colors.white : Colors.orange,
            size: 35,
          ),
        ),
      ],
    );
  }

  Widget _thirdRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BlackButton(
          onPressed: () {
            _onButtonPressed('4');
          },
          type: Type.ROUND,
          child: '4',
        ),
        BlackButton(
          onPressed: () {
            _onButtonPressed('5');
          },
          type: Type.ROUND,
          child: '5',
        ),
        BlackButton(
          onPressed: () {
            _onButtonPressed('6');
          },
          type: Type.ROUND,
          child: '6',
        ),
        OrangeButton(
          isClick: isButton3Clicked,
          icon: Icon(
            CupertinoIcons.minus,
            color: isButton3Clicked ? Colors.orange : Colors.white,
            size: 35,
          ),
          onPressed: () {
            isButton3Clicked = !isButton2Clicked;
            isButton1Clicked = false;
            isButton2Clicked = false;
            isButton4Clicked = false;

            _onButtonPressed('-');
          },
          activeIcon: Icon(
            CupertinoIcons.minus,
            color: !isButton3Clicked ? Colors.white : Colors.orange,
            size: 35,
          ),
        ),
      ],
    );
  }

  Widget _fourthRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BlackButton(
          onPressed: () {
            _onButtonPressed('1');
          },
          type: Type.ROUND,
          child: '1',
        ),
        BlackButton(
          onPressed: () {
            _onButtonPressed('2');
          },
          type: Type.ROUND,
          child: '2',
        ),
        BlackButton(
          onPressed: () {
            _onButtonPressed('3');
          },
          type: Type.ROUND,
          child: '3',
        ),
        OrangeButton(
          isClick: isButton4Clicked,
          icon: Icon(
            CupertinoIcons.add,
            color: isButton4Clicked ? Colors.orange : Colors.white,
            size: 35,
          ),
          onPressed: () {
            isButton4Clicked = !isButton4Clicked;
            isButton1Clicked = false;
            isButton2Clicked = false;
            isButton3Clicked = false;

            _onButtonPressed('+');
          },
          activeIcon: Icon(
            CupertinoIcons.add,
            color: !isButton4Clicked ? Colors.white : Colors.orange,
            size: 35,
          ),
        ),
      ],
    );
  }

  Widget _fifthRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        BlackButton(
          onPressed: () {
            _onButtonPressed('0');
          },
          type: Type.FLAT,
          child: '0',
        ),
        BlackButton(
          onPressed: () {
            _onButtonPressed('.');
          },
          type: Type.ROUND,
          child: '.',
        ),
        OrangeButton(
          isClick: isButtonClicked,
          icon: Icon(
            CupertinoIcons.equal,
            color: isButtonClicked ? Colors.orange : Colors.white,
            size: 35,
          ),
          onPressed: () {
            setState(() {
              isButtonClicked = true;
              isButton1Clicked = false;
              isButton2Clicked = false;
              isButton3Clicked = false;
              isButton4Clicked = false;
            });

            _onButtonPressed('=');

            Timer(const Duration(milliseconds: 200), () {
              setState(() {
                isButtonClicked = false;
              });
            });
          },
          activeIcon: Icon(
            CupertinoIcons.equal,
            color: !isButtonClicked ? Colors.white : Colors.orange,
            size: 35,
          ),
        ),
      ],
    );
  }
}
