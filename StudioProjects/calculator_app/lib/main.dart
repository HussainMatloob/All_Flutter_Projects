import 'package:calculator_app/Components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator ());
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  @override
  var userInput = '';
  var answer = '';

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children:
                      [
                        Text(userInput.toString(),
                          style: TextStyle(fontSize: 30, color: Colors.white),),
                        SizedBox(height: 16,),
                        Text(answer.toString(),
                          style: TextStyle(fontSize: 30, color: Colors.white),),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          MyButton(title: 'AC', onPressed: () {
                            userInput = '';
                            answer = '';
                            setState(() {

                            });
                          },),
                          MyButton(title: '+/-', onPressed: () {
                            userInput += "+/-";
                            setState(() {

                            });
                          },),
                          MyButton(title: '%', onPressed: () {
                            userInput += "%";
                            setState(() {

                            });
                          },),
                          MyButton(title: '/',
                            color: Colors.orange,
                            onPressed: () {
                              userInput += "/";
                              setState(() {

                              });
                            },),
                        ],
                      ),
                      Row(
                        children: [
                          MyButton(title: '7', onPressed: () {
                            userInput += "7";
                            setState(() {

                            });
                          },),
                          MyButton(title: '8', onPressed: () {
                            userInput += "8";
                            setState(() {

                            });
                          },),
                          MyButton(title: '9', onPressed: () {
                            userInput += "9";
                            setState(() {

                            });
                          },),
                          MyButton(title: 'x',
                            color: Colors.orange,
                            onPressed: () {
                              userInput += "*";
                              setState(() {

                              });
                            },),
                        ],
                      ),
                      Row(
                        children: [
                          MyButton(title: '4', onPressed: () {
                            userInput += "4";
                            setState(() {

                            });
                          },),
                          MyButton(title: '5', onPressed: () {
                            userInput += "5";
                            setState(() {

                            });
                          },),
                          MyButton(title: '6', onPressed: () {
                            userInput += "6";
                            setState(() {

                            });
                          },),
                          MyButton(title: '-',
                            color: Colors.orange,
                            onPressed: () {
                              userInput += "-";
                              setState(() {

                              });
                            },),
                        ],
                      ),
                      Row(
                        children: [
                          MyButton(title: '1', onPressed: () {
                            userInput += "1";
                            setState(() {

                            });
                          },),
                          MyButton(title: '2', onPressed: () {
                            userInput += "2";
                            setState(() {

                            });
                          },),
                          MyButton(title: '3', onPressed: () {
                            userInput += "3";
                            setState(() {

                            });
                          },),
                          MyButton(title: '+',
                            color: Colors.orange,
                            onPressed: () {
                              userInput += "+";
                              setState(() {

                              });
                            },),
                        ],
                      ),
                      Row(
                        children: [
                          MyButton(title: '0', onPressed: () {
                            userInput += "0";
                            setState(() {

                            });
                          },),
                          MyButton(title: '.', onPressed: () {
                            userInput += ".";
                            setState(() {

                            });
                          },),
                          MyButton(title: 'DEL', onPressed: () {
                            userInput =userInput.substring(0,userInput.length-1);
                            setState(() {

                            });
                          },),
                          MyButton(title: '=',
                            color: Colors.orange,
                            onPressed: () {
                              equalPress();
                              setState(() {

                              });
                            },),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void equalPress() {
    Parser p = Parser();
    Expression expression = p.parse(userInput);
    ContextModel contextModel = ContextModel();
    double eval = expression.evaluate(EvaluationType.REAL, contextModel);
    answer = eval.toString();
  }
}