import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: TravelView()));

class TravelView extends StatefulWidget {
  @override
  _TravelViewState createState() => _TravelViewState();
}

class _TravelViewState extends State<TravelView> {
  List<String> navButtons = ['SEARCH', 'HOTEL', 'FOOD', 'TRAVEL'];
  List<Map<String, dynamic>> data = [
    {'name': 'Night City', 'image': 'https://image.freepik.com/free-vector/futuristic-night-city-background_52683-9062.jpg', 'rating': 5.0},
    {'name': 'Cyber City', 'image': 'https://image.freepik.com/free-vector/city-extreme-sports-neon-cartoon_1441-3149.jpg', 'rating': 4.2},
    {'name': 'Middle Earth', 'image': 'https://image.freepik.com/free-vector/modern-city-night-skyline-neon-cartoon_1441-3160.jpg', 'rating': 3.5},
    {'name': 'Glowing City', 'image': 'https://image.freepik.com/free-vector/clock-tower-river-glowing-city_1441-3155.jpg', 'rating': 4.8},
    {'name': 'Metropolis City', 'image': 'https://image.freepik.com/free-vector/modern-metropolis-night-landscape-cartoon_1441-2832.jpg', 'rating': 2.5},
  ];
  int activeTab = 3;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent, systemNavigationBarDividerColor: Color(0xffF07F5F), systemNavigationBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Row(children: [Expanded(child: Container(color: Colors.white)), Expanded(child: Container(color: Color(0xff502F88)))]),
          Row(
            children: [
              Expanded(
                flex: 9,
                child: Column(children: [
                  Expanded(flex: 3, child: Container(decoration: BoxDecoration(color: Color(0xff502F88), borderRadius: BorderRadius.vertical(bottom: Radius.circular(60))), child: returnTitle())),
                  Expanded(flex: 7, child: Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(25))), child: returnList())),
                ]),
              ),
              Expanded(flex: 2, child: Container(child: returnNavBar()))
            ],
          )
        ],
      ),
    );
  }

  Widget returnTitle() {
    return Container(
      padding: EdgeInsets.only(top: 50, right: 40, left: 40, bottom: 30),
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("Hey, Hexoncode!", style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 20)),
          Text("Dream\nTravel Place", style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget returnNavBar() {
    return Container(
      height: double.maxFinite,
      padding: EdgeInsets.symmetric(vertical: 20),
      child: RotatedBox(
        quarterTurns: 3,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: List.generate(
              navButtons.length,
              (index) => Container(
                    margin: EdgeInsets.only(right: 50),
                    child: TextButton(
                      onPressed: () => setState(() => activeTab = index),
                      style: ButtonStyle(animationDuration: Duration(milliseconds: 500)),
                      child: Text(navButtons[index], style: GoogleFonts.ubuntu(color: index == activeTab ? Color(0xffF07F5F) : Colors.white30, fontSize: 20, fontWeight: FontWeight.bold)),
                    ),
                  )),
        ),
      ),
    );
  }

  Widget returnList() {
    return Container(
      padding: EdgeInsets.only(left: 25, right: 25),
      child: ListView(
        children: List.generate(data.length, (index) {
          return GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailedView(data: data[index], index: index))),
            child: Container(
              margin: EdgeInsets.only(bottom: 25),
              width: double.maxFinite,
              height: 180,
              decoration: BoxDecoration(color: Color(0xff502F88), borderRadius: BorderRadius.circular(35)),
              child: Stack(children: [
                ClipRRect(borderRadius: BorderRadius.circular(35), child: Hero(tag: 'bgImage$index', child: CachedNetworkImage(imageUrl: data[index]['image'], fit: BoxFit.fill))),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.bottomCenter,
                  child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Expanded(child: Text(data[index]['name'], style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold))),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(data[index]['rating'].toString(), style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        Container(width: 5),
                        FaIcon(FontAwesomeIcons.solidStar, color: Color(0xffF07F5F), size: 20)
                      ],
                    )
                  ]),
                ),
              ]),
            ),
          );
        }),
      ),
    );
  }
}

class DetailedView extends StatefulWidget {
  final Map<String, dynamic> data;
  final int index;

  const DetailedView({Key key, this.data, this.index}) : super(key: key);

  @override
  _DetailedViewState createState() => _DetailedViewState();
}

class _DetailedViewState extends State<DetailedView> {
  bool isBookmarked = false, isExpanded = false;
  double height;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff502F88),
      body: Stack(
        children: [
          Hero(tag: 'bgImage${widget.index}', child: CachedNetworkImage(imageUrl: widget.data['image'], fit: BoxFit.cover, height: double.maxFinite)),
          GestureDetector(onTap: () => Navigator.pop(context), child: Padding(padding: EdgeInsets.only(top: 50, left: 30), child: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white, size: 25))),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
                height: isExpanded ? height - 100 : height / 2,
                duration: Duration(milliseconds: 250),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        flex: 12,
                        child: Container(
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topRight: Radius.circular(50))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  child: Padding(
                                      padding: EdgeInsets.all(25),
                                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                        Text(widget.data['name'], style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold), maxLines: 2, softWrap: true),
                                        Container(height: 20),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: [
                                                Text(widget.data['rating'].toString(), style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
                                                Container(width: 10),
                                                FaIcon(FontAwesomeIcons.solidStar, color: Color(0xffF07F5F), size: 20),
                                                Container(width: 10),
                                                Text('Reviews', style: GoogleFonts.ubuntu(color: Colors.black38, fontSize: 20, fontWeight: FontWeight.bold)),
                                              ],
                                            ),
                                            GestureDetector(
                                                onTap: () => setState(() => isBookmarked = !isBookmarked),
                                                child: FaIcon(isBookmarked ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark, color: Color(0xff502F88), size: 25))
                                          ],
                                        ),
                                        Container(height: 40),
                                        Text('About', style: GoogleFonts.ubuntu(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
                                        Container(height: 10),
                                        Expanded(
                                          child: Text(
                                              '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.
                                          ''',
                                              maxLines: isExpanded ? 10000 : 5,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.ubuntu(color: Colors.black38, fontSize: 18, fontWeight: FontWeight.bold)),
                                        ),
                                      ]))),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                alignment: Alignment.center,
                                color: Color(0xffF07F5F),
                                child: Text('Book Now', style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        )),
                    Expanded(
                        flex: 2,
                        child: RotatedBox(
                            quarterTurns: 3,
                            child: TextButton(
                                onPressed: () => setState(() => isExpanded = !isExpanded),
                                child: Text(isExpanded ? 'READ LESS' : 'READ MORE', style: GoogleFonts.ubuntu(color: Color(0xffF07F5F), fontSize: 20, fontWeight: FontWeight.bold)))))
                  ],
                )),
          )
        ],
      ),
    );
  }
}
