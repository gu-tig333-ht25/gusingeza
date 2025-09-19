import 'package:flutter/material.dart';
import 'main.dart';

class MyState extends ChangeNotifier {
  final List<Task> _tasks = [
    Task("Clean room"),
    Task("Do dishes"),
    Task("Make food"),
  ];

  todo_filter _filter = todo_filter.all; // aktuell filter
  todo_filter get filter => _filter;

  List<Task> get tasks {
    switch (_filter) {
      case todo_filter.done:
        return _tasks.where((t) => t.isDone).toList();
      case todo_filter.undone:
        return _tasks.where((t) => !t.isDone).toList();
      case todo_filter.all:
        return _tasks;
    }
  }

  void setFilter(todo_filter filter) {
    _filter = filter;
    notifyListeners();
  }

  void addTask(String task) {
    _tasks.add(Task(task));
    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  void toggleTask(Task task) {
    task.isDone = !task.isDone;
    notifyListeners();
  }
}