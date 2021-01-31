import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Intro()));

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  double height, sliderVal = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        CachedNetworkImage(
          height: height,
          fit: BoxFit.cover,
          imageUrl: "https://images.unsplash.com/photo-1590272838586-c97a156234d4?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80",
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(flex: 2, child: Container()),
            Expanded(
              flex: 4,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
                Text('Rent Car', style: GoogleFonts.roboto(color: Colors.white, fontSize: 40)),
                Text('Easily', style: GoogleFonts.righteous(color: Color(0xffdff81e), fontSize: 40, fontWeight: FontWeight.w500)),
                Container(height: 20),
                Text('Rent a car in your area or abroad and\nget up. Make your reservation now!', style: GoogleFonts.roboto(color: Colors.white, fontSize: 16)),
              ]),
            ),
            Expanded(
                flex: 4,
                child: Container(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: 100,
                        height: 220,
                        decoration: BoxDecoration(color: Colors.grey.withAlpha(50), borderRadius: BorderRadius.circular(25)),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AnimatedContainer(
                                  width: 100,
                                  height: 60,
                                  transform: Matrix4.translationValues(0, sliderVal, 0),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(color: Color(0xffdff81e), borderRadius: BorderRadius.circular(25)),
                                  alignment: Alignment.center,
                                  duration: Duration(milliseconds: 100),
                                  child: Text('Start', style: GoogleFonts.righteous(color: Colors.black, fontSize: 20)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xffdff81e).withAlpha(50), size: 35),
                                      Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xffdff81e).withAlpha(150), size: 35),
                                      Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xffdff81e), size: 35),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Opacity(
                              opacity: 0,
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: Slider(
                                    onChangeEnd: (val) => val < 150
                                        ? setState(() => sliderVal = 0)
                                        : val != 160
                                            ? setState(() => sliderVal = val)
                                            : Navigator.push(context, MaterialPageRoute(builder: (context) => TypeSelector())),
                                    onChanged: (val) => setState(() => sliderVal = val),
                                    value: sliderVal,
                                    min: 0,
                                    max: 160),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
          ]),
        )
      ]),
    );
  }
}

class TypeSelector extends StatefulWidget {
  @override
  _TypeSelectorState createState() => _TypeSelectorState();
}

