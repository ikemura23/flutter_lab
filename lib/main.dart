import 'package:flutter/material.dart';
import 'package:flutter_lab/sample_model.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider<SampleModel>(
        create: (context) => SampleModel()..fetchSampleItem(),
        child: MyHomePage2(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage2 extends StatelessWidget {
  MyHomePage2({Key key, this.title}) : super(key: key);

  final String title;
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: Center(
        child: _buildText(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildText() {
    // Consumerにはアクセスしたいモデルの種類を指定するため、ジェネリックで<SampleModel>と書く
    return Consumer<SampleModel>(
      builder: (context, model, child) => InkWell(
        onTap: model.fetchSampleItem,
        child: Center(
          child: Text(
            "count: ${model.item.id}",
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
//
//class MyHomePage extends StatefulWidget {
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  final String title;
//
//  @override
//  _MyHomePageState createState() => _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(widget.title),
//      ),
//      body: Center(
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          children: <Widget>[
//            Text(
//              'You have pushed the button this many times:',
//            ),
//            Text(
//              '$_counter',
//              style: Theme.of(context).textTheme.display1,
//            ),
//          ],
//        ),
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ),
//    );
//  }
//}
