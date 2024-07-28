import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do_getx/models/to_do_model.dart';
import 'package:to_do_getx/utils/Db.dart';

class TodoListController extends GetxController {
  RxList<ToDoModel> list = <ToDoModel>[
    ToDoModel(name: "Long press the task to edit or delete", isDone: false),
    ToDoModel(name: "Click on plus icon to add new task", isDone: false),
    ToDoModel(name: "Mark the checkbox to complete the task", isDone: false),
  ].obs;

  Rx<int> currentIndex = 0.obs;

  TextEditingController taskName = TextEditingController();

  @override
  void onInit() {
    loadDataFromLocal();
    super.onInit();
  }

  // put the list in right order
  void sortList() {
    list.sort((a, b) {
      if (a.isDone == b.isDone)
        return 0;
      else if (a.isDone)
        return 1;
      else
        return -1;
    });
  }

  // save data to local
  void saveDataToLocal() {
    sortList();
    final stringList = list
        .map(
          (element) => jsonEncode(element.toJson()),
        )
        .toList();
    Db.p.setStringList(Db.list, stringList);
  }

  // load data from local
  void loadDataFromLocal() {
    final localList = Db.p.getStringList(Db.list);
    if (localList != null) {
      final dataList =
          localList.map((e) => ToDoModel.fromJson(jsonDecode(e))).toList();
      list.value = dataList;
      sortList();
      list.refresh();
    }
  }

  // create new to do
  void createNewToDo({required ToDoModel newTodo}) {
    list.add(newTodo);
    sortList();
    list.refresh();
    saveDataToLocal();
  }

  // change isDone status
  void changeToDoStatus({required int index}) {
    list[index].isDone = !list[index].isDone;
    sortList();
    list.refresh();
    saveDataToLocal();
  }

  // edit to do
  void editToDo({required String newName, required int index}) {
    list[index].name = newName;
    sortList();
    list.refresh();
    saveDataToLocal();
  }

  // delete to do
  void deleteToDo({required int index}) {
    list.removeAt(index);
    sortList();
    list.refresh();
    saveDataToLocal();
  }
}
