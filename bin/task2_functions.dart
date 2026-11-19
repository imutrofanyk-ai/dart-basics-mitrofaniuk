// bin/task2_functions.dart
// Демонстрація різних видів функцій у Dart.

// Псевдонім типу: "функція від двох double, що повертає double"
typedef Operation = double Function(double, double);

// 1. Звичайна функція з типами
int add(int a, int b) {
  return a + b;
}

// 2. Стрілочна функція (один вираз)
int square(int x) => x * x;

// 3. Іменовані параметри: required і значення за замовчуванням
String greet({required String name, String greeting = 'Hello'}) {
  return '$greeting, $name!';
}

// 4. Необов'язковий позиційний параметр []
String fullName(String first, [String? last]) {
  return last == null ? first : '$first $last';
}

// 5. Функція вищого порядку: приймає іншу функцію
int applyTwice(int Function(int) f, int value) => f(f(value));

// 6. Функція повертає функцію (замикання запам'ятовує factor)
int Function(int) makeMultiplier(int factor) {
  return (int x) => x * factor;
}

// 7. Замикання зі станом: лічильник
int Function() makeCounter() {
  int count = 0;
  return () => ++count;
}

// 8. Рекурсія
int factorial(int n) => n <= 1 ? 1 : n * factorial(n - 1);

void main() {
  print('=== Task 2: Functions ===');

  print('add(2, 3) = ${add(2, 3)}');
  print('square(5) = ${square(5)}');
  print(greet(name: 'Ivan'));
  print(greet(name: 'Ivan', greeting: 'Hi'));
  print(fullName('Ivan'));
  print(fullName('Ivan', 'Mitrofaniuk'));
  print('applyTwice(square, 3) = ${applyTwice(square, 3)}');

  final triple = makeMultiplier(3);
  print('triple(7) = ${triple(7)}');

  final counter = makeCounter();
  counter();
  counter();
  print('counter on 3rd call = ${counter()}');

  print('factorial(5) = ${factorial(5)}');

  // Функціональний стиль над списком (анонімні функції)
  final numbers = [1, 2, 3, 4, 5, 6];
  final evens = numbers.where((n) => n % 2 == 0).toList();
  final squares = numbers.map((n) => n * n).toList();
  final sum = numbers.fold<int>(0, (acc, n) => acc + n);
  final product = numbers.reduce((a, b) => a * b);
  print('evens: $evens');
  print('squares: $squares');
  print('sum (fold): $sum, product (reduce): $product');

  // Функції як значення в Map (typedef Operation)
  final Map<String, Operation> operations = {
    '+': (a, b) => a + b,
    '-': (a, b) => a - b,
    '*': (a, b) => a * b,
    '/': (a, b) => a / b,
  };
  operations.forEach((symbol, op) {
    print('10 $symbol 4 = ${op(10, 4)}');
  });
}
