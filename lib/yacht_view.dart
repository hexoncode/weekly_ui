import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:circle_wheel_scroll/circle_wheel_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MaterialApp(home: YachtView(), debugShowCheckedModeBanner: false, theme: ThemeData(accentColor: Color(0xff197F7A))));

class YachtView extends StatefulWidget {
  @override
  _YachtViewState createState() => _YachtViewState();
}

class _YachtViewState extends State<YachtView> {
  double height, width;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, keepPage: false);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff197F7A),
      body: Stack(children: [
        CachedNetworkImage(
            imageUrl: "https://images.unsplash.com/photo-1528154291023-a6525fabe5b4?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80",
            fit: BoxFit.cover,
            height: height,
            width: width),
        PageView(controller: pageController, children: [PageOne(onAnimate), PageTwo(onAnimate), PageThree(onAnimate)])
      ]),
    );
  }

  onAnimate(int page) => pageController.animateToPage(page, duration: Duration(milliseconds: 250), curve: Curves.linear);
}

class PageOne extends StatefulWidget {
  final Function onAnimate;

  const PageOne(this.onAnimate);
  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  double height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Stack(children: [
      Container(
        height: height,
        width: width,
        decoration: BoxDecoration(border: Border.all(color: Colors.white, width: 15), borderRadius: BorderRadius.all(Radius.circular(40))),
      ),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Adventure\nAwaits you!", style: GoogleFonts.montserrat(fontSize: 35, fontWeight: FontWeight.w500, color: Colors.white)),
                  Container(height: 30),
                  Text("Make your vacation an\nunexpected experience.", style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w300, color: Colors.white)),
                ],
              ),
            ),
            Expanded(
              child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 50),
                  child: GestureDetector(
                    onTap: () => widget.onAnimate(1),
                    child: Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(25))),
                        alignment: Alignment.center,
                        child: FaIcon(FontAwesomeIcons.arrowRight, color: Colors.white)),
                  ),
                )
              ]),
            )
          ],
        ),
      )
    ]);
  }
}

class PageTwo extends StatefulWidget {
  final Function onAnimate;

  const PageTwo(this.onAnimate);
  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  double height, width;
  int selection = -1;
  List<Map<String, String>> locations = [
    {"name": "Monaco", "image": "https://images.unsplash.com/photo-1570911274539-77ee179c3ab5?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1267&q=80"},
    {"name": "Greece", "image": "https://images.unsplash.com/photo-1605281317010-fe5ffe798166?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1328&q=80"},
    {"name": "Florida", "image": "https://images.unsplash.com/photo-1567899378494-47b22a2ae96a?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80"},
    {"name": "Italy", "image": "https://images.unsplash.com/photo-1599383885524-8ab14dee8249?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1351&q=80"},
    {"name": "Bermuda", "image": "https://images.unsplash.com/photo-1552160757-52790c6f4faf?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1267&q=80"},
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            height: height,
            width: width,
            color: Color(0xff197F7A).withOpacity(0.5),
          ),
        ),
        Stack(
          children: [
            Center(child: Transform.translate(offset: Offset(-270, 0), child: Container(height: 500, width: 500, decoration: BoxDecoration(border: Border.all(color: Colors.white60, width: 1), shape: BoxShape.circle)))),
            Transform.translate(
              offset: Offset(150, 0),
              child: CircleListScrollView(
                radius: 400,
                clipToSize: false,
                itemExtent: 120,
                children: returnChildren(),
                physics: CircleFixedExtentScrollPhysics(),
                renderChildrenOutsideViewport: true,
                onSelectedItemChanged: (int selected) => setState(() => selection = selected),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text("Choose\nLocation", style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              TextButton(onPressed: () {}, child: Text('Skip', style: GoogleFonts.montserrat(color: Colors.white54, fontSize: 16))),
              GestureDetector(
                onTap: () => widget.onAnimate(2),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(25))),
                  alignment: Alignment.center,
                  child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Text('Confirm', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 18)),
                    Container(width: 20),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: Colors.white54, width: 1), borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 20),
                    )
                  ]),
                ),
              )
            ])
          ]),
        )
      ],
    );
  }

  List<Widget> returnChildren() {
    return List.generate(locations.length, (int index) {
      return CachedNetworkImage(
        imageUrl: locations[index]['image'],
        imageBuilder: (context, provider) => Stack(
          children: [
            AnimatedContainer(
              width: 200,
              height: 120,
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(20)), image: DecorationImage(fit: BoxFit.cover, image: provider)),
              duration: Duration(milliseconds: 250),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                  margin: EdgeInsets.only(bottom: 10, left: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25)), color: Colors.black45),
                  child: Text(locations[index]['name'], style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16))),
            )
          ],
        ),
      );
    });
  }
}

