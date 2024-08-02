import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task.dart';
import 'package:todo/providers/task_provider.dart';

// ignore: must_be_immutable
class UpdateTaskModalBottomSheet extends StatefulWidget {
  int index;
  UpdateTaskModalBottomSheet({super.key,required this.index});

  @override
  State<UpdateTaskModalBottomSheet> createState() =>
      UpdateTaskModalBottomSheetState();
}

class UpdateTaskModalBottomSheetState extends State<UpdateTaskModalBottomSheet> {
  final TextEditingController _updateTitleController = TextEditingController();
  final TextEditingController _updateDescriptionController =TextEditingController();
  TaskPriority _selectedPriority = TaskPriority.low;

  Task _updateTask() {
    Task task = Task(
      title: _updateTitleController.text,
      description: _updateDescriptionController.text,
      createdAt: DateTime.now(),
      priority: _selectedPriority,
      isDone: false,
    );

    _updateTitleController.clear();

    _updateDescriptionController.clear();

    _selectedPriority = TaskPriority.low;

    return task;
  }

  bool _taskIsOk() {
    return _updateTitleController.text.isNotEmpty;
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
              "Update Task",
              style:GoogleFonts.mooli(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Divider(),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: _updateTitleController,
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
              controller: _updateDescriptionController,
              decoration: InputDecoration(
                hintText: "Description",
                hintStyle: GoogleFonts.mooli(
                  fontSize: 15,
                ),
                isDense: true,
                label: Text("Description",style: GoogleFonts.mooli(
                  fontSize: 15,
                ),),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            Text(
              "Update Priority",
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
                        style: GoogleFonts.mooli(
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
                        style: GoogleFonts.mooli(
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
                  await useTaskProvider.editTask(widget.index,_updateTask());
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
                child: Text(
                  "Update",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.mooli(
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
                  style: GoogleFonts.mooli(
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
