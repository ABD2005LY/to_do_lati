import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
import 'package:to_do_lati/models/task_model.dart';
import 'package:to_do_lati/provider/task_provider.dart';
import 'package:to_do_lati/widgets/cards/task_card.dart';
import 'package:to_do_lati/widgets/cilkckables/drawer.dart';
import 'package:to_do_lati/widgets/dialog/task_dialog.dart';
import 'package:to_do_lati/provider/dark_mode_provider.dart';
=======
import 'package:to_do_lati/cards/task_card.dart';
import 'package:to_do_lati/clicables/drawer_tile.dart';
import 'package:to_do_lati/dialog/task_dialog.dart';
import 'package:to_do_lati/models/task_model.dart';
import 'package:to_do_lati/providers/dark_mode_provider.dart';
import 'package:to_do_lati/providers/tasks_provider.dart';
import 'package:to_do_lati/screens/task_details_screen.dart';
>>>>>>> f2094da211d533c09a9cc58779dada9bf0c6b65d

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskSubtitleController = TextEditingController();
<<<<<<< HEAD
  @override
  void initState() {
    super.initState();
=======
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Provider.of<TasksProvider>(context, listen: false).getTasks();
    Provider.of<DarkModeProvider>(context, listen: false).getMode();
>>>>>>> f2094da211d533c09a9cc58779dada9bf0c6b65d
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
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
=======
    return Consumer2<DarkModeProvider, TasksProvider>(
      builder: (context, darkModeProvider, tasksProvider, child) {
        return Scaffold(
          drawer: Drawer(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  DrawerTile(
                    icon: darkModeProvider.isDark
                        ? Icons.dark_mode
                        : Icons.light_mode,
                    text: darkModeProvider.isDark ? "Dark Mode" : "Light Mode",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                          darkModeProvider.isDark
                              ? Icons.dark_mode
                              : Icons.light_mode,
                          color: darkModeProvider.isDark
                              ? Colors.white
                              : Colors.black),
                      SizedBox(
                        width: 250,
                        child: SwitchListTile(
                          activeColor: darkModeProvider.isDark
                              ? Colors.white
                              : Colors.black,
                          title: Text(
                            darkModeProvider.isDark == true
                                ? "Dark Mode"
                                : "Light Mode",
                            style: TextStyle(
                                color: darkModeProvider.isDark
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          value: darkModeProvider.isDark,
                          onChanged: (value) {
                            darkModeProvider.SwitchMode();
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          appBar: AppBar(
            backgroundColor: Colors.blue,
            centerTitle: true,
            title: const Text(
              "TO DO Lati",
              style: TextStyle(color: Colors.white),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor:
                darkModeProvider.isDark ? Colors.white : Colors.blue,
            child: Icon(Icons.add,
                color: darkModeProvider.isDark ? Colors.blue : Colors.white),
>>>>>>> f2094da211d533c09a9cc58779dada9bf0c6b65d
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AddTaskDialog(
                    titleController: taskTitleController,
                    subTitleController: taskSubtitleController,
                    formKey: formKey,
                    onTap: () {
<<<<<<< HEAD
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
=======
                      if (formKey.currentState!.validate()) {
                        Provider.of<TasksProvider>(context, listen: false)
                            .addTask(
                          TaskModel(
                            title: taskTitleController.text,
                            subtitle: taskSubtitleController.text.isEmpty
                                ? null
                                : taskSubtitleController.text,
                            createdAt: DateTime.now(),
                          ),
                        );
                        taskTitleController.clear();
                        taskSubtitleController.clear();
                        Navigator.pop(context);
                      }
>>>>>>> f2094da211d533c09a9cc58779dada9bf0c6b65d
                    },
                  );
                },
              );
            },
          ),
<<<<<<< HEAD
          appBar: AppBar(
            title: const Text("TODO"),
          ),
=======
>>>>>>> f2094da211d533c09a9cc58779dada9bf0c6b65d
          body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
<<<<<<< HEAD
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
=======
                TabBar(
                  labelColor:
                      darkModeProvider.isDark ? Colors.white : Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.blue,
                  tabs: const [
                    Tab(text: "Pending Tasks"),
                    Tab(text: "Completed Tasks"),
                  ],
                ),
>>>>>>> f2094da211d533c09a9cc58779dada9bf0c6b65d
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
<<<<<<< HEAD
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
=======
                      buildTaskList(tasksProvider, false, darkModeProvider),
                      buildTaskList(tasksProvider, true, darkModeProvider),
>>>>>>> f2094da211d533c09a9cc58779dada9bf0c6b65d
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
<<<<<<< HEAD
      });
    });
=======
      },
    );
  }

  Widget buildTaskList(TasksProvider tasksProvider, bool isCompleted,
      DarkModeProvider darkModeProvider) {
    final filteredTasks = tasksProvider.tasks
        .where((task) => task.isCompleted == isCompleted)
        .toList();

    if (filteredTasks.isEmpty) {
      return Center(
        child: Text(
          "No tasks available.",
          style: TextStyle(
              color: darkModeProvider.isDark ? Colors.white : Colors.black),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        return TaskCard(
          taskModel: filteredTasks[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TaskDetailsScreen(
                  taskModel: filteredTasks[index],
                ),
              ),
            );
          },
          onToggleComplete: () {
            Provider.of<TasksProvider>(context, listen: false)
                .switchValue(filteredTasks[index]);
          },
          delete: () {
            Provider.of<TasksProvider>(context, listen: false)
                .delete(filteredTasks[index]);
          },
        );
      },
    );
>>>>>>> f2094da211d533c09a9cc58779dada9bf0c6b65d
  }
}
