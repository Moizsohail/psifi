import 'dart:io';
import 'dart:convert';

import 'package:path_provider/path_provider.dart';

// decide on the data structure
/* 
  A class of list value pairs
  How do you plan on integerating the form with this
  The form will be constructed according to the elements in the csvReader?
  username it will be an object that stores
  or the csv should be created with elements from the 
*/
class FormDataRecorder {
  Future<bool> isExist() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/backup00.txt');
    return await file.exists();
  }

  createNew() async {
    Map<String, dynamic> data = {};
    await save(data);
  }

  save(Map<String, dynamic> data) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/backup00.txt');
    String text = json.encode(data, toEncodable: (item) {
      if (item is DateTime) return item.toIso8601String();
      return item;
    });
    await file.writeAsString(text);
  }

  Future<Map<String, dynamic>> read() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/backup00.txt');
    if (!await file.exists()) {
      return null;
    }
    String text = await file.readAsString();
    Map<String, dynamic> a = json.decode(text);
    print(a);
    return a;
  }
}
