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
        primaryColor: Colors.grey,
        primarySwatch: Colors.grey,
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
  double value = 90;
  final min = 0.0;
  final max = 150.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black38,
        title: Text("Fluent Gauge"),
      ),
      body: Container(
        color: Colors.black87,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _gauge(),
            const SizedBox(height: 20),
            _slider(),
          ],
        ),
      ),
    );
  }

  SfRadialGauge _gauge() {
    return SfRadialGauge(
      axes: [
        RadialAxis(
          minimum: min,
          maximum: max,
          showLabels: true,
          interval: 10.0,
          axisLabelStyle: GaugeTextStyle(color: Colors.white),
          majorTickStyle: MajorTickStyle(color: Colors.white54),
          minorTickStyle: MinorTickStyle(color: Colors.white54),
          ranges: [
            GaugeRange(
              startValue: min,
              endValue: max / 3 * 1,
              color: Colors.green,
            ),
            GaugeRange(
              startValue: max / 3 * 1,
              endValue: max / 3 * 2,
              color: Colors.orange,
            ),
            GaugeRange(
              startValue: max / 3 * 2,
              endValue: max,
              color: Colors.red,
            ),
          ],
          pointers: [
            NeedlePointer(
              value: value,
              needleColor: Colors.white,
              knobStyle: const KnobStyle(color: Colors.white),
              enableAnimation: true,
              animationType: AnimationType.ease,
            ),
          ],
          annotations: [
            GaugeAnnotation(
              widget: Container(
                child: Text(
                  value.toStringAsFixed(1),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              angle: 90,
              positionFactor: 0.7,
            ),
          ],
        ),
      ],
    );
  }

  Slider _slider() {
    return Slider(
      value: value,
      min: min,
      max: max,
      activeColor: Colors.green,
      inactiveColor: Colors.blueGrey,
      onChanged: (v) {
        value = v;
        setState(() {});
      },
    );
  }
}
