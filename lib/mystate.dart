import 'package:flutter/material.dart';
import 'main.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'taskclass.dart';

class MyState extends ChangeNotifier {
  final String apiKey = "9a2cb6ce-ee5c-4cbe-abb4-f7c829c242ca";
  List<Task> _tasks = [];

  TodoFilter _filter = TodoFilter.all; // aktuell filter
  TodoFilter get filter => _filter;

  MyState() {
    fetchTasks();
  }

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

  Future<void> fetchTasks() async {
    final response = await http.get(Uri.parse("https://todoapp-api.apps.k8s.gu.se/todos?key=$apiKey"),
    );
    final List data = jsonDecode(response.body);
    _tasks = data.map((json) => Task.fromJson(json)).toList().cast<Task>();
    notifyListeners();
  }

  Future<void> addTask(String title) async {
    await http.post(
      Uri.parse("https://todoapp-api.apps.k8s.gu.se/todos?key=$apiKey"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"title": title, "done": false}),
    );
    await fetchTasks();
  }

  Future<void> removeTask(Task task) async {
    await http.delete(
      Uri.parse("https://todoapp-api.apps.k8s.gu.se/todos/${task.id}?key=$apiKey"),
    );
    await fetchTasks();
  } 

  Future<void> toggleTask(Task task) async {
    final updated = Task(task.title, isDone: !task.isDone, id: task.id);

    await http.put(
      Uri.parse("https://todoapp-api.apps.k8s.gu.se/todos/${task.id}?key=$apiKey"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(updated.toJson()),
    );
    await fetchTasks();
  }

  void setFilter(TodoFilter filter) {
    _filter = filter;
    notifyListeners();
  }
  
}