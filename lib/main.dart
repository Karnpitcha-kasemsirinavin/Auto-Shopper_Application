import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:app_draft1/List_item.dart';
import 'package:app_draft1/Item.dart';
import 'package:flutter/material.dart';

// firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
//   runApp(const MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    ); // MaterialApp
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initSate
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //logo here
          Image.asset('assets/logo.png'),
          // SizedBox(height: 20,),
          // loading circle [below]
          //  CircularProgressIndicator(
          //    valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
          //  )
        ],
      )),
    );
  }
}

bool check_display(String amount) {
  bool display = true;

  if (amount == "0") {
    display = false;
  }
  return display;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

Future<String> getData() async {
  await Future.delayed(const Duration(seconds: 0));
  return 'It Works';
}

class _HomePageState extends State<HomePage> {
  late Query _ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ref = FirebaseDatabase.instance.ref("RFID_Data");
    // .orderByChild("Box_image");
  }

  Widget _buildItem({required Map data}) {
    return Container(
        width: 370,
        height: 100,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.deepPurpleAccent.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3))
        ]),
        child: Stack(children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                data['Box_image'],
                fit: BoxFit.cover,
                // color: Colors.white,
              ),
            ),
          ),
          Container(
              width: 75,
              height: 75,
              margin: const EdgeInsets.only(top: 10, left: 8),
              child: Stack(children: [
                // Image
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      data['Item_img'],
                      fit: BoxFit.fill,
                      // color: Colors.white,
                    ),
                  ),
                ),
              ])),
          //Label
          Container(
              // width: 100,
              // height: 1000,
              margin: const EdgeInsets.only(top: 40, left: 100),
              child: Text(
                data['Name'],
                style: const TextStyle(color: Colors.black, fontSize: 18),
              )),
          // Amount
          Container(
              // width: 100,
              // height: 1000,
              margin: const EdgeInsets.only(top: 40, left: 225),
              child: Text(
                data['Amount'],
                style: const TextStyle(color: Colors.black, fontSize: 18),
              )),
          //Price
          Container(
              // width: 100,
              // height: 1000,
              margin: const EdgeInsets.only(top: 40, left: 300),
              child: Text(
                data["Price"] + " baht",
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ))
        ]));
  }

  late final total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Align(
              // alignment: Alignment.center,
              child: Text("My Cart",
                  style: TextStyle(
                      color: Colors.deepPurpleAccent,
                      fontWeight: FontWeight.bold)),
            )),
        body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/home_bg.jpg"), fit: BoxFit.cover),
            ),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                child: Container(
                    height: 70,
                    color: Colors.black26,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 0, left: 30, right: 30),
                      child: Row(
                        children: const [
                          Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Item",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                          Spacer(),
                          Spacer(),
                          Spacer(),
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Amount",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                          Spacer(),
                          Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Price",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ))
                        ],
                      ),
                    )),
              ),
              Expanded(
                  child: FirebaseAnimatedList(
                query: _ref,
                itemBuilder: (BuildContext context, DataSnapshot snapshot,
                    Animation<double> animation, int index) {
                  Map dataRfid = snapshot.value as Map;
                  bool display = check_display(dataRfid['Amount']);
                  if (display == true) {
                    return _buildItem(data: dataRfid);
                  } else {
                    return Container();
                  }
                },
              )),
              Container(
                  height: 60,
                  child: FirebaseAnimatedList(
                      query: _ref,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        Map dataRfid = snapshot.value as Map;
                        if (dataRfid["Total"] != null) {
                          return Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  height: 60,
                                  color: Colors.white,
                                  width: MediaQuery.of(context).size.width,
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, left: 30, right: 30),
                                      child: Row(children: [
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "Total:   ${dataRfid['Total']}",
                                              style: const TextStyle(
                                                  color:
                                                      Colors.deepPurpleAccent,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                        Spacer(),
                                        Align(
                                            child: ElevatedButton.icon(
                                                onPressed: () async {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const ResetScreen()));
                                                  DatabaseReference ref =
                                                      FirebaseDatabase.instance
                                                          .ref("RFID_Data");
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors
                                                              .deepPurpleAccent),
                                                ),
                                                icon: const Icon(
                                                  Icons.shopping_cart,
                                                  size: 25.0,
                                                ),
                                                label: const Text(
                                                  "Proceed",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                )))
                                      ]))));
                        } else {
                          return Container();
                        }
                      }))
            ])));
  }
}

class ResetScreen extends StatelessWidget {
  const ResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "Checkout",
            style: TextStyle(
                color: Colors.deepPurpleAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          titleSpacing: (MediaQuery.of(context).size.width) * 0.25,
        ),
        body: Container(
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/home_bg.jpg"), fit: BoxFit.cover),
            ),
            // child: Column(children: [
            child: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.only(left: 100, right: 100),
                      child: Container(
                          height: 500,
                          width: 500,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/smile.png"),
                          )),
                          child: Column(children: const [
                            Padding(
                                padding: EdgeInsets.only(top: 350),
                                child: Text(
                                  "Go to cashier and enjoy your shopping",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                ))
                          ])))
                ]))));
  }
}
