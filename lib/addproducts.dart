import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lactgo/dashboard.dart';
import 'package:lactgo/products.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Addproducts extends StatefulWidget {
  const Addproducts({super.key});

  @override
  State<Addproducts> createState() => _AddproductsState();
}

class _AddproductsState extends State<Addproducts> {
  TextEditingController productname =TextEditingController();
  TextEditingController producttype =TextEditingController();
  TextEditingController price =TextEditingController();
  TextEditingController discount =TextEditingController();
  bool _loading = false;
  TextEditingController discount_on =TextEditingController();
  TextEditingController type =TextEditingController();



  String getCurrentUserId() {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      return user.uid;
    } else {
      // If the user is not logged in, handle it accordingly
      // You might want to show an error, redirect to the login page, etc.
      throw Exception("User is not logged in");
    }
  }


  @override
  Widget build(BuildContext context) {

    List<String> list_name = [
      "Select Name",
      'Butter',
      'Cheese',
      'Yogurt',
      'Milk',
      // Add more cities as needed
    ];
    List<String> list_name2 = [
      "Select Name",
      'Butter',
      'Cheese',
      'Yogurt',
      'Milk',
      // Add more cities as needed
    ];

    List<String> list_type = [
      "Select Type",
      'Cow',
      'Goat',
      'Camel',
      'Buffalo',
      // Add more cities as needed
    ];
    List<String> list_type2 = [
      "Select Type",
      'Cow',
      'Goat',
      'Camel',
      'Buffalo',
      // Add more cities as needed
    ];
    String dropdownValue_name = list_name.first;
    String dropdownValue_type = list_type.first;
    String dropdownValue_name2 = list_name.first;
    String dropdownValue_type2= list_type.first;

    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(child: Scaffold(
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
              ' Add Products',
              style: TextStyle(
                color: Colors.orange,
                  fontSize:  screenWidth * 0.09 > 400 ? 30 : screenWidth * 0.07, fontWeight: FontWeight.bold),
            )),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60.0),
            bottomRight: Radius.circular(60.0),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body:  Container(width: double.infinity,
      height:  double.infinity,
        child:  SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: screenWidth * 0.8 > 400 ? 400 : screenWidth *
                      0.8,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            "Product Name",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        TextField(
                          style: TextStyle(color: Colors.orange),
                          controller: productname,
                          readOnly: true,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),

                          ),
                        ),
                        Center(
                          child: DropdownButton<String>(
                            value: dropdownValue_name,
                            icon: const Icon(
                                Icons.arrow_drop_down_outlined),
                            elevation: 16,
                            style: const TextStyle(color: Colors.orange),
                            underline: Container(
                              height: 2,
                              color: Colors.orange,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue_name = value!;
                                productname.text = dropdownValue_name;
                              });
                            },
                            items: list_name.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                          ),
                        ),

                        SizedBox(height: 10,),
                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            "Product Type",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),
                        TextField(
                          style: TextStyle(color: Colors.orange),
                          controller: producttype,
                          readOnly: true,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),

                          ),
                        ),
                        Center(
                          child: DropdownButton<String>(
                            value: dropdownValue_type,
                            icon: const Icon(
                                Icons.arrow_drop_down_outlined),
                            elevation: 16,
                            style: const TextStyle(color: Colors.orange),
                            underline: Container(
                              height: 2,
                              color: Colors.orange,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue_type = value!;
                                producttype.text = dropdownValue_type;
                              });
                            },
                            items: list_type.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                          ),
                        ),




                        SizedBox(
                          height: 20,
                        ),

                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Text(
                                "Price",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              height: 1,
                            ),

                            TextField(
                              style: TextStyle(color: Colors.white),
                             controller: price,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),


                              ),
                            ),

                        SizedBox(
                          height: 20,
                        ),

                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Text(
                            "Discount( if any)",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 1,
                        ),

                        TextField(
                          style: TextStyle(color: Colors.white),
                         controller: discount,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),


                          ),
                        ),
                        SizedBox(height: 20,),




                        Container(
                          width: screenWidth * 0.8 > 400 ? 400 : screenWidth * 0.8,
                          child: ElevatedButton(
                            onPressed: () async {
                             if(productname.text.isEmpty || productname.text=="Select Name"){
                               _showErrorSnackbar("Select Product");

                             } else if (producttype.text.isEmpty || producttype.text=="Select Type"){
                               _showErrorSnackbar("Select Product Type");
                             }


                             else if (price.text.isEmpty ){
                               _showErrorSnackbar("Enter Price");
                             } else {
                               try {
                                 setState(() {
                                   _loading = true;
                                 });
                                 // Get current user ID
                                 String userId = getCurrentUserId();

                                 // Add product data to Firestore
                                 await FirebaseFirestore.instance.collection('Products').add({
                                   'ProductName': productname.text,
                                   'ProductType': producttype.text,

                                   'Price': price.text,
                                   'Discount': discount.text,
                                   'UserId': userId,
                                   // Add more fields as needed
                                 });

                                 _showErrorSnackbar2("Product added successfully!");

                                 // Show success message or perform any other actions
                                 productname.clear();
                                 producttype.clear();
                                 discount_on.clear();
                                 type.clear();
                                 price.clear();
                                 discount.clear();

                               } catch (e) {
                                 // Handle errors
                                 print('Error adding product: $e');
                                 _showErrorSnackbar("Error adding product");
                               }finally {
                                 setState(() {
                                   _loading = false;
                                 });
                               }





                             }





                              // Handle button press
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
                                'Add Product',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ),




















                      ]),
                ),
              )







            ],
          ),
        ),







      ),






    ));
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
