import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({required this.onNewExpenseEntered, super.key});

  final void Function(Expense) onNewExpenseEntered;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text('Invalid input'),
              content: Text(
                'Please make sure a valid title, amount, date and category was entered.',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text('Okay'),
                ),
              ],
            ),
      );
      return;
    }
    widget.onNewExpenseEntered(
      Expense(
        title: _titleController.text.trim(),
        amount: enteredAmount,
        date: _selectedDate!,
        cotegory: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
            child: Column(
              children: [
                TextField(
                  controller: _titleController,
                  maxLength: 50,
                  decoration: InputDecoration(label: Text('Title')),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixText: '\$ ',
                          label: Text('Amount'),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            _selectedDate == null
                                ? 'No date selected'
                                : formatter.format(_selectedDate!),
                          ),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: Icon(Icons.calendar_month),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    DropdownButton(
                      value: _selectedCategory,
                      items:
                          Category.values
                              .map(
                                (value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: Text('Save Expense'),
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
