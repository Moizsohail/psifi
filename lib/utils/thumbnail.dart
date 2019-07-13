import 'dart:io';
import 'package:image/image.dart';
Future<File> thumbnail(e) async{
  final Directory tempDir = Directory.systemTemp;
  Image image = decodeImage(e.readAsBytesSync());
  Image thumbnail = copyResize(image,width: 280);
  File('${tempDir.path}/thumbnail.png')..writeAsBytesSync(encodePng(thumbnail));
  return File('${tempDir.path}/thumbnail.png');
}
