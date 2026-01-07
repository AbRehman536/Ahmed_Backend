
import 'package:ahmed_backend/model/task.dart';
import 'package:ahmed_backend/services/task.dart';
import 'package:flutter/material.dart';

class UpdateTask extends StatefulWidget {
  final TaskModel model;
  const UpdateTask({super.key, required this.model});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  void initState(){
    nameController = TextEditingController(
      text: widget.model.name.toString()
    );
    descriptionController = TextEditingController(
      text: widget.model.description.toString()
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Task"),
      ),
      body: Column(
        children: [
          TextField(controller: nameController,),
          TextField(controller: descriptionController,),
          ElevatedButton(onPressed: ()async{
            try{
              await TaskServices().updateTask(TaskModel(
                docId: widget.model.docId.toString(),
                  name: nameController.text.toString(),
                  description: descriptionController.text.toString(),
                  isCompleted: false,
                  createdAt: DateTime.now().millisecondsSinceEpoch
              )).then((value){
                showDialog(context: context, builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Update Successfully"),
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
          }, child: Text("Update Task"))
        ],
      ),
    );
  }
}
