import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_lati/models/task_model.dart';
import 'package:to_do_lati/widgets/cards/task_card.dart';
import 'package:to_do_lati/providers/tasks_provider.dart';
import 'package:to_do_lati/widgets/cilkckables/drawer.dart';
import 'package:to_do_lati/widgets/dialog/task_dialog.dart';
import 'package:to_do_lati/screens/task_details_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_lati/providers/dark_mode_provider.dart';
import 'package:to_do_lati/providers/localization_provicder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskSubtitleController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    print("thisFunWorks");
    Provider.of<TasksProvider>(context, listen: false).getTasks();
    print(Provider.of<TasksProvider>(context, listen: false).tasks);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<DarkModeProvider, TasksProvider, LocalizationProvider>(
      builder: (context, darkModeProvider, tasksProvider, localizationProvider,
          child) {
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
                      text:
                          darkModeProvider.isDark ? "Dark Mode" : "Light Mode",
                      onTab: () {
                        Provider.of<LocalizationProvider>(context,
                            listen: false);
                      }),
                  GestureDetector(
                    child: DrawerTile(
                        text: AppLocalizations.of(context)!.english,
                        onTab: () {
                          Provider.of<LocalizationProvider>(context,
                                  listen: false)
                              .storelanguage("en");
                        },
                        icon: Icons.language),
                  ),
                  GestureDetector(
                    child: DrawerTile(
                        text: AppLocalizations.of(context)!.spanish,
                        onTab: () {
                          Provider.of<LocalizationProvider>(context,
                                  listen: false)
                              .storelanguage("es");
                        },
                        icon: Icons.language),
                  ),
                  GestureDetector(
                    child: DrawerTile(
                        text: AppLocalizations.of(context)!.arabic,
                        onTab: () {
                          Provider.of<LocalizationProvider>(context,
                                  listen: false)
                              .storelanguage("ar");
                        },
                        icon: Icons.language),
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
                                ? AppLocalizations.of(context)!.darkmode
                                : AppLocalizations.of(context)!.lightmode,
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
                  ),
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
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AddTaskDialog(
                    titleController: taskTitleController,
                    subTitleController: taskSubtitleController,
                    formKey: formKey,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        Provider.of<TasksProvider>(context, listen: false)
                            .addTask(
                          TaskModel(
                            title: taskTitleController.text,
                            subTitle: taskSubtitleController.text.isEmpty
                                ? null
                                : taskSubtitleController.text,
                            createdAt: DateTime.now(),
                          ),
                        );
                        taskTitleController.clear();
                        taskSubtitleController.clear();
                        Navigator.pop(context);
                      }
                    },
                  );
                },
              );
            },
          ),
          body: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                    labelColor:
                        darkModeProvider.isDark ? Colors.white : Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.blue,
                    tabs: [
                      Tab(text: AppLocalizations.of(context)!.waiting),
                      Tab(
                        text: AppLocalizations.of(context)!.completed,
                      )
                    ]),
                Expanded(
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      buildTaskList(tasksProvider, false, darkModeProvider),
                      buildTaskList(tasksProvider, true, darkModeProvider),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
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
          AppLocalizations.of(context)!.entertasksubtitle,
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
  }
}
