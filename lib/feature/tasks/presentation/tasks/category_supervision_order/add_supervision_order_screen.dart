import 'package:flutter/material.dart';

class AddSupervisionOrderScreen extends StatefulWidget {
  const AddSupervisionOrderScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AddSupervisionOrderScreenState();

}

class _AddSupervisionOrderScreenState extends State<AddSupervisionOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Order'),),
    );
  }
}