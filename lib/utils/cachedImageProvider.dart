import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:psifi/utils/thumbnail.dart';

class CachedImageProvider {
  Map<String,dynamic> _urls = {};
  final Directory tempDir = Directory.systemTemp;
  
  Future<bool> addName(String name) async{
    if (_urls.containsKey(name)){
      return false;
    }
    if (_urls[name] == 'downloading'){
      return false;
    }
    _urls[name] = null;
    return await this.downloadByName(name);
  }
  Future<bool> downloadByName(String fileName) async{
    //server gets a file in jpg
    File file = File('${tempDir.path}/$fileName.jpg');
    
    if (await File('${tempDir.path}/$fileName.png').exists()){
      _urls[fileName] = ExactAssetImage(
        "${tempDir.path}/$fileName.png"
      );
      print("exists");
      return true;
    }
    _urls[fileName] = 'downloading';
    final StorageReference ref = FirebaseStorage.instance.ref().child('$fileName.jpg');
    final StorageFileDownloadTask downloadTask = ref.writeToFile(file);
    int _ = (await downloadTask.future).totalByteCount;
    
    file = await thumbnail(file,width:600);
    _urls[fileName] = ExactAssetImage(
      file.path //already contains png from thumbnail
    );
    print("newly donwloaded");
    return true;

  }
  ImageProvider getImage(String name){ print(_urls[name]);return _urls[name]=='downloading'?null:_urls[name];}
  
}