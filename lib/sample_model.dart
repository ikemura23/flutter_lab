import 'package:flutter/foundation.dart';
import 'package:flutter_lab/sample_item.dart';

class SampleModel extends ChangeNotifier {
  SampleItem item = SampleItem(id: 0, name: "zappa");

  void fetchSampleItem() {
    item = SampleItem(id: item.id + 1, name: "${item.name}");
    notifyListeners();
  }
}
