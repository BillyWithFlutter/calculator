import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import 'buttons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion = "";
  var userAnswer = "";

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '.',
    '0',
    ',',
    '=',
  ];

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '+' || x == '-' || x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange[100],
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                        padding: const EdgeInsets.all(16),
                        alignment: Alignment.centerRight,
                        child: Text(
                          userQuestion,
                          style: const TextStyle(fontSize: 20),
                        )),
                    Container(
                        padding: const EdgeInsets.all(16),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          userAnswer,
                          style: const TextStyle(fontSize: 20),
                        )),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: GridView.builder(
                  itemCount: buttons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    // Clear Button
                    if (index == 0) {
                      return MyButton(
                          buttonTapped: () {
                            setState(() {
                              userQuestion = '';
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.deepOrange[50],
                          textColor: Colors.deepOrange);
                    }

                    // Delete Button
                    else if (index == 1) {
                      return MyButton(
                          buttonTapped: () {
                            setState(() {
                              userQuestion = userQuestion.substring(
                                  0, userQuestion.length - 1);
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.deepOrange[50],
                          textColor: Colors.deepOrange);
                    }

                    // Equal Button
                    else if (index == buttons.length - 1) {
                      return MyButton(
                          buttonTapped: () {
                            setState(() {
                              equalPressed();
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.deepOrange[50],
                          textColor: Colors.deepOrange);
                    }

                    // Other Button
                    else {
                      return MyButton(
                        buttonTapped: () {
                          setState(() {
                            userQuestion += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.deepOrange
                            : Colors.deepOrange[50],
                        textColor: isOperator(buttons[index])
                            ? Colors.white
                            : Colors.deepOrange,
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
