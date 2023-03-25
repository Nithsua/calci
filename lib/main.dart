import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      theme: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              background: const Color.fromRGBO(34, 37, 44, 1.0),
            ),
        scaffoldBackgroundColor: const Color.fromRGBO(34, 37, 44, 1.0),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              elevation: 0.0,
              backgroundColor: const Color.fromRGBO(34, 37, 44, 1.0),
            ),
      ),
      home: const Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  CalculatorState createState() => CalculatorState();
}

class CalculatorState extends State<Calculator> {
  String _prev = '';
  String _expression = '';

  void _onPressed(String text) {
    setState(() {
      _expression += text;
    });
  }

  void _evaluate() {
    Parser p = Parser();
    Expression exp = p.parse(_expression);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      _prev = _expression;
      _expression = eval.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calci'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _prev,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 24.0),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _expression,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 38.0),
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(42, 45, 53, 1.0),
              borderRadius: BorderRadius.circular(16.0),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 24.0,
              horizontal: 16.0,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Table(
                  children: [
                    TableRow(
                      children: [
                        // Hmm...
                        Container(),
                        _buildButton(
                          'C',
                          color: const Color.fromRGBO(107, 219, 190, 1.0),
                        ),
                        _buildButton(
                          'AC',
                          color: const Color.fromRGBO(107, 219, 190, 1.0),
                        ),
                        _buildButton(
                          '/',
                          color: const Color.fromRGBO(197, 101, 99, 1.0),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildButton('7'),
                        _buildButton('8'),
                        _buildButton('9'),
                        _buildButton(
                          '*',
                          color: const Color.fromRGBO(197, 101, 99, 1.0),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildButton('4'),
                        _buildButton('5'),
                        _buildButton('6'),
                        _buildButton(
                          '-',
                          color: const Color.fromRGBO(197, 101, 99, 1.0),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildButton('1'),
                        _buildButton('2'),
                        _buildButton('3'),
                        _buildButton(
                          '+',
                          color: const Color.fromRGBO(197, 101, 99, 1.0),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildButton('.'),
                        _buildButton('0'),
                        _buildButton('00'),
                        _buildButton(
                          '=',
                          color: const Color.fromRGBO(197, 101, 99, 1.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildButton(String text, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: LayoutBuilder(builder: (context, constraints) {
        return MaterialButton(
          height: constraints.maxWidth,
          elevation: 0.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          color: const Color.fromRGBO(40, 43, 50, 1.0),
          child: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              text,
              style: TextStyle(fontSize: 24.0, color: color ?? Colors.white),
            ),
          ),
          onPressed: () {
            if (text == 'C') {
              setState(() {
                _expression = '';
              });
            } else if (text == 'AC') {
              setState(() {
                _prev = '';
                _expression = '';
              });
            } else if (text == '=') {
              _evaluate();
            } else {
              _onPressed(text);
            }
          },
        );
      }),
    );
  }
}
