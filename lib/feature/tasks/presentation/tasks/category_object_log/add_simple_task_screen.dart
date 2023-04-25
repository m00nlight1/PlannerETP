import 'package:flutter/material.dart';

class AddSimpleTaskScreen extends StatefulWidget {
  const AddSimpleTaskScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddSimpleTaskScreenState();

}

class _AddSimpleTaskScreenState extends State<AddSimpleTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Simple'),),
    );
  }
}