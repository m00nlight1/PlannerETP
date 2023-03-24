import 'package:flutter/material.dart';
import 'package:planner_etp/app/presentation/components/AuthTextField.dart';
import 'package:planner_etp/feature/profile/profile_screen.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  final titleController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2028),
    ).then((value) {
      setState(() {
        _startDate = value!;
        _endDate = value!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Создать задачу"),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                )),
            icon: const Icon(Icons.account_circle),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Column(
              children: [
                //title
                AuthTextField(
                    hintText: 'Название',
                    obscureText: false,
                    prefixIcon: const Icon(Icons.rate_review_outlined, color: Color(0xFF0d74ba)),
                    controller: titleController,
                    validator: (title) =>
                        title != null ? 'Введите название' : null),
                const SizedBox(height: 10),
                //datetime
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //start of work
                    Card(
                      color: Colors.grey.shade200,
                      child: SizedBox(
                        width: 166,
                        height: 135,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Начало работ', style: theme.textTheme.headlineSmall),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.date_range_outlined,
                                      color: Color(0xFF0d74ba)),
                                  const SizedBox(width: 5),
                                  Text(_startDate.toString().split(" ")[0]),
                                ],
                              ),
                              MaterialButton(
                                onPressed: _showDatePicker,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Text(
                                    'Установить\nвремя',
                                    style: theme.textTheme.labelMedium, textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    //end of work
                    Card(
                      color: Colors.grey.shade200,
                      child: SizedBox(
                        width: 166,
                        height: 135,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Окончание работ', style: theme.textTheme.headlineSmall),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  const Icon(Icons.date_range_outlined,
                                      color: Color(0xFF0d74ba)),
                                  const SizedBox(width: 5),
                                  Text(_endDate.toString().split(" ")[0]),
                                ],
                              ),
                              MaterialButton(
                                onPressed: _showDatePicker,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                  child: Text(
                                    'Установить\nвремя',
                                    style: theme.textTheme.labelMedium, textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
