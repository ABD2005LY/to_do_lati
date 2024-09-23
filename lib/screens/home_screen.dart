import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_lati/models/task_model.dart';
import 'package:to_do_lati/provider/task_provider.dart';
import 'package:to_do_lati/widgets/cards/task_card.dart';
import 'package:to_do_lati/widgets/cilkckables/drawer.dart';
import 'package:to_do_lati/widgets/dialog/task_dialog.dart';
import 'package:to_do_lati/provider/dark_mode_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskSubtitleController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DarkModeProvider>(builder: (context, darkModeConsumer, _) {
      return Consumer<TasksProvider>(builder: (context, tasksConsumer, _) {
        return Scaffold(
          drawer: Drawer(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DrawerTile(
                        text: darkModeConsumer.isDark
                            ? "Light Mode"
                            : "Dark Mode",
                        onTab: () {
                          Provider.of<DarkModeProvider>(context, listen: false)
                              .switchMode();
                        },
                        icon: darkModeConsumer.isDark
                            ? Icons.light_mode
                            : Icons.dark_mode),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 102, 161, 209),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AddTaskDialog(
                    titleController: taskTitleController,
                    subTitleController: taskSubtitleController,
                    formKey: formKey,
                    onTap: () {
                      Provider.of<TasksProvider>(context, listen: false)
                          .addTask(TaskModel(
                              title: taskTitleController.text,
                              subTitle: taskSubtitleController.text.isEmpty
                                  ? null
                                  : taskSubtitleController.text,
                              createdAt: DateTime.now()));

                      // setState(() {});

                      taskTitleController.clear();
                      taskSubtitleController.clear();

                      Navigator.pop(context);
                    },
                  );
                },
              );
            },
          ),
          appBar: AppBar(
            title: const Text("TODO"),
          ),
          body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                    isScrollable: false,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(
                        text: "Waiting",
                      ),
                      Tab(
                        text: "Completed",
                      )
                    ]),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.all(24),
                        itemCount: tasksConsumer.tasks.length,
                        itemBuilder: (context, index) {
                          return tasksConsumer.tasks[index].isCompleted
                              ? const SizedBox()
                              : TaskCard(
                                  taskModel: tasksConsumer.tasks[index],
                                  onTap: () {
                                    Provider.of<TasksProvider>(context,
                                            listen: false)
                                        .switchValue(
                                            tasksConsumer.tasks[index]);
                                  },
                                  delete: () {
                                    // setState(() {
                                    Provider.of<TasksProvider>(context,
                                            listen: false)
                                        .delete(tasksConsumer.tasks[index]);
                                    //   });
                                  },
                                );
                        },
                      ),
                      ListView.builder(
                        padding: const EdgeInsets.all(24),
                        itemCount: tasksConsumer.tasks.length,
                        itemBuilder: (context, index) {
                          return !tasksConsumer.tasks[index].isCompleted
                              ? const SizedBox()
                              : TaskCard(
                                  taskModel: tasksConsumer.tasks[index],
                                  onTap: () {
                                    //  setState(() {
                                    Provider.of<TasksProvider>(context,
                                            listen: false)
                                        .switchValue(
                                            tasksConsumer.tasks[index]);
                                    //  });
                                  },
                                  delete: () {
                                    //  setState(() {
                                    Provider.of<TasksProvider>(context,
                                            listen: false)
                                        .delete(tasksConsumer.tasks[index]);
                                    // });
                                  },
                                );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      });
    });
  }
}
