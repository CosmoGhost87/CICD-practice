# To-Do (Flutter Web)

Простое базовое to-do приложение на Flutter для Web: список задач,
у каждой задачи — название, описание и срок. Задачу можно удалить свайпом.

## Структура
- `lib/models/task.dart` — модель задачи (+ JSON-сериализация на будущее)
- `lib/screens/add_task_screen.dart` — форма добавления задачи
- `lib/main.dart` — корневой виджет и главный экран со списком

## Запуск
```bash
flutter create --platforms=web .   # если нужно сгенерировать web/ заново
flutter run -d chrome
```

## Тесты
```bash
flutter test            # все тесты
flutter analyze         # линтеры
```
- `test/lint_test.dart` — проверка линтеров (`flutter analyze --fatal-infos`)
- `test/widget_test.dart` — проверка UI: пустое состояние, добавление задачи, валидация
- `test/task_model_test.dart` — проверка модели Task (создание, toJson/fromJson)
