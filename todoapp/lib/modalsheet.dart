import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/tabbar.dart';
import 'package:todoapp/taskmodel.dart';
import 'package:todoapp/favouritemodel.dart';

class Modalsheet extends StatefulWidget {
  Modalsheet({super.key});

  @override
  _ModalsheetState createState() => _ModalsheetState();
}

class _ModalsheetState extends State<Modalsheet> {
  final TextEditingController textcontroller = TextEditingController();
  bool isFavorite = false;
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Expanded(child: Tabbar())],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            elevation: 400,
            context: context,
            builder: (BuildContext context) => Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: textcontroller,
                    decoration: const InputDecoration(
                      hintText: "New Task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate ?? DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );
                            if (pickedDate != null) {
                              setState(() {
                                selectedDate = pickedDate;
                              });
                            }
                          },
                          child: Text(
                            selectedDate == null
                                ? 'Select Due Date'
                                : 'Due Date: ${selectedDate!.toLocal()}'
                                    .split(' ')[0],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_outline,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          String task = textcontroller.text;
                          Provider.of<TaskModel>(context, listen: false)
                              .addTask(task);
                          if (isFavorite) {
                            Provider.of<Favouritemodel>(context, listen: false)
                                .addTask(task);
                          }
                          Navigator.pop(context);
                        },
                        child: const Text("Save"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
