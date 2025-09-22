import 'package:flutter/material.dart';
import 'main.dart';

class MyState extends ChangeNotifier {
  final List<Task> _tasks = [
    Task("Clean room"),
    Task("Do dishes"),
    Task("Make food"),
  ];

  TodoFilter _filter = TodoFilter.all; // aktuell filter
  TodoFilter get filter => _filter;

  List<Task> get tasks {
    switch (_filter) {
      case TodoFilter.done:
        return _tasks.where((t) => t.isDone).toList();
      case TodoFilter.undone:
        return _tasks.where((t) => !t.isDone).toList();
      case TodoFilter.all:
        return _tasks;
    }
  }

  void setFilter(TodoFilter filter) {
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