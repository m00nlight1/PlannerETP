import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?) onChange;

  const SearchTextField(
      {super.key, required this.controller, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Поиск...',
        labelText: 'Поиск',
        labelStyle: const TextStyle(color: Colors.black38),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.black38,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(25.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 1, color: Colors.black38),
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
      onChanged: onChange,
    );
  }
}
