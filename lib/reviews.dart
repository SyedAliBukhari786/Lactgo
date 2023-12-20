import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Reviews extends StatefulWidget {
  const Reviews({Key? key});

  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _reviewController = TextEditingController();

  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getProductDetails(
      String productId) {
    return _firestore.collection('Products').doc(productId).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails(String userId) {
    return _firestore.collection('Users').doc(userId).get();
  }

  Future<void> deleteReview(String reviewId) {
    return _firestore.collection('Reviews').doc(reviewId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF232F3E),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Center(
            child: Text(
              'Reviews',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ),
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60.0),
              bottomRight: Radius.circular(60.0),
            ),
          ),
          backgroundColor: Colors.orange,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('Reviews').where('Seller_id', isEqualTo: _user?.uid).where('status', isEqualTo: "Unchecked").snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var reviews = snapshot.data!.docs;

              return ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  var review = reviews[index].data() as Map<String, dynamic>;
                  var productId = review['Product_id'];
                  var userId = review['User_id'];

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
                      var productPrice = productData['Price'];

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
                              //  width: double.infinity,
                              decoration: BoxDecoration(
                                // color: Colors.grey[300],
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFFF0DC),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              height: 120,
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                      child: Container(
                                                          child: Image.asset(
                                                    getImagePath(productName),
                                                    fit: BoxFit.cover,
                                                  ))),
                                                  Expanded(
                                                      child: Container(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 4.0),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                productData[
                                                                    'ProductName'],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.04,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              Text(
                                                                "Rs " +
                                                                    productData[
                                                                        'Price'] +
                                                                    "/:",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.04,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        12.0),
                                                            child: Text(
                                                              "Animal",
                                                              style: TextStyle(
                                                                fontSize: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.04,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  )),
                                                ],
                                              ),
                                              // color: Colors.grey[300],
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: SingleChildScrollView(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Column(
                                                  // mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      height: 1,
                                                    ),
                                                    Text(
                                                      'User: $userName',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Center(
                                                      child: Text(
                                                        'Comment',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(
                                                      '${review['Review']}',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            height: 120,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      //color: Colors.red,
                                      height: 30,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 8,
                                            child: Container(
                                              // color: Colors.red,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: TextField(
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  controller: _reviewController,
                                                  decoration: InputDecoration(
                                                    // labelStyle: TextStyle(color: Colors.white),
                                                    hintText: "Your reply here",
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Container(
                                              //color: Colors.green,
                                              child: GestureDetector(
                                                onTap: () async {
                                                  if (_reviewController
                                                      .text.isEmpty) {
                                                    _showErrorSnackbar(
                                                        "Enter Reply");
                                                  } else {
                                                    try {
                                                      // Reference to the document you want to update
                                                      DocumentReference productRef = FirebaseFirestore.instance.collection('Reviews').doc(reviews[index].id);

                                                      // Use the update method to update specific fields
                                                      await productRef.update({
                                                        'Reply': _reviewController.text.trim(),
                                                        'status': "Checked",
                                                        // Add more fields as needed
                                                      });

                                                      _showErrorSnackbar2("Review Added");
                                                    } catch (e) {
                                                     _showErrorSnackbar("Error $e");
                                                    }





                                                  }
                                                },
                                                child: Icon(
                                                  Icons.send,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            /*Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Product: $productName'),
                                      Text('Price: $productPrice'),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 8), // Add some space between the two containers
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('User: $userName'),
                                      Text('Review: ${review['Review']}'),
                                    ],
                                  ),
                                ),
                              ],
                            ),*/
                            trailing: IconButton(
                              icon: Icon(Icons.delete,color: Colors.red,),
                              onPressed: () async {
                                await deleteReview(reviews[index].id);
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
      ),
    );
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

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
    ));
  }

  void _showErrorSnackbar2(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    ));
  }
}
