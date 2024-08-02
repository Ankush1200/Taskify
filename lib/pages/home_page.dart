import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:todo/pages/add_task_modal_sheet.dart';
import 'package:todo/providers/task_provider.dart';
import 'package:todo/utils/widgets/task_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String routeName = "/home";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Logger().i("Route to -> HomePage");
    super.initState();
  }

  void _showAddTaskBottomModalSheet() {
    showModalBottomSheet(
      isScrollControlled: true,
      constraints: const BoxConstraints(
        maxHeight: 550,
      ),
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddTaskModalBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<TaskProvider>(context, listen: false).loadTasks();
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddTaskBottomModalSheet();
          },
          backgroundColor:Colors.amber,
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        appBar: AppBar(
          title:  Text(
            "Your Todos©",
            style: GoogleFonts.mooli(
                color: Colors.black,
                fontSize:20,
                fontWeight: FontWeight.bold,
              ),
          ),
          backgroundColor: Colors.amber,
          elevation: 0,
          foregroundColor: Colors.black87,
        ),
        body: SizedBox(
          width: double.infinity,
          child: taskProvider.tasks.isEmpty
              ? Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 30,
                    ),
                    margin: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black12,
                        ),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, 0),
                            spreadRadius: -3,
                            blurRadius: 10,
                            color: Color.fromARGB(255, 205, 205, 205),
                          )
                        ]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.task_alt_rounded,
                          size: 50,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                         Text(
                          "Task list is empty",
                          style: GoogleFonts.mooli(
                            fontSize: 15,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            _showAddTaskBottomModalSheet();
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
                              "Add Task",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.mooli(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) => TaskCard(
                          index: taskProvider.tasks.length - index - 1,
                          task: taskProvider
                              .tasks[taskProvider.tasks.length - index - 1],
                        ),
                        // separatorBuilder: (context, index) => const Divider(),
                        itemCount: taskProvider.tasks.length,
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
