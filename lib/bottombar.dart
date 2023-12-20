
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:lactgo/profile.dart';
import 'package:lactgo/dashboard.dart';




class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0; // Set the initial index to 2 for the "Home" icon
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

  @override
  Widget build(BuildContext context) {


    List<Widget> _pages = [

      Dashboard(),
      ProfilePage(),

    ];

    List<Color> _iconColors = [
      Colors.white, // About
      Colors.white, // Media
    // Home
      // Contact

    ];

    return Scaffold(
      bottomNavigationBar: Container(

        child: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _page,
          items: [
            CurvedNavigationBarItem(
              child: Icon(Icons.home , color: _iconColors[0],),
              label: 'Home',
            ),

            CurvedNavigationBarItem(
              child: Icon(Icons.person,color: _iconColors[0]),
              label: 'Profile',
            ),


          ],
          color: Colors.orange,
          buttonBackgroundColor: Color(0xFF232F3E),
          backgroundColor: Color(0xFF232F3E),
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
              _iconColors = List.generate(5, (i) => i == index ? Colors.green : Colors.grey);
            });
          },
          letIndexChange: (index) => true,
        ),
      ),
      body:  _pages[_page],
    );
  }
}
