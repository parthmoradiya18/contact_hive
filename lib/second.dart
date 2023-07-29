import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:student_from/main.dart';
import 'package:student_from/my_class.dart';

class second extends StatefulWidget {
  const second({Key? key}) : super(key: key);

  @override
  State<second> createState() => _secondState();
}

class _secondState extends State<second> {
  Box box = Hive.box("level");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add student From"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Home();
                }));
              },
              icon: Icon(Icons.home))
        ],
      ),
      body: ListView.builder(
        itemCount:  box.length,
        itemBuilder: (BuildContext context, int index) {
          my_class z = box.getAt(index);
          return Card(color: Colors.grey,
            margin: EdgeInsets.all(5),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: FileImage(File("${z.image}")),
              ),
              title: Text("${z.name}"),
              subtitle: Text("${z.contact} \n ${z.email} \n ${z.pass}" ),
            //  subtitle: Text("${z.contact} | ${z.email} | ${z.pass} |${z.city}" ),
              trailing: Wrap(children: [
                IconButton(onPressed: () {
                  box.deleteAt(index);
                  File f1 = File("${z.image}");
                  print(f1.path);
                  f1.delete();
                  setState(() { });

                }, icon: Icon(Icons.delete)),

                IconButton(onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return Home(z);
                  }));
                  setState(() { });

                }, icon: Icon(Icons.edit)),

              ],),
            ),
          );
        },
      ),
    );
  }
}
