import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/main.dart';

/// Test #2: current code check — UI/widget behaviour.
///
/// Verifies the empty state and that a new task (title, description,
/// due date) appears in the list after being added via the form.
void main() {
  testWidgets('app starts with an empty state', (tester) async {
    await tester.pumpWidget(const TodoApp());

    expect(find.text('Мои задачи (0/0)'), findsOneWidget);
    expect(find.textContaining('Задач пока нет'), findsOneWidget);
    expect(find.byKey(const Key('add_task_button')), findsOneWidget);
  });

  testWidgets('adding a task shows it in the list', (tester) async {
    await tester.pumpWidget(const TodoApp());

    // Open the "add task" screen.
    await tester.tap(find.byKey(const Key('add_task_button')));
    await tester.pumpAndSettle();

    expect(find.text('Новая задача'), findsOneWidget);

    // Fill in the form.
    await tester.enterText(find.byKey(const Key('title_field')), 'Купить хлеб');
    await tester.enterText(
      find.byKey(const Key('description_field')),
      'В магазине у дома',
    );
    await tester.tap(find.byKey(const Key('save_button')));
    await tester.pumpAndSettle();

    // The task should now be visible on the main screen.
    expect(find.text('Купить хлеб'), findsOneWidget);
    expect(find.text('В магазине у дома'), findsOneWidget);
    expect(find.textContaining('Срок:'), findsOneWidget);
  });

  testWidgets('empty title is rejected by validation', (tester) async {
    await tester.pumpWidget(const TodoApp());

    await tester.tap(find.byKey(const Key('add_task_button')));
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('save_button')));
    await tester.pumpAndSettle();

    expect(find.text('Введите название'), findsOneWidget);
    // Still on the add-task screen.
    expect(find.text('Новая задача'), findsOneWidget);
  });

  testWidgets('AppBar shows 0/0 with no tasks', (tester) async {
    await tester.pumpWidget(const TodoApp());
    expect(find.text('Мои задачи (0/0)'), findsOneWidget);
  });

  testWidgets('AppBar updates counter when tasks added and toggled',
      (tester) async {
    await tester.pumpWidget(const TodoApp());

    // Добавляем первую задачу
    await tester.tap(find.byKey(const Key('add_task_button')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('title_field')), 'Задача 1');
    await tester.tap(find.byKey(const Key('save_button')));
    await tester.pumpAndSettle();

    expect(find.text('Мои задачи (0/1)'), findsOneWidget);

    // Добавляем вторую
    await tester.tap(find.byKey(const Key('add_task_button')));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const Key('title_field')), 'Задача 2');
    await tester.tap(find.byKey(const Key('save_button')));
    await tester.pumpAndSettle();

    expect(find.text('Мои задачи (0/2)'), findsOneWidget);

    // Отмечаем первую выполненной
    await tester.tap(find.byKey(const Key('task_checkbox_0')));
    await tester.pumpAndSettle();

    expect(find.text('Мои задачи (1/2)'), findsOneWidget);
  });
}
