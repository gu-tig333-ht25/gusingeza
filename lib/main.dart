import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'taskitem.dart';
import 'addtaskpage.dart';
import 'mystate.dart';

enum TodoFilter { all, done, undone }

class Task {
  String title;
  bool isDone;

  Task(this.title, {this.isDone = false});
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyState(),
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'Gusingeza todo'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Center(child: Text(title)),
            Positioned(
              right: 0,
              child: PopupMenuButton<TodoFilter>(
                icon: Icon(Icons.menu, color: const Color.fromARGB(64, 0, 0, 0),size: 30),
                onSelected: (filter) {
                  context.read<MyState>().setFilter(filter);
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: TodoFilter.all,
                    child: Text("Alla todo"),
                  ),
                  PopupMenuItem(
                    value: TodoFilter.done,
                    child: Text("Färdiga todo"),
                  ),
                  PopupMenuItem(
                    value: TodoFilter.undone,
                    child: Text("Ogjorda todo"),
                  ),
                ],
            ),
            ),
        ]),
      ),
      body: Consumer<MyState>(
        builder: (context, state,child) {
          return ListView(
            children: state.tasks.map((task) => taskItem(context, task)).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddTaskPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

