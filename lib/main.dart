import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
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

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var addTask = 0;



Widget taskItem(String text) {
  return Column(
    children: [
      Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, 
          children: [
            IconButton(
              icon: Icon(Icons.check_box_outline_blank),
              onPressed: () {
                print('Checkbox clicked for $text');
              },
            ),
            Text(text),
            IconButton(
              icon: Icon(Icons.delete), 
              onPressed: () {
                print('Delete button pressed on $text');
              },
            ),
          ],
        ),
      ),
      Divider(color: Colors.grey),
    ],
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Center(child: Text(widget.title)),
            Positioned(
              right: 0,
              child: Icon(Icons.menu, color: const Color.fromARGB(64, 0, 0, 0),size: 30),
            ),
        ]),
        

      ),
      body: Align(
        alignment: AlignmentGeometry.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            taskItem('Clean room'),
            taskItem('Do dishes'),
            taskItem('Make food')
          ],
        ),
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
class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add task page'),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey, width: 1)
          ),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Write new todo here',
            ),
          ),
        ),
      ),
    );
  }
}
