import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_polygon_clipper/flutter_polygon_clipper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Pecel extends StatefulWidget {
  const Pecel({super.key});

  @override
  State<Pecel> createState() => _PecelState();
}

class _PecelState extends State<Pecel> {
  int _selectedIndex = 0;
  int _selectedMenuIndex = 0; // Track selected menu button

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(180.0), // Set the height of the AppBar
          child: AppBar(
            flexibleSpace: Padding(
              padding:
                  const EdgeInsets.all(8.0), // Add padding around the content
              child: Container(
                height: 160.0,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildPromoImage('https://i.ibb.co.com/s1RpfXD/pecel.jpg'),
                    SizedBox(width: 8),
                    _buildPromoImage('https://i.ibb.co.com/s1RpfXD/pecel.jpg'),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            // Menu section with ListView
            Container(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildMenuButton(0, 'Menu Spesial', Colors.green,
                      FontAwesomeIcons.utensils),
                  _buildMenuButton(
                      1, 'Menu Terlaris', Colors.red, FontAwesomeIcons.fire),
                  _buildMenuButton(
                      2, 'Minuman', Colors.blue, FontAwesomeIcons.cocktail),
                ],
              ),
            ),
            // Menu items with SingleChildScrollView
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Menu Pilihan',
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                      ),
                    ),
                    Column(
                      children: List.generate(
                        3,
                        (index) => _buildMenuItem(
                          'Pecel Sambel Tumpang',
                          'Pecel, Sambel Tumpang, Telur \nBali, Sate Usus...',
                          'https://i.ibb.co.com/Smfw2R0/pecel2.jpg',
                          4.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        // Bottom Navigation Bar with FlutterClipPolygon
        bottomNavigationBar: Container(
          height: 70, // Set the height of the BottomNavigationBar
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  child: Icon(Icons.home, size: 25), // Increase the icon size
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                          height: 10,
                          width: 70,
                          child: OverflowBox(
                            maxHeight: 70,
                            child: FlutterClipPolygon(
                              sides: 6,
                              borderRadius: 5.0,
                              boxShadows: [
                                PolygonBoxShadow(
                                    color: Colors.yellow, elevation: 1.0),
                                PolygonBoxShadow(
                                    color: Colors.grey, elevation: 5.0)
                              ],
                              child: Container(
                                color: Colors.yellow,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(FontAwesomeIcons.book),
                                    Padding(
                                      padding: EdgeInsets.only(top: 2),
                                      child: Text(
                                        "Menu",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )),
                    ],
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  child: Icon(Icons.shopping_cart,
                      size: 25), // Increase the icon size
                ),
                label: 'Keranjang',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildPromoImage(String imageUrl) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          width: 300, // Adjust the width as needed
          height: 200,
        ),
        Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 10,
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Promo 20%',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Untuk 10 Pembeli Pertama',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuButton(int index, String title, Color color, IconData icon) {
    bool isSelected = index == _selectedMenuIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMenuIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: isSelected ? 260 : 160,
        margin: const EdgeInsets.all(0),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: color,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(
      String title, String description, String imageUrl, double rating) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16), // Add space between image and text
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      EdgeInsets.only(top: 4, bottom: 4, left: 4, right: 310),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 238, 143, 0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star, size: 16, color: Colors.black),
                      Text(
                        '$rating',
                        style: TextStyle(fontSize: 14, color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8), // Add space between rating and title
                Text(
                  title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4), // Add space between title and description
                Text(
                  description,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
