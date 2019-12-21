import 'package:flutter/material.dart';

//class Form extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Material form demo',
//      home: CustomForm(),
//    );
//  }
//}

class CustomForm extends StatefulWidget {
  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  _printLatestValue() {
    print("Second text field : ${myController.text}");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                labelText: 'Username',
                hintText: '用户名',
                prefixIcon: Icon(Icons.account_circle)
              ),
              onChanged: (text) {
                print("first text field:$text");
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: '密码',
                prefixIcon: Icon(Icons.lock)
              ),
              controller: myController,
            ),
            RadioListTile(
              title: const Text('男'),
              value: 'ddd',
              groupValue: '000',
              onChanged: null,
            ),
            RadioListTile(
              title: const Text('女'),
              value: 'ddd',
              groupValue: '000',
              onChanged: null,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(myController.text),
                );
              });
        },
        tooltip: '获取数据框的值',
        child: Icon(Icons.edit),
      ),
    );
  }
}
