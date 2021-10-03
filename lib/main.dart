import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:test_adplay/database.dart';
import 'package:test_adplay/shared_preference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Stream<QuerySnapshot> _studentsStream = FirebaseFirestore.instance.collection('students').snapshots();
  TextEditingController name=TextEditingController();
  TextEditingController age=TextEditingController();
  int id=0;
  // Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();
  addDialog(BuildContext c) {
    showDialog(
      context: c,
      builder: (c) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey[800],
          elevation: 24.0,
          title: Text(
            "Add Student Information",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          content: Container(
            //width: 100.0,
            height: 200.0,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: age,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Age',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    //width: width*0.25,
                    decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                    child: TextButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        //Navigator.of(context, rootNavigator: true).pop();
                        // Navigator.pop(buildContext);
                        // Navigator.pop(buildContext);
                        Navigator.of(context).pop();
                        // Navigator.of(c,rootNavigator: true).pop();
                        //_incrementCounter();// for fixing bug

                        //Navigator.of(context, rootNavigator: true).pop(context);
                        //Navigator.of(context).popUntil((route) => false);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                    //width: width*0.25,
                    child: TextButton(
                      child: Text(
                        "Add",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        //Database.addItem(name: name.text, age: age.text);
                        //Database.addUser(name.text, age.text);

                        SharedPreference.readData().then((value) {
                          id=value;
                        });
                       Database.addUser(name.text, age.text,id.toString()).whenComplete(() {

                         print(id);
                         id++;
                         SharedPreference.saveData(id);
                         Navigator.of(c).pop();
                       });
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
  editDialog(BuildContext c,String id) {
    showDialog(
      context: c,
      builder: (c) {
        return AlertDialog(
          backgroundColor: Colors.blueGrey[800],
          elevation: 24.0,
          title: Text(
            "Edit Student Information",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          content: Container(
            //width: 100.0,
            height: 200.0,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                      hintText: 'Enter Your Name',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: TextField(
                    controller: age,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Age',
                      hintText: 'Enter Your Age',
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    //width: width*0.25,
                    decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                    child: TextButton(
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();

                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                    //width: width*0.25,
                    child: TextButton(
                      child: Text(
                        "Edit",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        //Database.addItem(name: name.text, age: age.text);
                        //Database.addUser(name.text, age.text);
                        Database.addUser(name.text, age.text,id).whenComplete(() {
                          Navigator.of(c).pop();
                        });
                      },
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: _studentsStream,
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }

            return ListView(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                return InkWell(
                  onTap: (){
                    print(data['id']);
                  },
                  child: ListTile(
                    title: Text(data['name']),
                    subtitle: Text(data['age']),
                    trailing: FittedBox(
                      fit: BoxFit.cover,
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: (){
                              editDialog(context, data['id']);
                            },
                            iconSize: 40.0,
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: (){
                              Database.delete(data['id']);
                            },
                            iconSize: 40.0,
                          ),

                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          addDialog(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

