import 'package:flutter/material.dart';
import 'package:flutter_lab/sample_item.dart';
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

  @override
  Widget build(BuildContext context) {
    // context.selectで状態クラスにアクセスする
    final item = context.select((SampleModel model) => model.item);

    // context.watch 変更を監視する
    // context.select は監視対象を変数１つに絞れる（基本的にはこっちを使う）
    // context.read は変更を監視しない
    // 参考 https://ja.unflf.com/tech/flutter/provider/

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: _buildText(item),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<SampleModel>().fetchSampleItem();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildText(SampleItem item) {
    return Center(
      child: Column(
        children: <Widget>[
          Text(
            "id: ${item.id}",
            style: TextStyle(fontSize: 30),
          ),
          Text(
            "name: ${item.name}",
            style: TextStyle(fontSize: 30),
          ),
        ],
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
