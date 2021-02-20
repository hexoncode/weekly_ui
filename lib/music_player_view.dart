import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';

void main() => runApp(MaterialApp(home: Home(), debugShowCheckedModeBanner: false));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> artistsData = [
    {'name': 'Eminem', 'image': 'https://pbs.twimg.com/profile_images/1218209106491793408/ZZ7zbeWL_400x400.jpg', 'totalSongs': 289, 'followers': '31.6M', 'following': '0', 'popularSong': 'Fack'},
    {'name': 'NF', 'image': 'https://kgo.googleusercontent.com/profile_vrt_raw_bytes_1587515314_10149.jpg', 'totalSongs': 54, 'followers': '2.3M', 'following': '16', 'popularSong': 'Let You Down'},
    {'name': 'Juice WRLD', 'image': 'https://www.nme.com/wp-content/uploads/2019/12/JuiceWRLD_NME_AFord-6601-696x442.jpg', 'totalSongs': 33, 'followers': '0', 'following': '0', 'popularSong': 'Lucid Dreams'},
    {
      'name': '50 Cent',
      'image': 'https://static.toiimg.com/thumb/msid-74811667,imgsize-183026,width-800,height-600,resizemode-75/74811667.jpg',
      'totalSongs': 91,
      'followers': '26.4M',
      'following': '239',
      'popularSong': 'In Da Club'
    },
    {
      'name': 'Snoop Dogg',
      'image': 'https://p2d7x8x2.stackpathcdn.com/wordpress/wp-content/uploads/2021/01/Snoop-Key-Visual_Photo-Credit-Mark-Owens-scaled.jpg',
      'totalSongs': 245,
      'followers': '55.2M',
      'following': '4K',
      'popularSong': 'Drop It Like It\'s Hot'
    },
  ];
  int selectedArtist = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Color(0xff1a1a1a),
      body: ListView(children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [FaIcon(FontAwesomeIcons.bars, color: Colors.white, size: 30), FaIcon(FontAwesomeIcons.bell, color: Colors.white, size: 30)]),
        ),
        Stack(
          children: [
            Transform.scale(scale: 1.4, child: Container(height: 500, width: 500, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey.withAlpha(100), width: 2)))),
            Transform.scale(scale: 1.2, child: CachedNetworkImage(imageUrl: artistsData[selectedArtist]['image'], imageBuilder: (context, imageProvider) => CircleAvatar(backgroundImage: imageProvider, radius: 250))),
            Container(
              height: 550,
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Artist", style: GoogleFonts.inter(color: Colors.white70, fontSize: 22, fontWeight: FontWeight.w500)),
                  Text(artistsData[selectedArtist]['name'], style: GoogleFonts.inter(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                  Container(height: 40),
                  GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Player(artistData: artistsData[selectedArtist]))),
                      child: Container(
                        height: 120,
                        width: 120,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red, boxShadow: [BoxShadow(color: Colors.red.withAlpha(80), blurRadius: 50, spreadRadius: 15)]),
                        child: FaIcon(Icons.play_arrow_rounded, color: Colors.white, size: 80),
                      ))
                ],
              ),
            )
          ],
        ),
        Container(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(text: "Songs\n\n", style: GoogleFonts.inter(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 16)),
                  TextSpan(text: "${artistsData[selectedArtist]['totalSongs']}", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28)),
                ]),
              ),
            ),
            Container(height: 60, width: 1, color: Colors.white30),
            Expanded(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(text: "Followers\n\n", style: GoogleFonts.inter(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 16)),
                  TextSpan(text: "${artistsData[selectedArtist]['followers']}", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28)),
                ]),
              ),
            ),
            Container(height: 60, width: 1, color: Colors.white30),
            Expanded(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(text: "Following\n\n", style: GoogleFonts.inter(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 16)),
                  TextSpan(text: "${artistsData[selectedArtist]['following']}", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 28)),
                ]),
              ),
            ),
          ],
        ),
        Container(height: 20),
        Container(height: 200, margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20), child: ListView(scrollDirection: Axis.horizontal, children: returnPopularArtists()))
      ]),
    );
  }

  List<Widget> returnPopularArtists() {
    return List.generate(artistsData.length, (index) {
      return GestureDetector(
          onTap: () => setState(() => selectedArtist = index),
          child: CachedNetworkImage(
            imageUrl: artistsData[index]['image'],
            imageBuilder: (context, imageProvider) => Container(
              width: 200,
              height: 200,
              margin: EdgeInsets.only(left: index == 0 ? 30 : 0, right: 30),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), image: DecorationImage(image: imageProvider, fit: BoxFit.cover)),
            ),
          ));
    });
  }
}

