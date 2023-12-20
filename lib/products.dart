import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lactgo/addproducts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lactgo/dashboard.dart';


class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {




  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    String userId = user?.uid ?? "";

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
          backgroundColor:   Color(0xFF232F3E),
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
              'Products',
              style: TextStyle(
                  fontSize:  screenWidth * 0.09 > 400 ? 30 : screenWidth * 0.09, fontWeight: FontWeight.bold,color: Colors.white),
            )),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60.0),
            bottomRight: Radius.circular(60.0),
          ),
        ),
        backgroundColor: Colors.orange,
      ),

      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Add more",  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                    fontSize:screenWidth * 0.04 > 400 ? 400 : screenWidth *0.04,
                  ),),
                  SizedBox(width: 5,),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Addproducts()),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width<500? MediaQuery.of(context).size.width * 0.1 : MediaQuery.of(context).size.width * 0.09,
                      height: MediaQuery.of(context).size.width<500? MediaQuery.of(context).size.width * 0.1 : MediaQuery.of(context).size.width * 0.09,

                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                        // Set the shape to circular
                        border: Border.all(
                          color: Colors.white,
                          width: 2.0,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Icon(
                              Icons.add,
                              // Replace with the desired icon
                              // size: 40.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                ],
              ),
              SizedBox(height: 10,),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Products').where("UserId", isEqualTo: userId).snapshots(includeMetadataChanges: true),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    var product = snapshot.data!.docs;

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0,
                      ),
                      itemCount: product.length,
                      itemBuilder: (context, index) {
                        var productData = product[index].data() as Map<String, dynamic>;
                        var productId = product[index].id;

                        return Container(
                          width: screenWidth*0.35,
                          height: screenWidth*0.45,
                          decoration: BoxDecoration(
                            color: Color(0xFFFFF0DC),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Container(

                                      //color: Colors.green,
                                        child: Image.asset(getImagePath(productData["ProductName"]),fit: BoxFit.cover ,)
                                    ),
                                  ),
                                ),
                              ),






                              Padding(
                                padding: const EdgeInsets.only(left: 12.0,right: 12.0,top: 4,bottom: 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      productData['ProductName'],
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width * 0.06,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    GestureDetector(onTap :() {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text("Delete Product"),
                                          content: Text("Are you sure you want to delete this product?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Cancel"),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                // Delete the product from Firebase
                                                FirebaseFirestore.instance.collection('Products').doc(productId).delete();
                                                Navigator.pop(context);
                                              },
                                              child: Text("Delete"),
                                            ),
                                          ],
                                        ),
                                      );

                                    },child: Icon(Icons.delete,color: Colors.red,))

                                  ],
                                ),
                              ),
                              Padding(

                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                child: Text(
                                  "Animal",
                                  style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width * 0.04,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),

                              Padding(

                                padding: const EdgeInsets.symmetric(horizontal: 3.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "RS " ,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width * 0.04,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      productData['Price']+"/:" ,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width * 0.05,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),



                              // Add other product details if needed
                            ],
                          ),
                        );
                      },





                    );
                  },
                ),
              ),
            ],
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
}


