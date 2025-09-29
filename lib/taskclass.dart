class Task {
  String? id;
  String title;
  bool isDone;

  Task(this.title, {this.isDone = false, this.id});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      json["title"],
      isDone: json["done"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title" : title,
      "done" : isDone,
    };
  }
}