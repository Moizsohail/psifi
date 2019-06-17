import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class CachedImageProvider {
  
  Map<String,dynamic> _urls = {};
  final Directory tempDir = Directory.systemTemp;
  
  Future<bool> addName(String name) async{
    if (_urls.containsKey(name)){
      return false;
    }
    _urls[name] = null;
    return await this.downloadByName(name);
  }
  Future<bool> downloadByName(String fileName) async{
    File file = File('${tempDir.path}/$fileName');
    
    if (await file.exists()){
      _urls[fileName] = ExactAssetImage(
        "${tempDir.path}/$fileName"
      );
      
      return false;
    }
    
    final StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
    final StorageFileDownloadTask downloadTask = ref.writeToFile(file);
    int _ = (await downloadTask.future).totalByteCount;
    
    _urls[fileName] = ExactAssetImage(
      "${tempDir.path}/$fileName"
    );
    return true;

  }
  ImageProvider getImage(String name)=> _urls[name];
  
}