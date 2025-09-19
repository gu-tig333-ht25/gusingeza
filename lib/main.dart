import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'taskitem.dart';
import 'addtaskpage.dart';
import 'mystate.dart';

enum todo_filter { all, done, undone }

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
              child: PopupMenuButton<todo_filter>(
                icon: Icon(Icons.menu, color: const Color.fromARGB(64, 0, 0, 0),size: 30),
                onSelected: (filter) {
                  context.read<MyState>().setFilter(filter);
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: todo_filter.all,
                    child: Text("Alla todo"),
                  ),
                  PopupMenuItem(
                    value: todo_filter.done,
                    child: Text("Färdiga todo"),
                  ),
                  PopupMenuItem(
                    value: todo_filter.undone,
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

