import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Категория"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          MaterialButton(
            onPressed: () => Navigator.of(context).pushNamed('/object-log'),
            child: Text('Журнал объекта', style: theme.textTheme.headlineSmall),
          ),
          const Divider(),
          MaterialButton(
            onPressed: () =>
                Navigator.of(context).pushNamed('/supervision-order'),
            child: Text('Предписание авторского надзора',
                style: theme.textTheme.headlineSmall),
          ),
          const Divider(),
          MaterialButton(
            onPressed: () => Navigator.of(context).pushNamed('/simple-task'),
            child: Text('Задача', style: theme.textTheme.headlineSmall),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
