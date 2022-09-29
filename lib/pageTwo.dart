import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PageThree extends StatelessWidget {
  const PageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  late TextEditingController _controller;
  TextEditingController dateInput = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text("Settings", style: TextStyle(fontSize: 40)),
        ),
        Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                    labelText: "Name", border: OutlineInputBorder()),
                onSubmitted: (String value) async {})),
        Padding(
          padding: EdgeInsets.all(16.0),
          child: TextField(
              controller: dateInput,
              decoration: const InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: "Enter Date" //label text of field
                  ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now());

                if (pickedDate != null) {
                  print(pickedDate);
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(formattedDate);
                  setState(() {
                    dateInput.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {}
              }),
        ),
        Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: const [
                Expanded(child: CheckStat(title: 'Yes')),
                Expanded(child: CheckStat(title: 'No'))
              ],
            ))
      ]),
    );
  }
}

class CheckStat extends StatefulWidget {
  final String title;

  const CheckStat({Key? key, required this.title}) : super(key: key);

  @override
  Check createState() => Check();
}

class Check extends State<CheckStat> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.title),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = !isChecked;
        });
      },
    );
  }
}
