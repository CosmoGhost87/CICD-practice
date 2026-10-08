class Task {
  Task({
    required this.title,
    required this.description,
    required this.dueDate,
    this.isDone = false,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      dueDate: DateTime.parse(json['dueDate'] as String),
      isDone: json['isDone'] as bool? ?? false,
    );
  }

  final String title;
  final String description;
  final DateTime dueDate;
  final bool isDone;

  /// Returns a copy with the given fields replaced.
  Task copyWith({bool? isDone}) => Task(
    title: title,
    description: description,
    dueDate: dueDate,
    isDone: isDone ?? this.isDone,
  );

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'dueDate': dueDate.toIso8601String(),
      'isDone': isDone,
    };
  }
}