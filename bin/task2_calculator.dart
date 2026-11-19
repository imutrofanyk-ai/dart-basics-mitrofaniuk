// bin/task2_calculator.dart
// Консольний калькулятор: введення з клавіатури, перевірка помилок.

import 'dart:io';

// Тип "функція від двох double, що повертає double"
typedef Operation = double Function(double, double);

// Таблиця операцій: символ -> функція
final Map<String, Operation> operations = {
  '+': (a, b) => a + b,
  '-': (a, b) => a - b,
  '*': (a, b) => a * b,
  '/': (a, b) {
    if (b == 0) {
      throw ArgumentError('Division by zero');
    }
    return a / b;
  },
};

// Читає число з клавіатури; повертає null, якщо введено не число
double? readNumber(String prompt) {
  stdout.write(prompt);
  final line = stdin.readLineSync();
  if (line == null) return null;
  return double.tryParse(line.trim().replaceAll(',', '.'));
}

void main() {
  print('=== Calculator (type q to quit) ===');

  while (true) {
    stdout.write('Operation (+, -, *, /) or q: ');
    final symbol = stdin.readLineSync()?.trim();
    if (symbol == null || symbol == 'q') break;

    final op = operations[symbol];

    if (op == null) {
      print('Unknown operation: $symbol');
      continue;
    }

    final a = readNumber('First number: ');
    final b = readNumber('Second number: ');
    if (a == null || b == null) {
      print('Error: that is not a number');
      continue;
    }

    try {
      print('$a $symbol $b = ${op(a, b)}');
    } on ArgumentError catch (e) {
      print('Error: ${e.message}');
    }
  }

  print('Bye!');
}
