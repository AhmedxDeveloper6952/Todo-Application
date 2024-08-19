import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/favouritemodel.dart';

class Favouritepage extends StatelessWidget {
  const Favouritepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        centerTitle: true,
      ),
      body: Consumer<Favouritemodel>(
        builder: (context, favouritemodel, child) {
          return favouritemodel.tasks.isEmpty
              ? const Center(
                  child: Text(
                    'No favorite tasks yet!',
                    style: TextStyle(fontSize: 18.0),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: favouritemodel.tasks.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      elevation: 3.0,
                      child: ListTile(
                        title: Text(
                          favouritemodel.tasks[index],
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Delete Task'),
                                  content: const Text(
                                      'Are you sure you want to delete this task?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        favouritemodel.removeTask(
                                            favouritemodel.tasks[index]);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
