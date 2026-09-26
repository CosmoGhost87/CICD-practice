/// A simple to-do task: title, description and a due date.
class Task {
  Task({
    required this.title,
    required this.description,
    required this.dueDate,
  });

  /// Creates a [Task] from a JSON map (for future persistence support).
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      dueDate: DateTime.parse(json['dueDate'] as String),
    );
  }

  final String title;
  final String description;
  final DateTime dueDate;

  /// Converts this [Task] into a JSON map.
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
    };
  }
}
