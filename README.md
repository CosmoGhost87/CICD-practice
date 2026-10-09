# To-Do (Flutter Web)

Простое базовое to-do приложение на Flutter для Web: список задач,
у каждой задачи — название, описание и срок. Задачу можно удалить свайпом.

## Структура
- `lib/models/task.dart` — модель задачи
- `lib/screens/add_task_screen.dart` — форма добавления задачи
- `lib/main.dart` — корневой виджет и главный экран со списком

## Запуск
```bash
flutter create --platforms=web .   # если нужно сгенерировать web/ заново
flutter run -d chrome
```
