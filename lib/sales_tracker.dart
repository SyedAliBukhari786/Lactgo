import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Sales_Tracker extends StatefulWidget {
  const Sales_Tracker({super.key});

  @override
  State<Sales_Tracker> createState() => _Sales_TrackerState();
}

class _Sales_TrackerState extends State<Sales_Tracker> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  int totalPrice = 0;
int totalPrice2 = 0;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
    _calculateTotalPrice();

  }

  Future<void> _calculateTotalPrice() async {
    CollectionReference orders = FirebaseFirestore.instance.collection('Orders');
    CollectionReference products = FirebaseFirestore.instance.collection('Products');

    try {
      QuerySnapshot orderSnapshot = await orders
          .where('Seller_id', isEqualTo: _user?.uid)
          .get();

      List<QueryDocumentSnapshot> orderDocuments = orderSnapshot.docs;

      int total = 0;

      for (QueryDocumentSnapshot orderDocument in orderDocuments) {
        String productId = orderDocument['product_id'] ?? '';

        // Fetch the product document from the 'Products' collection
        DocumentSnapshot productSnapshot = await products.doc(productId).get();

        // Check if the product document exists and has a 'Price' field
        if (productSnapshot.exists) {
          String priceString = productSnapshot['Price'] ?? '0';

          // Convert the price from string to int
          int price = int.tryParse(priceString) ?? 0;

          print('Product ID: $productId');
          print('Product Price String: $priceString');
          print('Product Price: $price');

          total += price;
        } else {
          print('Product with ID $productId not found in the Products collection.');
        }
      }

      String totalPriceString = total.toString();

      print('Total Price: $totalPriceString');

      setState(() {
        totalPrice = total;
      });
    } catch (e) {
      print('Error calculating total price: $e');
    }
  }




  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
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
            // Navigate to the login page when the back button is pressed
            Navigator.pop(context);
          },
        ),
        toolbarHeight:
            screenWidth * 0.1 > 400 ? screenWidth * 0.15 : screenWidth * 0.18,
        title: Center(
            child: Text(
          'Sales Tracker',
          style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.09 > 400 ? 30 : screenWidth * 0.07,
              fontWeight: FontWeight.bold),
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
        child: Column(
          children: [
            Expanded(
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
                      var DATE = order['Product_id'];

                      // Fetch product details using Product ID
                      var productId = order['Product_id'];
                      var productDetails =
                          _firestore.collection('Products').doc(productId);

                      return FutureBuilder(
                        future: productDetails.get(),
                        builder: (context,
                            AsyncSnapshot<DocumentSnapshot> productSnapshot) {
                          if (!productSnapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          var productData = productSnapshot.data!.data()
                              as Map<String, dynamic>;

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
                                    flex: 5,
                                    child: Center(
                                        child: Container(
                                            child: Image.asset(getImagePath(
                                                productData['ProductName']))))),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        productData['ProductName'],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Animal",
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    "Sold:  ${order['Quantity']}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child:
                                      Text("Price:  ${productData['Price']}"),
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
            Container(
              decoration: BoxDecoration(
                //color: Colors.white,
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
             // height: screenHeight * 0.15,
              width: double.infinity,

             // color: Colors.orange,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                       // color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Montly Sales",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.06),
                            ),
                            SizedBox(height: 2,),
                            Text(
                              "$totalPrice"+"/-RS",
                              style: TextStyle(
                                color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.06),
                            ),


                          ],
                        ),
                      ),
                    ),

                    Expanded(
                      child: Container(
                        //color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Weekly Sales",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.06),
                            ),
                            SizedBox(height: 2,),
                            Text(
                              "$totalPrice2"+"/-RS",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.06),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(height: 100,),
          ],
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
