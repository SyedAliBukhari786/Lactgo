import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lactgo/products.dart';
import 'package:lactgo/profile.dart';
import 'package:lactgo/register.dart';
import 'package:lactgo/reviews.dart';
import 'package:lactgo/sales_tracker.dart';
import 'package:lactgo/sceh_orders.dart';
import 'package:lactgo/order_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    fetchReviewCount();
  }
int  reviewCount=0;
  int orderCount = 0;

  void fetchReviewCount() async {
    try {


      QuerySnapshot orderQuerySnapshot = await FirebaseFirestore.instance
          .collection('Orders')
          .where('Seller_id', isEqualTo: _user?.uid)
          .where('status', isEqualTo: "Pending")
          .get();

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Reviews')
          .where('Seller_id', isEqualTo: _user?.uid)
          .where('status', isEqualTo: "Unchecked")
          .get();

      setState(() {
        reviewCount = querySnapshot.size;
        orderCount=orderQuerySnapshot.size;
      });
    } catch (e) {
      print('Error fetching review count: $e');
    }
  }





  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    double ScreenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: ScreenWidth * 0.1 > 400 ? ScreenWidth * 0.15  : ScreenWidth * 0.18,
          title: Center(
              child: Text(
            'Home',
            style: TextStyle(
                fontSize:  ScreenWidth * 0.09 > 400 ? 30 : ScreenWidth * 0.09, fontWeight: FontWeight.bold,color: Colors.white),
          )),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60.0),
              bottomRight: Radius.circular(60.0),
            ),
          ),
          backgroundColor: Colors.orange,
        ),
        backgroundColor: Color(0xFF232F3E),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: ()  {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Products()),
                        );

                      },
                      child: Container(
                        width: ScreenWidth * 0.4 > 400 ? 400 : ScreenWidth * 0.4,
                        height: ScreenWidth * 0.4 > 800 ? 300 : ScreenWidth * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF0DC),
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                   // color: Colors.red,
                                    child: Icon(Icons.shopping_bag_rounded),
                                  )),
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                  //  color: Colors.blue,
                                    child: Text(
                                      "Products",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:ScreenWidth* 0.06 > 400 ? 200 : ScreenWidth *0.06,



                                      ),



                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width:  ScreenWidth*0.05,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Orderhistory()),
                        );
                      },
                      child: Container(
                        width: ScreenWidth * 0.4 > 400 ? 400 : ScreenWidth * 0.4,
                        height: ScreenWidth * 0.4 > 800 ? 300 : ScreenWidth * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF0DC),
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    // color: Colors.red,
                                    child: Icon(Icons.history),
                                  )),
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    //  color: Colors.blue,
                                    child: Text(
                                      "Order History",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:ScreenWidth* 0.05 > 400 ? 200 : ScreenWidth *0.06,



                                      ),



                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   GestureDetector(
                     onTap: () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => Sales_Tracker()),
                       );

                     },
                      child: Container(
                        width: ScreenWidth * 0.4 > 400 ? 400 : ScreenWidth * 0.4,
                        height: ScreenWidth * 0.4 > 800 ? 300 : ScreenWidth * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF0DC),
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    // color: Colors.red,
                                    child: Icon(Icons.auto_graph_sharp),
                                  )),
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    //  color: Colors.blue,
                                    child: Text(
                                      "Sales Tracker",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:ScreenWidth* 0.05 > 400 ? 200 : ScreenWidth *0.06,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width:  ScreenWidth*0.05,
                    ),
                    GestureDetector(onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfilePage()),
                      );



                    },
                      child: Container(
                        width: ScreenWidth * 0.4 > 400 ? 400 : ScreenWidth * 0.4,
                        height: ScreenWidth * 0.4 > 800 ? 300 : ScreenWidth * 0.4,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF0DC),
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    // color: Colors.red,
                                    child: Icon(Icons.person),
                                  )),
                              Expanded(
                                  flex: 5,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    //  color: Colors.blue,
                                    child: Text(
                                      "Profile",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:ScreenWidth* 0.06 > 400 ? 200 : ScreenWidth *0.06,



                                      ),



                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 10,
                ),

                GestureDetector(
                  onTap: ()  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Reviews()),
                    );

                  },
                  child: Container(
                    width: ScreenWidth * 0.8 > 400 ? 500 : ScreenWidth * 0.85,
                    height: ScreenHeight * 0.3 > 800 ? 100 : ScreenWidth * 0.3,
                    decoration: BoxDecoration(
                      color: Color(0xFFE8E3E3),
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                              flex: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "$reviewCount",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize:ScreenWidth* 0.05 > 400 ? 200 : ScreenWidth *0.08,
                                    ),
                                  ),
                                  Container(


                                    // color: Colors.red,
                                    child: Icon(Icons.message),
                                  ),
                                ],
                              )),
                          Expanded(
                              flex: 5,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                //  color: Colors.blue,
                                child: Text(
                                  "User Reviews",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:ScreenWidth* 0.05 > 400 ? 200 : ScreenWidth *0.05,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                GestureDetector(
                  onTap: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => schedule()),
                    );
                  },
                  child: Container(
                    width: ScreenWidth * 0.8 > 400 ? 500 : ScreenWidth * 0.85,
                    height: ScreenHeight * 0.3 > 800 ? 100 : ScreenWidth * 0.3,
                    decoration: BoxDecoration(
                      color: Color(0xFFE8E3E3),
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                              flex: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "$orderCount",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize:ScreenWidth* 0.05 > 400 ? 200 : ScreenWidth *0.08,
                                    ),
                                  ),
                                  Container(


                                    // color: Colors.red,
                                    child: Icon(Icons.watch_later_outlined),
                                  ),
                                ],
                              )),
                          Expanded(
                              flex: 5,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                //  color: Colors.blue,
                                child: Text(
                                  "Schedule Orders",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize:ScreenWidth* 0.05 > 400 ? 200 : ScreenWidth *0.05,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
