

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class schedule extends StatefulWidget {
  const schedule({super.key});

  @override
  State<schedule> createState() => _scheduleState();
}

class _scheduleState extends State<schedule> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;

  Future<DocumentSnapshot<Map<String, dynamic>>> getProductDetails(
      String productId) {
    return _firestore.collection('Products').doc(productId).get();
  }
  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails(String userId) {
    return _firestore.collection('Users').doc(userId).get();
  }

  Future<void> deleteReview(String orderid) {
    return _firestore.collection('Orders').doc(orderid).delete();
  }

  Future<void> updateAllDocuments() async {
    // Initialize Firebase (make sure to call this before using Firestore)
    setState(() {
      _loading = true;
    });


    // Reference to the Firestore collection
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('Orders');

    // Get all documents in the collection
    QuerySnapshot querySnapshot = await collectionReference.where('Seller_id', isEqualTo: _user?.uid).get();

    // Update fields in each document
    querySnapshot.docs.forEach((doc) async {
      // Update the fields you want
      await collectionReference.doc(doc.id).update({
        'status': 'Done',

        // Add more fields as needed
      });
    });
    setState(() {
      _loading = false;
    });

  }


  bool _loading = false;
  @override
  Widget build(BuildContext context) {


    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
      backgroundColor: Color(0xFF232F3E),
      bottomNavigationBar:  Container(
       // color: Colors.black,
        height: screenHeight * 0.1,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: screenWidth * 0.8 > 400 ? 400 : screenWidth * 0.8,
            child: ElevatedButton(
              onPressed: () {
                 _loading ? null : updateAllDocuments();  // Handle button press
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _loading
                    ? CircularProgressIndicator(color: Colors.white)
                    : Text(
                  'Mark all as Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue,),
          onPressed: () {
            // Navigate to the login page when the back button is pressed
            Navigator.pop(context);
          },
        ),
        toolbarHeight: screenWidth * 0.1 > 400 ? screenWidth * 0.15  : screenWidth * 0.18,
        title: Center(
            child: Text(
              'Scheduled Orders',
              style: TextStyle(
                  fontSize:  screenWidth * 0.09 > 400 ? 30 : screenWidth * 0.09, fontWeight: FontWeight.bold, color: Colors.white),
            )),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60.0),
            bottomRight: Radius.circular(60.0),
          ),
        ),
        backgroundColor: Colors.orange,
      ),


      body: Container(
        width: double.infinity,
          height: double.infinity,

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "All Orders",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
                SizedBox(height: 6,),
                Container(
                 height: screenHeight*0.75,
                 // color: Colors.red,
                  width: double.infinity,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('Orders').where('Seller_id', isEqualTo: _user?.uid).where('status', isEqualTo: "Pending").snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      var Orders = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: Orders.length,
                        itemBuilder: (context, index) {
                          var order = Orders[index].data() as Map<String, dynamic>;
                          var productId = order['Product_id'];
                          var userId = order['User_id'];
                          var date = order['Date'];
                          var time = order['Time'];

                          String formattedDate = _formatDate(date);
                          String formattedTime = _formatTime(time);

                          return FutureBuilder<DocumentSnapshot>(
                            future: getProductDetails(productId),
                            builder: (context, productSnapshot) {
                              if (!productSnapshot.hasData) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              var productData =
                              productSnapshot.data!.data() as Map<String, dynamic>;
                              var productName = productData['ProductName'];
                              var producttype = productData['ProductType'];

                              return FutureBuilder<DocumentSnapshot>(
                                future: getUserDetails(userId),
                                builder: (context, userSnapshot) {
                                  if (!userSnapshot.hasData) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  var userData =
                                  userSnapshot.data!.data() as Map<String, dynamic>;
                                  var userName = userData['Name'];

                                  return ListTile(
                                    title: Container(
                                      //height: 100,
                                      //  width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFF0DC),
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [

                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Text(producttype+"'s",style: TextStyle(color: Colors.black),),
                                                SizedBox(width: 2,),
                                                Text(productName,style: TextStyle(color: Colors.black),),
                                              ],
                                            ),

                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Icon(Icons.watch_later_outlined,color: Colors.green,),
                                                SizedBox(width: 2,),
                                               Text(formattedDate,style: TextStyle(color: Colors.black),),
                                                SizedBox(width: 8,),
                                                Text(formattedTime,style: TextStyle(color: Colors.black),),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 3,),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text("User Name: "+userName,style: TextStyle(color: Colors.black),),
                                          ),
                                          SizedBox(height: 3,),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text("Address: "+ order["address"],style: TextStyle(color: Colors.grey[400]),),
                                          ),
                                          SizedBox(height: 5,),
                                        ]
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete,color: Colors.red,),
                                      onPressed: () async {
                                        await deleteReview(Orders[index].id);
                                        // Refresh the list after deleting the review
                                        setState(() {});
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(height: 6,),


              ],
            ),
          ),
        ),





      ),




    ));
  }


  String getImagePath(String productName) {
    if (productName == null) {
      return "assets/default.png"; // Provide a default image path if productName is null
    } else if (productName == "Butter") {
      return "assets/butter.png";
    } else if (productName == "Cheese") {
      return "assets/cheese.png";
    } else if (productName == "Yogurt") {
      return "assets/yogurt.png";
    } else if (productName == "Milk") {
      return "assets/milk.png";
    } else {
      return "assets/milk.png"; // Provide a default image path for unknown products
    }
  }


  String _formatDate(Timestamp date) {
    DateTime dateTime = date.toDate();
    String formattedDate =
        '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    return formattedDate;
  }

  String _formatTime(Timestamp time) {
    DateTime dateTime = time.toDate();
    String formattedTime =
        '${dateTime.hour}:${dateTime.minute} ${dateTime.hour < 12 ? 'AM' : 'PM'}';
    return formattedTime;
  }
}


