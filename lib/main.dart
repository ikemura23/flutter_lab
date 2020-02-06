import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _sliderValue = 0;
  double _customSliderValue = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//            Slider(
//              min: 0,
//              max: 100,
//              divisions: 9,
//              value: _sliderValue,
//              label: '${_sliderValue.floor()}',
//              onChanged: (d) =>
//                  setState(() {
//                    _sliderValue = d;
//                  }),
//            ),
            // non theme
            Slider(
              min: 0,
              max: 100,
              value: _customSliderValue,
              divisions: 10,
              label: '${_customSliderValue.floor()}',
              onChanged: (d) => setState(() {
                _customSliderValue = d;
              }),
            ),
            // theme customize
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 10,
                thumbColor: Colors.purpleAccent,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12),
                valueIndicatorColor: Colors.orange,
                overlayColor: Colors.orange.withAlpha(80),
                activeTrackColor: Colors.black,
                inactiveTrackColor: Colors.amber,
                inactiveTickMarkColor: Colors.blue,
                activeTickMarkColor: Colors.green,
              ),
              child: Slider(
                min: 0,
                max: 100,
                divisions: 10,
                value: _customSliderValue,
                label: '${_customSliderValue.floor()}',
                onChanged: (d) => setState(() {
                  _customSliderValue = d;
                }),
              ),
            )
          ],
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ),
    );
  }
}
