// lib/utils/data_processor.dart
// Статичні утиліти для роботи з колекціями.

class DataProcessor {
  DataProcessor._(); // забороняє створювати екземпляри

  /// Унікальні елементи списку (через Set), порядок зберігається.
  static List<T> unique<T>(List<T> items) => items.toSet().toList();

  /// Середнє значення списку чисел (0 для порожнього).
  static double average(List<num> values) =>
      values.isEmpty ? 0 : values.fold<num>(0, (a, b) => a + b) / values.length;

  /// Медіана списку чисел.
  static double median(List<num> values) {
    if (values.isEmpty) return 0;
    final sorted = [...values]..sort();
    final mid = sorted.length ~/ 2;
    return sorted.length.isOdd
        ? sorted[mid].toDouble()
        : (sorted[mid - 1] + sorted[mid]) / 2;
  }

  /// Групує елементи за ключем.
  static Map<K, List<T>> groupBy<T, K>(List<T> items, K Function(T) key) {
    final result = <K, List<T>>{};
    for (final item in items) {
      result.putIfAbsent(key(item), () => []).add(item);
    }
    return result;
  }

  /// Частота кожного елемента.
  static Map<T, int> frequency<T>(List<T> items) {
    final result = <T, int>{};
    for (final item in items) {
      result[item] = (result[item] ?? 0) + 1;
    }
    return result;
  }

  /// Сортування за власним ключем (за спаданням, якщо descending).
  static List<T> sortBy<T, K extends Comparable>(
    List<T> items,
    K Function(T) key, {
    bool descending = false,
  }) {
    final copy = [...items];
    copy.sort(
      (a, b) =>
          descending ? key(b).compareTo(key(a)) : key(a).compareTo(key(b)),
    );
    return copy;
  }

  /// Перетин і об'єднання множин.
  static Set<T> intersection<T>(Set<T> a, Set<T> b) => a.intersection(b);
  static Set<T> union<T>(Set<T> a, Set<T> b) => a.union(b);
}