class Player extends StatefulWidget {
  final Map<String, dynamic> artistData;

  const Player({Key key, this.artistData}) : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  bool isMuted = false, isPlaying = true;
  double volumeLvl = 50, width;
  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController(initialScrollOffset: 0);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff1a1a1a),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: null,
          backgroundColor: Colors.transparent,
          toolbarHeight: 80,
          elevation: 0,
          title: GestureDetector(onTap: () => Navigator.pop(context), child: FaIcon(FontAwesomeIcons.arrowLeft, color: Colors.white, size: 35))),
      body: Column(children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(imageUrl: widget.artistData['image'], imageBuilder: (context, imageProvider) => CircleAvatar(backgroundImage: imageProvider, radius: 35)),
                Container(width: 20),
                Expanded(
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(text: "${widget.artistData['name']}\n", style: GoogleFonts.inter(color: Colors.white70, fontWeight: FontWeight.w500, fontSize: 22)),
                      TextSpan(text: "${widget.artistData['popularSong']}", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30)),
                    ]),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
            flex: 15,
            child: Row(children: [
              Expanded(
                  flex: 8,
                  child: Stack(children: [
                    Container(child: ListView(controller: scrollController, children: returnBackTimeStamps())),
                    Container(child: ListView(controller: scrollController, shrinkWrap: true, children: returnTimeStamps())),
                    Center(
                      child: Row(
                        children: [
                          Expanded(flex: 2, child: Container()),
                          Expanded(child: Container(height: 5, decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.transparent, Colors.red], begin: Alignment.centerLeft, end: Alignment.centerRight)))),
                          Container(
                            decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Text("0:20", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                          )
                        ],
                      ),
                    ),
                    Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Container(height: 80, decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xff1a1a1a), Colors.transparent], begin: Alignment.topCenter, end: Alignment.bottomCenter))),
                      Container(
                        height: 80,
                        padding: EdgeInsets.only(bottom: 20, right: 20),
                        decoration: BoxDecoration(gradient: LinearGradient(colors: [Color(0xff1a1a1a), Colors.transparent], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text("4:20", style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 25)),
                        ),
                      )
                    ])
                  ])),
              Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          Stack(
                            children: [
                              Center(child: Container(height: 150, width: 8, decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(50)))),
                              Container(
                                  height: 150,
                                  alignment: Alignment.bottomCenter,
                                  child: Container(height: volumeLvl, width: 8, decoration: BoxDecoration(color: isMuted ? Colors.transparent : Colors.white, borderRadius: BorderRadius.circular(50)))),
                              Opacity(
                                  opacity: 0.0,
                                  child: RotatedBox(
                                      quarterTurns: 3,
                                      child: Slider(
                                          value: volumeLvl,
                                          min: 0,
                                          max: 150,
                                          onChanged: (val) => setState(() {
                                                volumeLvl = val;
                                                volumeLvl == 0 ? isMuted = true : isMuted = false;
                                              }))))
                            ],
                          ),
                          GestureDetector(
                            onTap: () => setState(() => isMuted = !isMuted),
                            child: FaIcon(isMuted ? FontAwesomeIcons.volumeMute : FontAwesomeIcons.volumeUp, color: Colors.white, size: 30),
                          )
                        ]),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            children: [
                              FaIcon(FontAwesomeIcons.backward, color: Colors.white, size: 35),
                              Container(height: 30),
                              FaIcon(FontAwesomeIcons.forward, color: Colors.white, size: 35),
                              Container(height: 30),
                              GestureDetector(
                                onTap: () => setState(() => isPlaying = !isPlaying),
                                child: CircleAvatar(backgroundColor: Colors.red, radius: 40, child: FaIcon(isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded, color: Colors.white, size: 45)),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
            ]))
      ]),
    );
  }

  List<Widget> returnTimeStamps() {
    return List.generate(
        200,
        (index) => Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 5,
                color: Colors.red,
                margin: EdgeInsets.only(bottom: 5),
                width: 100 + Random().nextInt(100 - 40).toDouble(),
              ),
            ));
  }

  List<Widget> returnBackTimeStamps() {
    return List.generate(200, (index) => Align(alignment: Alignment.centerLeft, child: Container(height: 5, color: Colors.grey.withAlpha(20), margin: EdgeInsets.only(bottom: 5))));
  }
}
