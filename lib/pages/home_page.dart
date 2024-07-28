import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_getx/controllers/todo_list_controller.dart';
import 'package:to_do_getx/models/to_do_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[600],
        onPressed: () {
          Get.find<TodoListController>().taskName.text == "";
          Get.dialog(AlertDialog(
            title: Text("Add new Todo"),
            content: TextFormField(
              controller: Get.find<TodoListController>().taskName,
              decoration: InputDecoration(
                hintText: "New Task !",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text("Cancel"),
              ),
              TextButton(
                  onPressed: () {
                    ToDoModel newTodo = ToDoModel(
                        name: Get.find<TodoListController>().taskName.text,
                        isDone: false);
                    Get.find<TodoListController>()
                        .createNewToDo(newTodo: newTodo);
                    Get.find<TodoListController>().taskName.text = "";
                    Get.back();
                  },
                  child: Text("Add"))
            ],
          ));
        },
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Obx(
          () => ListView.builder(
            itemCount: Get.find<TodoListController>().list.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () {
                  Get.find<TodoListController>().taskName.text =
                      Get.find<TodoListController>().list[index].name;
                  Get.dialog(
                    AlertDialog(
                      title: Text("Edit Todo ?"),
                      content: TextFormField(
                        controller: Get.find<TodoListController>().taskName,
                        decoration: InputDecoration(
                          hintText: "task",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.find<TodoListController>()
                                .deleteToDo(index: index);
                            Get.back();
                          },
                          child: Text("Delete"),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text("Cancel"),
                        ),
                        TextButton(
                            onPressed: () {
                              Get.find<TodoListController>().editToDo(
                                  newName: Get.find<TodoListController>()
                                      .taskName
                                      .text,
                                  index: index);
                              Get.find<TodoListController>().taskName.text = "";
                              Get.back();
                            },
                            child: Text("Edit"))
                      ],
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  child: ListTile(
                    tileColor: Colors.grey[900],
                    title: Obx(
                      () => Text(
                        Get.find<TodoListController>().list[index].name,
                        style: TextStyle(
                            decoration: Get.find<TodoListController>()
                                    .list[index]
                                    .isDone
                                ? TextDecoration.lineThrough
                                : null),
                      ),
                    ),
                    trailing: Obx(
                      () => IconButton(
                        onPressed: () {
                          Get.find<TodoListController>()
                              .changeToDoStatus(index: index);
                        },
                        icon: Icon(
                            Get.find<TodoListController>().list[index].isDone
                                ? Icons.check_box
                                : Icons.check_box_outline_blank),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
