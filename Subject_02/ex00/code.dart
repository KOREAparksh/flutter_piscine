import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Check In"),
        ),
        body: Container(
          margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                _textFormList(),
                _divider(),
                _button(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFormList() {
    return TextFormField(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: "카드 번호를 입력하세요.",
      ),
      keyboardType: TextInputType.number,
      validator: (value) =>
          (value != null && value == "42") ? null : "입력이 올바르지 않습니다.",
    );
  }

  Widget _divider() {
    return Container(
      height: 1,
      color: Colors.grey,
      margin: EdgeInsets.only(top: 50, bottom: 50),
    );
  }

  Widget _button(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          FocusScope.of(context).unfocus();
          _formKey.currentState!.validate()
              ? _snackBarMessage("Check in Success")
              : _snackBarMessage("Check in Fail");
        },
        child: const Text("CHECK IN"),
      ),
    );
  }

  void _snackBarMessage(String str) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(str),
      duration: Duration(milliseconds: 700),
    ));
  }
}
