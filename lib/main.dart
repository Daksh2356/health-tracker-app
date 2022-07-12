import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  final _formKey = GlobalKey<FormState>();

  // final Auth _auth = Auth();
  String age = "";
  String bp = "";

  createTracker() {
    DocumentReference documentReference = FirebaseFirestore.instance.collection("My Tracker").doc();
    Map<String, String> userList = {" Age ": age , " bp ": bp};
    documentReference.set(userList,SetOptions(merge: true)).whenComplete(() => print('Data stored'));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Health Tracker App'),
          actions: <Widget>[
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.account_circle_outlined))
          ],
        ),
        body: Container(
          height: 600,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg.png"), fit: BoxFit.contain),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const <Widget>[
              Text("Add your today's health record below️",
                  style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Open Sans',fontSize: 20)),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    key: _formKey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: const Text('Today'),
                    content: Container(
                      width: 400,
                      height: 200,
                      child: Column(
                        children: [
                          TextField(
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Add your age'),
                              onChanged: (String value) {
                                age = value;
                              }),
                          const SizedBox(height: 10),
                          TextField(
                            decoration: InputDecoration.collapsed(
                                hintText: 'Add your bp'),
                            onChanged: (String value) {
                              bp = value;
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                          onPressed: ()  {
                            setState(() {
                              createTracker();
                            });
                  },
                          child: const Text('Add')),
                    ],
                  );
                });
          },
          child: const Icon(Icons.add_circle_sharp, color: Colors.white),
        ));
  }
}

