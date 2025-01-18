import 'package:flutter/material.dart';
import 'package:ortez_test/provider/todo_provider.dart';
import 'package:ortez_test/view/add_screen.dart';
import 'package:ortez_test/view/edit_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Consumer<TodoProvider>(
        builder: (context, value, child) => SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(12),
                child: TextField(
                  // controller: searchController,
                  onChanged: (str) {
                    // searchController.text = str;
                    Provider.of<TodoProvider>(context, listen: false)
                        .searchFilterTodoList(str);
                  },
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: "Search",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25))),
                ),
              ),
              value.todoModelList.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : SizedBox(
                      height: MediaQuery.of(context).size.height * 0.75,
                      child: ListView.builder(
                        itemCount: value.todoModelList.length,
                        itemBuilder: (context, index) => InkWell(
                          onTap: () async {
                            await TodoProvider().getTodoModel(
                                value.todoModelList[index].id.toString());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditScreen(),
                                ));
                          },
                          child: Card(
                            child: ListTile(
                              dense: true,
                              title: Text(
                                  value.todoModelList[index].title.toString()),
                              subtitle: Text(
                                  value.todoModelList[index].id.toString()),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          TodoProvider().resetCurrTodoModel();
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddScreen(),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
