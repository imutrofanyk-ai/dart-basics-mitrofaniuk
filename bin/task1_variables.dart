// bin/task1_variables.dart
// Демонстрація базових типів і змінних Dart.

void main() {
  print('=== Task 1: Dart basic types ===');

  // --- Числові типи ---
  int lectures = 12;
  double average = 4.75;
  num anyNumber = 10; // num може бути і int, і double
  anyNumber = 10.5;
  print('int: $lectures, double: $average, num: $anyNumber');

  // --- Рядки ---
  String name = 'Ivan';
  String group = "ALK-44";
  String multi = '''Line one
Line two''';
  print('String: $name from $group, length of name = ${name.length}');
  print(multi);

  // --- bool ---
  bool isReady = lectures > 10;
  print('bool: $isReady');

  // --- var, final, const ---
  var city = 'Krasnoarmiisk'; // тип String виведено автоматично
  final DateTime startedAt =
      DateTime.now(); // final: задається один раз під час виконання
  const double piApprox =
      3.14159; // const: значення відоме ще на етапі компіляції
  print('var: $city, final year: ${startedAt.year}, const: $piApprox');

  // --- Null safety ---
  String? nickname; // знак ? дозволяє значення null
  print('nickname before: $nickname');
  nickname ??= 'none yet'; // присвоїти, лише якщо зараз null
  print('nickname after: $nickname');
  int? maybe;
  int safe = maybe ?? 0; // значення за замовчуванням, якщо null
  print('maybe = $maybe, safe = $safe');

  // --- dynamic ---
  dynamic anything = 42;
  print('dynamic as int: $anything (${anything.runtimeType})');
  anything = 'now a string';
  print('dynamic as String: $anything (${anything.runtimeType})');

  // --- Колекції ---
  List<int> numbers = [3, 1, 2, 3];
  Set<int> unique = {3, 1, 2, 3}; // дублікати зникають
  Map<String, int> marks = {'Dart': 5, 'SQL': 4};
  print('List: $numbers');
  print('Set: $unique');
  print('Map: $marks, Dart mark = ${marks['Dart']}');

  // --- Record (з Dart 3) і перевірка типу ---
  (String, int) record = ('Dart', 3);
  print('Record: ${record.$1} v${record.$2}');
  Object value = 7;
  if (value is int) {
    print('value is int, doubled = ${value * 2}');
  }
}
