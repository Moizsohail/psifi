import 'dart:io';
import 'package:image/image.dart';
Future<File> thumbnail(File e,{width:200}) async{
  final Directory tempDir = Directory.systemTemp;
  Image image = decodeImage(e.readAsBytesSync());
  Image thumbnail = copyResize(image,width: width);
  String filename = e.path.split('/').removeLast().split('.')[0];
  print(filename);
  File('${tempDir.path}/$filename.png').writeAsBytesSync(encodePng(thumbnail));
  return File('${tempDir.path}/$filename.png');
}
