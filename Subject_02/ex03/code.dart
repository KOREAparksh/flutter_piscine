import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

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
        primaryColor: Colors.blue,
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
  bool _switch = false;
  final List<double> _data = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("BMI Calculator"),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textFormFieldForm(
                  hint: "Input Height(cm)",
                  validator: (v) =>
                      (v != null && v != "") ? null : "Input Height",
                  onSaved: (v) => _data.add(double.parse(v)),
                ),
                const SizedBox(height: 20),
                _textFormFieldForm(
                  hint: "Input Weight(kg)",
                  isPassword: _switch,
                  validator: (v) =>
                      (v != null && v != "") ? null : "Input Weight",
                  onSaved: (v) => _data.add(double.parse(v)),
                ),
                const SizedBox(height: 20),
                CupertinoSwitch(
                  value: _switch,
                  onChanged: (v) => setState(() {
                    _switch = v;
                  }),
                ),
                Text("Weight: " + ((_switch) ? "**" : "digit")),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _data.clear();
                        _formKey.currentState!.save();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    OutPutScreen(data: _data)));
                      } else
                        _snackBarMessage("Error");
                    },
                    child: const Text("Calculation"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFormFieldForm({
    required String hint,
    required Function validator,
    required Function onSaved,
    bool isPassword = false,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hint,
      ),
      keyboardType: TextInputType.number,
      obscureText: isPassword,
      validator: (v) => validator(v),
      onSaved: (v) => onSaved(v),
    );
  }

  void _snackBarMessage(String str) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(str),
      duration: Duration(milliseconds: 700),
    ));
  }
}

class OutPutScreen extends StatelessWidget {
  const OutPutScreen({Key? key, required this.data}) : super(key: key);

  final List<double> data;
  final min = 0.0;
  final max = 45.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BMI result")),
      body: _gauge(),
    );
  }

  Widget _gauge() {
    final value = data[1] / ((data[0] / 100) * (data[0] / 100));
    print((data[0] / 1000));
    print(value);
    return SfRadialGauge(
      axes: [
        RadialAxis(
          minimum: min,
          maximum: max,
          showLabels: true,
          interval: 5.0,
          axisLabelStyle: GaugeTextStyle(color: Colors.black45),
          majorTickStyle: MajorTickStyle(color: Colors.black87),
          ranges: [
            GaugeRange(
              startValue: min,
              endValue: 18.5,
              label: "저체중",
              color: Colors.blue,
            ),
            GaugeRange(
              startValue: 18.5,
              endValue: 23,
              label: "정상",
              color: Colors.green,
            ),
            GaugeRange(
              startValue: 23,
              endValue: 25,
              label: "과체중",
              color: Colors.orange,
            ),
            GaugeRange(
              startValue: 25,
              endValue: 30,
              label: "비만",
              color: Colors.redAccent,
            ),
            GaugeRange(
              startValue: 30,
              endValue: 35,
              label: "중도비만",
              color: Colors.red,
            ),
            GaugeRange(
              startValue: 35,
              endValue: max,
              label: "고도비만",
              color: Colors.black,
            ),
          ],
          pointers: [
            NeedlePointer(
              value: value,
              needleColor: Colors.black,
              knobStyle: const KnobStyle(color: Colors.black),
              enableAnimation: true,
              animationType: AnimationType.ease,
            ),
          ],
          annotations: [
            GaugeAnnotation(
              widget: Container(
                child: Text(
                  "BMI: " + value.toStringAsFixed(1),
                  style: TextStyle(
                    color: Colors.black38,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              angle: 90,
              positionFactor: 0.5,
            ),
          ],
        ),
      ],
    );
  }
}