class PageThree extends StatefulWidget {
  final Function onAnimate;

  const PageThree(this.onAnimate);
  @override
  _PageThreeState createState() => _PageThreeState();
}

class _PageThreeState extends State<PageThree> {
  double height, width, temperature = 100;
  int duration = 4;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        BackdropFilter(filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), child: Container(height: height, width: width, color: Color(0xff197F7A).withOpacity(0.5))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Personalize\nyour search", style: GoogleFonts.montserrat(fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white)),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: Colors.white38, width: 1), borderRadius: BorderRadius.all(Radius.circular(25))),
                    alignment: Alignment.center,
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Text('Set', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 18)),
                      Container(width: 20),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Icon(Icons.add, color: Colors.grey, size: 20),
                      )
                    ]),
                  ),
                ],
              ),
              Container(height: 50),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(children: [
                    Expanded(
                        child: Column(
                      children: [
                        Expanded(
                            child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Stack(
                            children: [
                              Container(decoration: BoxDecoration(color: Colors.white30)),
                              Align(alignment: Alignment.bottomCenter, child: Container(color: Colors.white, height: temperature)),
                              Center(
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [FaIcon(FontAwesomeIcons.thermometerHalf, color: Colors.red, size: 50), Text('25°C', style: GoogleFonts.montserrat(color: Colors.black45, fontSize: 24))])),
                              Opacity(opacity: 0, child: RotatedBox(quarterTurns: 3, child: Slider(min: 0, max: 440, value: temperature, onChanged: (val) => setState(() => temperature = val))))
                            ],
                          ),
                        )),
                        Container(height: 20),
                        Text('Temperature', style: GoogleFonts.montserrat(color: Colors.white54, fontSize: 16))
                      ],
                    )),
                    Container(width: 20),
                    Expanded(
                        child: Column(
                      children: [
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.all(Radius.circular(30))),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                                5,
                                (int index) => Expanded(
                                        child: GestureDetector(
                                      onTap: () => setState(() => duration = index),
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10, bottom: index == 4 ? 10 : 0),
                                        decoration: BoxDecoration(
                                            color: index >= duration ? Colors.white : Colors.white54,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(index == 4 ? 25 : 15),
                                              bottomRight: Radius.circular(index == 4 ? 25 : 15),
                                              topLeft: Radius.circular(index == 0 ? 25 : 15),
                                              topRight: Radius.circular(index == 0 ? 25 : 15),
                                            )),
                                      ),
                                    ))),
                          ),
                        )),
                        Container(height: 20),
                        Text('Duration', style: GoogleFonts.montserrat(color: Colors.white54, fontSize: 16))
                      ],
                    )),
                  ]),
                ),
              ),
              Container(height: 50),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                TextButton(onPressed: () {}, child: Text('Skip', style: GoogleFonts.montserrat(color: Colors.white54, fontSize: 16))),
                GestureDetector(
                  onTap: () => widget.onAnimate(0),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.all(Radius.circular(25))),
                    alignment: Alignment.center,
                    child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Text('Finish', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 18)),
                      Container(width: 20),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.transparent, border: Border.all(color: Colors.white54, width: 1), borderRadius: BorderRadius.all(Radius.circular(15))),
                        child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 20),
                      )
                    ]),
                  ),
                )
              ])
            ],
          ),
        )
      ],
    );
  }
}
