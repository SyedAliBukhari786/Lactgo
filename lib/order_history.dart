import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Orderhistory extends StatefulWidget {
  const Orderhistory({super.key});

  @override
  State<Orderhistory> createState() => _OrderhistoryState();
}

class _OrderhistoryState extends State<Orderhistory> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }
  @override
  Widget build(BuildContext context) {


    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return  SafeArea(child: Scaffold(
      backgroundColor: Color(0xFF232F3E),
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
              'Order History',
              style: TextStyle(
                  color: Colors.white,
                  fontSize:  screenWidth * 0.09 > 400 ? 30 : screenWidth * 0.07, fontWeight: FontWeight.bold),
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

        padding: EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: _firestore.collection('Orders').where('Seller_id', isEqualTo: _user?.uid).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            var orders = snapshot.data!.docs;

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                var order = orders[index].data() as Map<String, dynamic>;

                // Fetch product details using Product ID
                var productId = order['Product_id'];
                var productDetails = _firestore.collection('Products').doc(productId);

                return FutureBuilder(
                  future: productDetails.get(),
                  builder: (context, AsyncSnapshot<DocumentSnapshot> productSnapshot) {
                    if (!productSnapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    var productData = productSnapshot.data!.data() as Map<String, dynamic>;

                    return Container(

                      width: screenWidth * 0.38,
                      height: screenHeight * 0.38,
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF0DC),
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Expanded(
                             flex: 5
                             ,child: Center(child: Container(child: Image.asset( getImagePath(productData['ProductName']))))),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(

                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(productData['ProductName'],style: TextStyle(
                                  fontWeight: FontWeight.bold,


                                ),),
                                Text("Animal",style: TextStyle(
                                 color: Colors.grey


                                ),),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("Sold:  ${order['Quantity']}",style: TextStyle(
                              fontWeight: FontWeight.bold,


                            ),),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text("Price:  ${productData['Price']}"),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
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
}
