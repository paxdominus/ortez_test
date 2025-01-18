import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ortez_test/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  void initState() {
    titleController.text = TodoProvider().currTodoModel.title.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Consumer<TodoProvider>(
                builder: (context, value, child) => TextButton(
                    onPressed: () {
                      TodoProvider().editTodoModel({
                        "title": titleController.text.trim(),
                        "completed": value.currTodoModel.completed ?? false
                      }, value.currTodoModel.id.toString());
                      Fluttertoast.showToast(msg: "success");
                      Navigator.pop(context);
                    },
                    child: Text("SAVE")))
          ],
          title: Text("Edit"),
        ),
        body: Consumer<TodoProvider>(
          builder: (context, value, child) => value.currTodoModel.id == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(15),
                      child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                            hintText: "Title",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: TextField(
                        controller: descController,
                        minLines: 4,
                        maxLines: 5,
                        decoration: InputDecoration(
                            hintText: "Description",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25))),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              value: value.currTodoModel.completed ?? false,
                              onChanged: (switchValue) =>
                                  value.switchIsCompleted()),
                          Text("Is Completed")
                        ],
                      ),
                    ),
                  ],
                ),
        ));
  }
}
