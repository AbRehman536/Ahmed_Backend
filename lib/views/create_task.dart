import 'package:ahmed_backend/model/priority.dart';
import 'package:ahmed_backend/model/task.dart';
import 'package:ahmed_backend/services/priority.dart';
import 'package:ahmed_backend/services/task.dart';
import 'package:flutter/material.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<PriorityModel> priorityList = [];
  PriorityModel? _selectedPriority;
  @override
  void initState(){
    super.initState();
    PriorityServices().getPriority()
    .then((val){
      setState(() {
        priorityList = val;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Task"),
      ),
      body: Column(
        children: [
          TextField(controller: nameController,),
          TextField(controller: descriptionController,),
          DropdownButton(
            hint: Text("Select Priority"),
              value: _selectedPriority,
              items: priorityList.map((e){
                return DropdownMenuItem(
                  value: e,
                    child: Text(e.name.toString()));
              }).toList(),
              onChanged: (value){
              setState(() {
                _selectedPriority = value;
              });
              }),
          ElevatedButton(onPressed: ()async{
            try{
              await TaskServices().createTask(TaskModel(
                name: nameController.text.toString(),
                description: descriptionController.text.toString(),
                isCompleted: false,
                createdAt: DateTime.now().millisecondsSinceEpoch
              )).then((value){
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Create Successfully"),
                    actions: [
                      TextButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text("Okay"))
                    ],
                  );
                },);
              });
            }catch(e){
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(e.toString())));
            }
          }, child: Text("Create Task"))
        ],
      ),
    );
  }
}
