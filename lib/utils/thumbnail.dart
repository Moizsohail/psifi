import 'dart:io';
import 'package:image/image.dart';
Future<File> thumbnail(File e) async{
  final Directory tempDir = Directory.systemTemp;
  Image image = decodeImage(e.readAsBytesSync());
  Image thumbnail = copyResize(image,width: 200);
  String filename = e.path.split('/').removeLast().split('.')[0];
  File('${tempDir.path}/$filename.png')..writeAsBytesSync(encodePng(thumbnail));
  return File('${tempDir.path}/${filename}.png');
}