class _TypeSelectorState extends State<TypeSelector> {
  double height, sliderVal = 0;
  int selectedType = -1;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        CachedNetworkImage(
          height: height,
          fit: BoxFit.cover,
          imageUrl: "https://images.unsplash.com/photo-1603471811058-f9e6cc05993f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=658&q=80",
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            Expanded(
              flex: 4,
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    TextSpan(text: 'Choose type of ', style: GoogleFonts.roboto(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
                    TextSpan(text: 'Car', style: GoogleFonts.righteous(color: Color(0xffdff81e), fontSize: 35, fontWeight: FontWeight.bold)),
                  ]),
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(
                        child: GestureDetector(
                      onTap: () => setState(() => selectedType = 0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: AnimatedContainer(
                                  height: selectedType == 0 ? 200 : 180,
                                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                                  decoration: BoxDecoration(color: selectedType == 0 ? Color(0xffbace2c) : Colors.grey.withAlpha(100), borderRadius: BorderRadius.circular(30)),
                                  duration: Duration(milliseconds: 250),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                                    SizedBox(
                                        height: 80,
                                        width: 70,
                                        child: Transform(
                                            transform: Matrix4.rotationY(math.pi),
                                            alignment: Alignment.center,
                                            child: Image.network("https://cdn.onlinewebfonts.com/svg/img_538848.png", fit: BoxFit.contain, color: selectedType == 0 ? Colors.black87 : Colors.black45))),
                                    Text('Economy\nCar', style: GoogleFonts.righteous(color: Colors.black45, fontSize: 18, fontWeight: FontWeight.w500))
                                  ])))),
                    )),
                    Container(width: 15),
                    Expanded(
                        child: GestureDetector(
                      onTap: () => setState(() => selectedType = 1),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: AnimatedContainer(
                                  height: selectedType == 1 ? 200 : 180,
                                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                                  decoration: BoxDecoration(color: selectedType == 1 ? Color(0xffbace2c) : Colors.grey.withAlpha(100), borderRadius: BorderRadius.circular(30)),
                                  duration: Duration(milliseconds: 250),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                                    SizedBox(
                                        height: 80,
                                        width: 100,
                                        child: Image.network("https://images.vexels.com/media/users/3/155414/isolated/preview/6c5e852026e7fd11f79cf45a65299016-suv-car-side-view-silhouette-by-vexels.png",
                                            fit: BoxFit.contain, color: selectedType == 1 ? Colors.black87 : Colors.black45)),
                                    Text('Full Size\nCar', style: GoogleFonts.righteous(color: Colors.black45, fontSize: 18, fontWeight: FontWeight.w500))
                                  ])))),
                    )),
                    Container(width: 15),
                    Expanded(
                        child: GestureDetector(
                      onTap: () => setState(() => selectedType = 2),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: AnimatedContainer(
                                  height: selectedType == 2 ? 200 : 180,
                                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                                  decoration: BoxDecoration(color: selectedType == 2 ? Color(0xffbace2c) : Colors.grey.withAlpha(100), borderRadius: BorderRadius.circular(30)),
                                  duration: Duration(milliseconds: 250),
                                  child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                                    SizedBox(
                                        height: 80, width: 80, child: Image.network("https://cdn.onlinewebfonts.com/svg/img_23111.png", fit: BoxFit.contain, color: selectedType == 2 ? Colors.black87 : Colors.black45)),
                                    Text('Special\nCar', style: GoogleFonts.righteous(color: Colors.black45, fontSize: 18, fontWeight: FontWeight.w500))
                                  ])))),
                    )),
                  ]),
                )),
            Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: 100,
                        height: 220,
                        decoration: BoxDecoration(color: Colors.grey.withAlpha(50), borderRadius: BorderRadius.circular(25)),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AnimatedContainer(
                                  width: 100,
                                  height: 60,
                                  transform: Matrix4.translationValues(0, sliderVal, 0),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                  decoration: BoxDecoration(color: Color(0xffdff81e), borderRadius: BorderRadius.circular(25)),
                                  alignment: Alignment.center,
                                  duration: Duration(milliseconds: 100),
                                  child: Text('Search', style: GoogleFonts.righteous(color: Colors.black, fontSize: 20)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xffdff81e).withAlpha(50), size: 35),
                                      Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xffdff81e).withAlpha(150), size: 35),
                                      Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xffdff81e), size: 35),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Opacity(
                              opacity: 0,
                              child: RotatedBox(
                                quarterTurns: 1,
                                child: Slider(
                                    onChanged: (val) => val < 150
                                        ? setState(() => sliderVal = 0)
                                        : val != 160
                                            ? setState(() => sliderVal = val)
                                            : Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CarsList())),
                                    value: sliderVal,
                                    min: 0,
                                    max: 160),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ))
          ]),
        )
      ]),
    );
  }
}

class CarsList extends StatefulWidget {
  @override
  _CarsListState createState() => _CarsListState();
}

class _CarsListState extends State<CarsList> {
  List<Map<String, dynamic>> carsData = [
    {'name': 'R8', 'company': 'Audi', 'price': 150, 'image': 'https://pngimg.com/uploads/audi/audi_PNG1770.png'},
    {'name': 'Cla', 'company': 'Mercedes-Benz', 'price': 180, 'image': 'https://pngimg.com/uploads/mercedes/mercedes_PNG80219.png'},
    {'name': '2 Series', 'company': 'BMW', 'price': 120, 'image': 'https://pngimg.com/uploads/mercedes/mercedes_PNG80213.png'},
    {'name': 'A3 Sedan', 'company': 'Audi', 'price': 140, 'image': 'https://pngimg.com/uploads/mercedes/mercedes_PNG80212.png'},
    {'name': 'X5', 'company': 'BMW', 'price': 160, 'image': 'https://pngimg.com/uploads/bmw/bmw_PNG1712.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black), onPressed: () => Navigator.pop(context)),
          IconButton(icon: Icon(FontAwesomeIcons.slidersH, color: Colors.black), onPressed: () {})
        ]),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15, left: 25, right: 25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          RichText(
              text: TextSpan(children: [
            TextSpan(text: 'Cars', style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
            TextSpan(text: ' for You'),
          ], style: GoogleFonts.roboto(color: Colors.black, fontSize: 35))),
          Container(height: 20),
          Expanded(
            child: ListView(
              children: returnCars(),
            ),
          )
        ]),
      ),
    );
  }

  List<Widget> returnCars() {
    return List.generate(
        5,
        (index) => GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RentCar(data: carsData[index]))),
              child: Container(
                height: 180,
                margin: EdgeInsets.only(bottom: 30),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(40)),
                child: Column(children: [
                  Expanded(child: Image.network(carsData[index]['image'], fit: BoxFit.cover)),
                  Container(height: 20),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(text: carsData[index]['company'] + " ", style: GoogleFonts.righteous(color: Colors.black, fontSize: 22)),
                          TextSpan(text: carsData[index]['name'], style: GoogleFonts.righteous(color: Colors.black38, fontSize: 22))
                        ]),
                      ),
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(text: "\$${carsData[index]['price']}", style: GoogleFonts.righteous(color: Colors.black, fontSize: 22)),
                        TextSpan(text: "/Day", style: GoogleFonts.righteous(color: Colors.black38, fontSize: 22))
                      ]),
                    )
                  ]),
                ]),
              ),
            ));
  }
}

