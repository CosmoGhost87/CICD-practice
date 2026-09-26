import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/models/task.dart';

/// Test #3: current code check — Task model logic.
void main() {
  group('Task model', () {
    test('stores title, description and due date', () {
      final due = DateTime(2026, 10, 1);
      final task = Task(title: 'Полить цветы', description: '', dueDate: due);

      expect(task.title, 'Полить цветы');
      expect(task.description, '');
      expect(task.dueDate, due);
    });

    test('toJson serializes all fields', () {
      final due = DateTime(2026, 10, 1, 12);
      final task = Task(
        title: 'Задача',
        description: 'Описание',
        dueDate: due,
      );

      final json = task.toJson();
      expect(json['title'], 'Задача');
      expect(json['description'], 'Описание');
      expect(json['dueDate'], due.toIso8601String());
    });

    test('fromJson round-trips through toJson', () {
      final original = Task(
        title: 'Позвонить врачу',
        description: 'Записаться на приём',
        dueDate: DateTime(2026, 9, 30),
      );

      final restored = Task.fromJson(original.toJson());

      expect(restored.title, original.title);
      expect(restored.description, original.description);
      expect(restored.dueDate, original.dueDate);
    });

    test('fromJson tolerates a missing description', () {
      final task = Task.fromJson({
        'title': 'Без описания',
        'dueDate': DateTime(2026, 10, 2).toIso8601String(),
      });

      expect(task.description, '');
    });
  });
}
