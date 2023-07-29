import 'dart:io';
import 'dart:math';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:student_from/my_class.dart';
import 'package:student_from/second.dart';
import 'package:flutter/src/material/dropdown.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  Hive.registerAdapter(myclassAdapter());
  Hive.init(appDocumentsDir.path);
 var box = await Hive.openBox('level');

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  my_class? z;

  Home([this.z]);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Box box = Hive.box("level");
  ImagePicker picker = ImagePicker();
  XFile? image;

  TextEditingController text1 = TextEditingController();
  TextEditingController text2 = TextEditingController();
  TextEditingController text3 = TextEditingController();
  TextEditingController text4 = TextEditingController();

  //String str = "surat";
  String gend = "male";
  bool temp1 = false, temp2 = false, temp3 = false;
  bool error_name =false, error_contact = false, error_email = false, error_pass = false;
  bool is_images = false;

  @override
  void initState() {
    get();
    if (widget.z != null) {
      text1.text = widget.z!.name;
      text2.text = widget.z!.contact;
      text3.text = widget.z!.email;
      text4.text = widget.z!.pass;
      gend = widget.z!.gender;
      //str = widget.z!.city;
      List l = widget.z!.skill.split("/");
      if (l.contains("Flutter")) {
        temp1 = true;
      }
      if (l.contains("Android")) {
        temp2 = true;
      }
      if (l.contains("Php")) {
        temp3 = true;
      }
    }
  }

  get() async {
    var status = await Permission.camera.status;
    var status1 = await Permission.storage.status;

    if (status.isDenied && status1.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.camera,
        Permission.storage,
      ].request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student from"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: TextField(
                controller: text1,
                decoration: InputDecoration(errorText:  (error_name) ? "Enter your Name" : null,
                    hintText: "Enter Name : ", labelText: "Enter Name"),
              ),
            ),
            Card(
              child: TextField(
                controller: text2,
                decoration: InputDecoration(errorText:  (error_contact) ? "Enter your Contact" : null,
                    hintText: "Enter Contact : ", labelText: "Enter Contact"),
              ),
            ),
            Card(
              child: TextField(
                controller: text3,
                decoration: InputDecoration(errorText:  (error_email) ? "Enter your Email" : null,
                    hintText: "Enter Email : ", labelText: "Enter Email"),
              ),
            ),
            Card(
              child: TextField(
                controller: text4,
                decoration: InputDecoration(errorText:  (error_pass) ? "Enter your Pass" : null,
                    hintText: "Enter Password : ", labelText: "Enter password"),
              ),
            ),
            // Text(
            //   "Select city",
            //   style: TextStyle(fontSize: 20),
            // ),
            // DropdownButton(icon: Icon(Icons.arrow_circle_down),value: str,
            //   items: [
            //     DropdownMenuItem(child: Text("surat"), value: "surat",),
            //     DropdownMenuItem(child: Text("baroda"),value: "baroda",),
            //
            //   ], onChanged: (value) {
            //     setState(() {
            //       str=value.toString();
            //     });
            //   },),

            Center(
              child: Text(
                "Gender",
                style: TextStyle(fontSize: 25),
              ),
            ),

            Row(
              children: [
                Radio(
                    value: "male",
                    groupValue: gend,
                    onChanged: (value) {
                      setState(() {
                        gend = value.toString();
                      });
                    }),

                Text(
                  "Male",
                  style: TextStyle(fontSize: 20),
                ),

                Radio(
                    value: "Famale",
                    groupValue: gend,
                    onChanged: (value) {
                      setState(() {
                        gend = value.toString();
                      });
                    }),

                Text(
                  "Famale",
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            Center(
              child: Text(
                "Skill",
                style: TextStyle(fontSize: 25),
              ),
            ),

            Row(
              children: [
                Checkbox(
                    value: temp1,
                    onChanged: (value) {
                      setState(() {
                        // temp1 = value!;
                        temp1 = value as bool;
                      });
                    }),

                Text(
                  "Flutter",
                  style: TextStyle(fontSize: 25),
                ),

                Checkbox(
                    value: temp2,
                    onChanged: (value) {
                      setState(() {
                        // temp2 = value!;
                        temp2 = value as bool;
                      });
                    }),

                Text(
                  "Android",
                  style: TextStyle(fontSize: 25),
                ),

                Checkbox(
                    value: temp3,
                    onChanged: (value) {
                      setState(() {
                        //  temp3 = value!;
                        temp3 = value as bool;
                      });
                    }),

                Text(
                  "Php",style: TextStyle(fontSize: 25),
                ),

              ],
            ),

            ElevatedButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Upload image"),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  image = await picker.pickImage(
                                      source: ImageSource.camera);
                                  is_images = true;
                                  Navigator.pop(context);
                                  setState(() {});
                                },
                                child: Text("Camera")),
                            TextButton(
                                onPressed: () async {
                                  image = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  is_images = true;
                                  Navigator.pop(context);

                                  setState(() {});
                                },
                                child: Text("Gallery")),
                          ],
                        );
                      });
                },
                child: Text("Upload image")),
            Container(
              height: 100,
              width: 100,
              child: (widget.z != null)
                  ?(is_images)
                  ? Image.file(File(image!.path)) :
              Image.file(File(widget.z!.image))
                  : (image != null)
                  ? Image.file(File(image!.path))
                  : Icon(Icons.account_circle_outlined),
            ),

            ElevatedButton(
                onPressed: () async {
                  String name, contact, email, pass, skill, image_na,image_path;
                  name = text1.text;
                  contact = text2.text;
                  email = text3.text;
                  pass = text4.text;
                  error_name=false;
                  error_contact=false;
                  error_email=false;
                  error_pass=false;
                  String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
                  RegExp regExp = new RegExp(patttern);
                  if(name == "")
                    {
                      error_name=true;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter your Name ")));
                      setState(() { });
                    }
                 else if(contact == "")
                  {
                    error_contact=true;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter your Contact")));
                    setState(() { });
                  }
                 else if(!regExp.hasMatch(contact))
                   {
                      error_contact=true;
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter your Contact")));
                      setState(() { });
                   }
                 else if(email == "")
                  {
                    error_email=true;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter your Email ")));
                    setState(() { });
                  }
                 else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(email))
                   {
                     error_email=true;
                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter your Email ")));
                     setState(() { });
                   }
                 else if(pass == "")
                  {
                    error_pass=true;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter your Password ")));
                    setState(() { });
                  }
                  else if(!RegExp(
                      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                      .hasMatch(pass))
                  {
                    error_pass=true;
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter your password ")));
                    setState(() { });
                  }
                 else
                   {
                     StringBuffer s_b = StringBuffer();
                     if(temp1 == true)
                     {
                       s_b.write("Flutter");
                     }
                     if(temp2 == true)
                     {
                       if(s_b.length >0)
                       {
                         s_b.write("/");
                       }
                       s_b.write("Android");
                     }
                     if(temp3 == true)
                     {
                       if(s_b.length >0)
                       {
                         s_b.write("/");
                       }
                       s_b.write("Php");
                     }
                     skill = s_b.toString();
                     image_na = "img${Random().nextInt(1000)}.jpg";

                     var path =
                         await ExternalPath.getExternalStoragePublicDirectory(
                             ExternalPath.DIRECTORY_DOWNLOADS) +
                             "/parth_image";
                     Directory dir = Directory(path);
                     if (!await dir.exists()) {
                       dir.create();
                     }
                     if(widget.z != null)
                     {
                       if(is_images == true)
                       {
                         File f1 = File("${widget.z!.image}");
                         f1.delete();
                         File file = File("${dir.path}/$image_na");
                         image_path = file.path;
                         file.writeAsBytes(await image!.readAsBytes());
                       }
                       else
                       {
                         image_path =widget.z!.image;
                       }
                     }
                     else
                     {
                       if(is_images == true)
                       {
                         File file = File("${dir.path}/$image_na");
                         image_path = file.path;
                         file.writeAsBytes(await image!.readAsBytes());
                       }
                       else
                       {
                         image_path = "";
                         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Upload you images..")));
                       }
                     }
                     if(widget.z!=null)
                     {
                       widget.z!.name = name;
                       widget.z!.contact = contact;
                       widget.z!.email = email;
                       widget.z!.pass = pass;
                       widget.z!.gender=gend;
                       widget.z!.skill= skill;
                    //   widget.z!.city=str;
                       widget.z!.image=image_path;
                       widget.z!.save();
                     }
                     else
                     {
                       if(is_images)
                       {
                         my_class z = my_class(name, contact, email, pass, gend, skill, image_path);
                        // my_class z = my_class(name, contact, email, pass, str, gend, skill, image_path);
                         box.add(z);
                       }
                     }
                   }
                },
                child: (widget.z != null) ? Text("Update"):Text("Add")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return second();
                  }));
                },
                child: Text("view")),
          ],
        ),
      ),
    );
  }
}
