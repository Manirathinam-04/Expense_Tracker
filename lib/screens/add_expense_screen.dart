import 'package:demo1/model/expense_model.dart';
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpenseScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  final _formKey = GlobalKey<FormState>();

  void showDatepicker() async {
    final pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: _selectedDate ?? DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }

    print("Selected Date $pickedDate");
  }

  void submitForm() {
    if ((_formKey.currentState?.validate() ?? false) && _selectedDate != null) {
      final title = _titleController.text;
      final amount = double.parse(_amountController.text);
      // print("Title:  $title , Amount: $amount, Date: $_selectedDate");

      // final newExpense = {
      //   "title": title,
      //   "amount": amount,
      //   "date": _selectedDate,
      // };

      final newExpense = ExpenseModel(
        title: title,
        amount: amount,
        date: _selectedDate,
      );
      Navigator.pop(context, newExpense);
    }
  }

  void resetForm() {
    _formKey.currentState?.reset();
    _titleController.clear();
    _amountController.clear();
    setState(() {
      _selectedDate = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Expense")),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: "Title"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Title is required";
                }
                return null;
              },
            ),
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Amount"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Amount is required";
                }
                if (double.tryParse(value) == null) {
                  return "Enter a number";
                }
                return null;
              },
            ),
            Text(
              _selectedDate == null
                  ? "No Date chosen"
                  : "Picked Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
            ),
            TextButton(
              onPressed: () => showDatepicker(),
              child: Text("Choose Date"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => submitForm(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigoAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text("Add Expense"),
                ),
                SizedBox(width: 15.0),
                ElevatedButton(
                  onPressed: () => resetForm(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Reset"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
