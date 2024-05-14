import 'dart:io';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int counter = 0;
  Future<String> getLocalPath() async{
    var folder = await getApplicationDocumentsDirectory();
    return folder.path;
  }
  Future<File> getLocalfile() async {
    String path = await getLocalPath();
    return File ('$path/counter.txt');
  }
  Future<File> writecounter(int c) async {
    File file =await getLocalfile();
    return file.writeAsString('$c');
  }
  Future<int> readcounter() async {
    try{
    final file =await getLocalfile();
    String content =await file.readAsString();
    return int.parse(content);
    }catch (e) {
      return 0 ;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readcounter().then((data) {
      setState(() {
        counter = data;
      });
    });
  }

    @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Read And Write files"),
      ),
      body: Center(
        child: Text("counter $counter"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        setState(() {
          counter++;
        });
        writecounter(counter);
      },child: Icon(Icons.add),),
    );
  }
}