class RentCar extends StatefulWidget {
  final Map<String, dynamic> data;

  const RentCar({Key key, this.data}) : super(key: key);
  @override
  _RentCarState createState() => _RentCarState();
}

class _RentCarState extends State<RentCar> {
  double sliderVal = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80,
        title: IconButton(icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.black), onPressed: () => Navigator.pop(context)),
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 20, left: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(children: [
                TextSpan(text: widget.data['company'] + " ", style: GoogleFonts.righteous(color: Colors.black, fontSize: 30)),
                TextSpan(text: widget.data['name'] + "\n", style: GoogleFonts.righteous(color: Colors.black38, fontSize: 30)),
                TextSpan(text: "\$${widget.data['price']}", style: GoogleFonts.righteous(color: Colors.black, fontSize: 22)),
                TextSpan(text: "/Day", style: GoogleFonts.righteous(color: Colors.black38, fontSize: 22))
              ]),
            ),
            Container(height: 20),
            Expanded(
              child: Image.network(widget.data['image'], fit: BoxFit.contain),
            ),
            Container(height: 20),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.speed, color: Colors.black, size: 35),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(text: 'Speed\n', style: GoogleFonts.righteous(color: Colors.black, fontSize: 16)),
                              TextSpan(text: '300 km/h', style: GoogleFonts.righteous(color: Colors.black26, fontSize: 14))
                            ]))
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.speed, color: Colors.black, size: 35),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(text: 'Power\n', style: GoogleFonts.righteous(color: Colors.black, fontSize: 16)),
                              TextSpan(text: '150HP', style: GoogleFonts.righteous(color: Colors.black26, fontSize: 14))
                            ]))
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.speed, color: Colors.black, size: 35),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(text: 'Acceleration\n', style: GoogleFonts.righteous(color: Colors.black, fontSize: 16)),
                              TextSpan(text: '9.6', style: GoogleFonts.righteous(color: Colors.black26, fontSize: 14))
                            ]))
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.speed, color: Colors.black, size: 35),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(text: 'Capacity\n', style: GoogleFonts.righteous(color: Colors.black, fontSize: 16)),
                              TextSpan(text: '4 persons', style: GoogleFonts.righteous(color: Colors.black26, fontSize: 14))
                            ]))
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.speed, color: Colors.black, size: 35),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(text: 'Small luggage\n', style: GoogleFonts.righteous(color: Colors.black, fontSize: 16)),
                              TextSpan(text: '2 place', style: GoogleFonts.righteous(color: Colors.black26, fontSize: 14))
                            ]))
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.speed, color: Colors.black, size: 35),
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(text: 'Big luggage\n', style: GoogleFonts.righteous(color: Colors.black, fontSize: 16)),
                              TextSpan(text: '1 place', style: GoogleFonts.righteous(color: Colors.black26, fontSize: 14))
                            ]))
                      ],
                    )
                  ],
                )
              ],
            )),
            Container(height: 20),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: 100,
                      height: 220,
                      decoration: BoxDecoration(color: Colors.grey.withAlpha(50), borderRadius: BorderRadius.circular(25)),
                      child: Stack(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AnimatedContainer(
                                width: 100,
                                height: 60,
                                transform: Matrix4.translationValues(0, sliderVal, 0),
                                padding: EdgeInsets.symmetric(vertical: 15),
                                decoration: BoxDecoration(color: Color(0xffdff81e), borderRadius: BorderRadius.circular(25)),
                                alignment: Alignment.center,
                                duration: Duration(milliseconds: 100),
                                child: Text('Rent', style: GoogleFonts.righteous(color: Colors.black, fontSize: 20)),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xffdff81e).withAlpha(50), size: 35),
                                    Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xffdff81e).withAlpha(150), size: 35),
                                    Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xffdff81e), size: 35),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Opacity(
                            opacity: 0,
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: Slider(
                                  onChanged: (val) => val < 150
                                      ? setState(() => sliderVal = 0)
                                      : val != 160
                                          ? setState(() => sliderVal = val)
                                          : Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Intro())),
                                  value: sliderVal,
                                  min: 0,
                                  max: 160),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
