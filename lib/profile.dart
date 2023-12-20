
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lactgo/discounts.dart';
import 'package:lactgo/edit_farm.dart';
import 'package:lactgo/editprofle.dart';
import 'package:lactgo/login.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF232F3E),

        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
             //   mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width<500? MediaQuery.of(context).size.width * 0.33 : MediaQuery.of(context).size.width * 0.33,
                        height: MediaQuery.of(context).size.width<500? MediaQuery.of(context).size.width * 0.33 : MediaQuery.of(context).size.width * 0.33,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          // Set the shape to circular
                          border: Border.all(
                            color: Colors.green,
                            width: 0.0,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Center(
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: Icon(
                                Icons.person,
                                // Replace with the desired icon
                                // size: 40.0,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text("User Name",  style: TextStyle(
                        color: Colors.white,
                        fontSize:screenWidth * 0.04 > 400 ? 30 : screenWidth *0.08,
                        fontWeight: FontWeight.bold,
                      ),








                      ),


                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Seller",  style: TextStyle(
                    color: Colors.white,
                    fontSize:screenWidth * 0.04 > 400 ? 30 : screenWidth *0.06,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Container(
                    width: screenWidth * 0.8 > 400 ? 200 : screenWidth * 0.5,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Editprofile()),
                        );



                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child:
                             Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 40,
                  ),


                  GestureDetector(
                    onTap: () {   Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditFarm()),
                    );},
                    child: Container(

                      //color: Colors.white,
                      width: screenWidth *0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text("Edit Farm Details", style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth *0.048,
                            fontWeight: FontWeight.bold,
                          ),),

                          Container(
                            width: MediaQuery.of(context).size.width<500? MediaQuery.of(context).size.width * 0.06 : MediaQuery.of(context).size.width * 0.1 ,
                            height: MediaQuery.of(context).size.width<500? MediaQuery.of(context).size.width * 0.06  : MediaQuery.of(context).size.width * 0.1 ,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              // Set the shape to circular
                              border: Border.all(
                                color: Colors.black,
                                width: 0.0,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    // Replace with the desired icon
                                    // size: 40.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),


                        ],
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
                        MaterialPageRoute(builder: (context) => Discounts()),
                      );




                    },
                    child: Container(
                     // color: Colors.green,

                      //color: Colors.white,
                      width: screenWidth *0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text("Discounted Products", style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth *0.048,
                            fontWeight: FontWeight.bold,
                          ),),

                      Container(
                              width: MediaQuery.of(context).size.width<500? MediaQuery.of(context).size.width * 0.06 : MediaQuery.of(context).size.width * 0.1 ,
                              height: MediaQuery.of(context).size.width<500? MediaQuery.of(context).size.width * 0.06  : MediaQuery.of(context).size.width * 0.1 ,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                // Set the shape to circular
                                border: Border.all(
                                  color: Colors.black,
                                  width: 0.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Center(
                                  child: FittedBox(
                                    fit: BoxFit.contain,
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      // Replace with the desired icon
                                      // size: 40.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),



                        ],
                      ),


                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Container(

                    //color: Colors.white,
                    width: screenWidth *0.8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text("Switch as Customer", style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth *0.048,
                          fontWeight: FontWeight.bold,
                        ),),

                        Container(
                          width: MediaQuery.of(context).size.width<500? MediaQuery.of(context).size.width * 0.06 : MediaQuery.of(context).size.width * 0.1 ,
                          height: MediaQuery.of(context).size.width<500? MediaQuery.of(context).size.width * 0.06  : MediaQuery.of(context).size.width * 0.1 ,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            // Set the shape to circular
                            border: Border.all(
                              color: Colors.black,
                              width: 0.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Center(
                              child: FittedBox(
                                fit: BoxFit.contain,
                                child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  // Replace with the desired icon
                                  // size: 40.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),


                  ),

                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () async {
                      // Perform the logout operation
                      await FirebaseAuth.instance.signOut();

                      // Navigate to the login screen or any other screen you want after logout
                      // Example using Navigator:
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Container(

                      //color: Colors.white,
                      width: screenWidth *0.8,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text("logout", style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth *0.048,
                            fontWeight: FontWeight.bold,
                          ),),




                        ],
                      ),


                    ),
                  ),
                  SizedBox(height: 100,)



                ],








                ),
              ),
            ),
          ),
        ),








      ),
    );;
  }
}
