import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:thai_journey_app/model/Provinces.dart';
import 'package:thai_journey_app/screens/attraction_detail_screen.dart';
import 'package:thai_journey_app/service/place_search_api_service.dart';

class PlaceSearchScreen extends StatefulWidget {
  final String provinceName;
  const PlaceSearchScreen({super.key, required this.provinceName});

  @override
  State<PlaceSearchScreen> createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  Map<String, dynamic>? _placeSearch;
  final PlaceSearchApiService placeSearchApiService = PlaceSearchApiService();

  @override
  void initState() {
    super.initState();
    fetchPlaceSearch();
  }

  Future<void> fetchPlaceSearch() async {
    final response = await placeSearchApiService
        .fetchPlaceSearchService(widget.provinceName);
    setState(() {
      _placeSearch = response;
    });
  }

  // Future<void> _fetchPlaceSearchs() async {
  //   final String _baseUrl =
  //       'https://tatapi.tourismthailand.org/tatapi/v5/places/search?provincename=${widget.provinceName}&categorycodes=ATTRACTION';

  //   final response = await http.get(Uri.parse(_baseUrl), headers: headers);
  //   if (response.statusCode == 200) {
  //     setState(() {
  //       _placeSearch = json.decode(response.body);
  //     });
  //   } else {
  //     print('Error: ${response.statusCode}');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          widget.provinceName,
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xFF41C9E2),
      ),
      body: SingleChildScrollView(
        // Wrap with SingleChildScrollView
        child: Column(
          children: [
            // Text(_placeSearch!['result'][0]['location']['province']),
            GridView.builder(
                physics:
                    const NeverScrollableScrollPhysics(), // Disable scrolling for GridView
                padding: const EdgeInsets.all(10),
                shrinkWrap:
                    true, // Allow GridView to take only the needed space
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 20,
                ),
                itemCount: _placeSearch == null
                    ? 0
                    : (_placeSearch!['result'] as List).length,
                itemBuilder: (context, index) {
                  final attractions = _placeSearch!['result'];
                  final attraction = attractions[index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                //ส่ง id ไปให้
                                builder: (context) => AttractionDetailScreen(
                                    place_id: attraction['place_id'])));
                      },
                      child: Card(
                          child: Container(
                        height: 300,
                        color: Color(0xFFF7EEDD),
                        child: Column(
                          children: [
                            Flexible(
                              child: SizedBox(
                                width: 200,
                                height: 150,
                                child: Image.network(
                                  attraction['thumbnail_url'],
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Center(
                                      child: Image.asset(
                                        'assests/no1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              attraction['place_name'] ?? 'สถานที่ไม่ระบุ',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )));
                })
          ],
        ),
      ),
      // bottomNavigationBar: NavigationBar(
      //   backgroundColor: Color(0xFF41C9E2),
      //   onDestinationSelected: (int index) {
      //     setState(() {
      //       _selectedIndexPage = index;
      //     });
      //   },
      //   indicatorColor: Colors.amber,
      //   selectedIndex: _selectedIndexPage,
      //   destinations: const <Widget>[
      //     NavigationDestination(
      //       selectedIcon: Icon(Icons.home),
      //       icon: Icon(Icons.home_outlined),
      //       label: 'Home',
      //     ),
      //     NavigationDestination(
      //       selectedIcon: Icon(
      //         Icons.favorite_sharp,
      //         color: Colors.red,
      //       ),
      //       icon: Icon(Icons.favorite_sharp),
      //       label: 'Wishlist',
      //     ),
      //   ],
      // ),
    ));
  }
}
