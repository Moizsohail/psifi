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
  FormDataRecorder();
  Future<bool> isExist() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/backup00.txt');
    return await file.exists();
  }

  createNew() async {
    List<dynamic> data = [
      null,
      null,
    ];
    await save(data);
  }

  save(List<dynamic> data) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/backup00.txt');
    String text = json.encode(data);
    await file.writeAsString(text);
  }

  read() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/backup00.txt');
    String text = await file.readAsString();
    print(text);
  }
}
