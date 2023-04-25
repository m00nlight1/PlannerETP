import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final List<String> _categories = ['Журнал объекта',
    'Предписание авторского надзора',
    'Задача'];
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Категория"),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(20),
          child: DropdownButton<String>(
            value: _selectedCategory,
            onChanged: (value) {
              setState(() {
                _selectedCategory = value;
              });
            },
            isExpanded: true,
            items: _categories.map((e) => DropdownMenuItem(
              value: e,
                child: Container(
                  child: Text(e),
                ),
            )).toList(),
          ),
        ),
      ),
    );
  }
}
