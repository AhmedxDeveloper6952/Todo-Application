import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/taskmodel.dart';

class TaskPage extends StatelessWidget {
  TaskPage({super.key});

  final TextEditingController updateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Fetch tasks when the widget is built
    Provider.of<TaskModel>(context, listen: false).fetchTasks();

    return Consumer<TaskModel>(builder: (context, taskModel, child) {
      return Scaffold(
        body: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: taskModel.tasks.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> taskData = taskModel.tasks[index];
            String task = taskData['task'];
            bool isCompleted = taskData['completed'];

            return Card(
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              elevation: 4.0,
              child: ListTile(
                leading: Checkbox(
                  value: isCompleted,
                  onChanged: (bool? newValue) {
                    taskModel.toggleTaskCompletion(
                        taskData['id'], newValue ?? false);
                  },
                ),
                title: Text(
                  task,
                  style: TextStyle(
                    fontSize: 16.0,
                    decoration: isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        updateController.text = task;
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: const EdgeInsets.all(30.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: updateController,
                                    decoration: const InputDecoration(
                                      hintText: "Update Task",
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      String updatedTask =
                                          updateController.text;
                                      taskModel.updateTask(task, updatedTask);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Update"),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        taskModel.deleteTask(taskData['id']);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
