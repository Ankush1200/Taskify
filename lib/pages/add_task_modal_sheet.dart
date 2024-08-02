import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task.dart';
import 'package:todo/providers/task_provider.dart';

class AddTaskModalBottomSheet extends StatefulWidget {
  const AddTaskModalBottomSheet({super.key});

  @override
  State<AddTaskModalBottomSheet> createState() =>
      AddTaskModalBottomSheetState();
}

class AddTaskModalBottomSheetState extends State<AddTaskModalBottomSheet> {
  final TextEditingController _taskTitleController = TextEditingController();
  final TextEditingController _taskDescriptionController =TextEditingController();
  TaskPriority _selectedPriority = TaskPriority.low;

  Task _createTask() {
    Task task = Task(
      title: _taskTitleController.text,
      description: _taskDescriptionController.text,
      createdAt: DateTime.now(),
      priority: _selectedPriority,
      isDone: false,
    );

    _taskTitleController.clear();

    _taskDescriptionController.clear();

    _selectedPriority = TaskPriority.low;

    return task;
  }

  bool _taskIsOk() {
    return _taskTitleController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, useTaskProvider, child) => Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New Task",
              style: GoogleFonts.mooli(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: _taskTitleController,
              decoration: InputDecoration(
                hintText: "Task",
                hintStyle: GoogleFonts.mooli(
                  fontSize: 15,
                ),
                isDense: true,
                label: Text("Task Title",style: GoogleFonts.mooli(
                  fontSize: 15,
                ),),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: _taskDescriptionController,
              decoration: InputDecoration(
                hintText: "Description",
                hintStyle: GoogleFonts.mooli(
                  fontSize: 15,
                ),
                isDense: true,
                label: Text("Description",style:GoogleFonts.mooli(
                  fontSize: 15,
                ),),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Text(
              "Select Priority",
              style: GoogleFonts.mooli(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPriority = TaskPriority.low;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _selectedPriority == TaskPriority.low
                              ? Colors.green
                              : Colors.grey,
                        ),
                      ),
                      child: Text(
                        "Low",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.mooli(
                          color: _selectedPriority == TaskPriority.low
                              ? Colors.green
                              : Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPriority = TaskPriority.medium;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _selectedPriority == TaskPriority.medium
                              ? Colors.amber
                              : Colors.grey,
                        ),
                      ),
                      child: Text(
                        "Medium",
                        textAlign: TextAlign.center,
                        style:  GoogleFonts.mooli(
                          color: _selectedPriority == TaskPriority.medium
                              ? Colors.amber
                              : Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedPriority = TaskPriority.high;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: _selectedPriority == TaskPriority.high
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                      child: Text(
                        "High",
                        textAlign: TextAlign.center,
                        style:  GoogleFonts.mooli(
                          color: _selectedPriority == TaskPriority.high
                              ? Colors.red
                              : Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: () async {
                if (_taskIsOk()) {
                  await useTaskProvider.addTask(_createTask());
                  if (mounted) {
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                }
              },
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(10),
                ),
                child:Text(
                  "Add Task",
                  textAlign: TextAlign.center,
                  style:  GoogleFonts.mooli(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () async {
                Navigator.pop(context);
              },
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "Cancel",
                  textAlign: TextAlign.center,
                  style:  GoogleFonts.mooli(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
