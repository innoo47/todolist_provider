class Todos {
  int? userId;
  int? id;
  String? title;
  bool? completed;

  Todos({
    this.userId,
    this.id,
    this.title,
    this.completed,
  });

  factory Todos.fromJson(Map<String, dynamic> json) {
    return Todos(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }
}
