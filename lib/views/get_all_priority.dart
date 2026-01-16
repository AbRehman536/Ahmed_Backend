
import 'package:ahmed_backend/model/priority.dart';
import 'package:ahmed_backend/model/task.dart';
import 'package:ahmed_backend/services/priority.dart';
import 'package:ahmed_backend/services/task.dart';
import 'package:ahmed_backend/views/create_priority.dart';
import 'package:ahmed_backend/views/create_task.dart';
import 'package:ahmed_backend/views/get_completed_task.dart';
import 'package:ahmed_backend/views/get_incompleted_task.dart';
import 'package:ahmed_backend/views/get_priorities.dart';
import 'package:ahmed_backend/views/update_task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GetAllPriority extends StatelessWidget {
  const GetAllPriority({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get All Priority"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> CreatePriority(model: PriorityModel(), isUpdateMode: false)));
      },child: Icon(Icons.add),),
      body: StreamProvider.value(
        value: PriorityServices().getAllPriority(),
        initialData: [PriorityModel()],
        builder: (context, child){
          List<PriorityModel> priorityList = context.watch<List<PriorityModel>>();
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.task),
                title: Text(priorityList[index].name.toString()),
               trailing: Row(mainAxisSize: MainAxisSize.min,
                 children: [
                   IconButton(onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> CreatePriority(model: PriorityModel(), isUpdateMode: true)));
                   }, icon: Icon(Icons.edit)),
                   IconButton(onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> GetPriorities(model: PriorityModel(),)));
                   }, icon: Icon(Icons.arrow_forward)),
                 ],
               ),
              );
            },

          );
        },),
    );
  }
}
