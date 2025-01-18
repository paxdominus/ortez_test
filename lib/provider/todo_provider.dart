import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ortez_test/model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  static final TodoProvider _singleton = TodoProvider._internal();

  factory TodoProvider() {
    return _singleton;
  }

  TodoProvider._internal();

  List<TodoModel> todoModelList = [];
  List<TodoModel> totalTodoModelList = [];

  TodoModel currTodoModel = TodoModel();

  void fetchTodoModels() async {
    final res = await Dio().get("https://jsonplaceholder.typicode.com/todos");
    todoModelList = List.from(res.data.map((e) => TodoModel.fromJson(e)));
    totalTodoModelList = List.from(todoModelList);
    notifyListeners();
  }

  void addTodoModel(Map<String, dynamic> data) async {
    notifyListeners();
  }

  void editTodoModel(Map<String, dynamic> data, String id) async {
    notifyListeners();
  }

  Future<void> getTodoModel(String id) async {
    final res =
        await Dio().get("https://jsonplaceholder.typicode.com/todos/$id");
    currTodoModel = TodoModel.fromJson(res.data);
    notifyListeners();
  }

  void searchFilterTodoList(String term) {
    if (term.isEmpty) {
      todoModelList = List.from(totalTodoModelList);
    } else {
      todoModelList
          .retainWhere((element) => element.title.toString().contains(term));
    }
    notifyListeners();
  }

  void switchIsCompleted() {
    currTodoModel.completed = !(currTodoModel.completed ?? false);
    notifyListeners();
  }

  void resetCurrTodoModel() {
    currTodoModel = TodoModel();
    notifyListeners();
  }
}
