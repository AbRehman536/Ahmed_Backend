import 'package:ahmed_backend/model/task.dart';
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
