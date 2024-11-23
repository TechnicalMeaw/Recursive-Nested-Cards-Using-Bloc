import 'package:flutter/material.dart';
import 'package:redoq_assignment/utils/color_constants.dart';

class AddEditCardScreen extends StatefulWidget {
  const AddEditCardScreen({super.key, required this.onSubmit, this.name, this.age});
  final Function(String, int) onSubmit;
  final String? name;
  final int? age;

  @override
  State<AddEditCardScreen> createState() => _AddEditCardScreenState();
}

class _AddEditCardScreenState extends State<AddEditCardScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _nameFocus = FocusNode();

  @override
  void initState() {
    _nameController.text = widget.name ?? "";
    _ageController.text = "${widget.age ?? ""}";
    _nameFocus.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Column(
                children: [
                  const SizedBox(height: 16),
                  TextField(
                    focusNode: _nameFocus,
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Submit button
              ElevatedButton(
                onPressed: () {
                  final name = _nameController.text;
                  final age = int.tryParse(_ageController.text) ?? 0;

                  if (name.isNotEmpty && age > 0) {
                    // Call the submit callback function
                    widget.onSubmit(name, age);

                    // Close the bottom sheet after submit
                    Navigator.pop(context);
                  } else {
                    // Show an error message if fields are empty or invalid
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill out all fields.')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.primaryColor),
                child: const Center(child: Text('Submit', style: TextStyle(fontWeight: FontWeight.w600, color: ColorConstants.backgroundColor),)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


