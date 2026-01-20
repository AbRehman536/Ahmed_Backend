import 'package:ahmed_backend/model/priority.dart';
import 'package:ahmed_backend/model/task.dart';
import 'package:ahmed_backend/services/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetFavorite extends StatelessWidget {
  const GetFavorite({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Favorite Task"),
        ),
        body: StreamProvider.value(
          value: TaskServices().getFavorite("1"),
          initialData: [TaskModel()],
          builder:  (context, child){
            List<TaskModel> taskList = context.watch<List<TaskModel>>();
            return ListView.builder(
                itemCount: taskList.length,
                itemBuilder: (BuildContext context, int index){
                  return ListTile(
                    leading: Icon(Icons.task),
                    title: Text(taskList[index].name.toString()),
                    subtitle: Text(taskList[index].description.toString()),
                  );
                });
          },
        )
    );
  }
}
