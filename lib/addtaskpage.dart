import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mystate.dart';

class AddTaskPage extends StatelessWidget {
  AddTaskPage({super.key});
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void submitTask() {
      final text = _controller.text.trim();
        if (text.isNotEmpty) {
          context.read<MyState>().addTask(text);
          Navigator.pop(context);
        }
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Add task page'),
      centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Write new todo here'),
              onSubmitted: (_) => submitTask(),

            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: submitTask,
              child: const Text("Add task"),
            ),
          ],
        ),
      ),
    );
  }
}
