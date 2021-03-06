import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:random_user/random_user.dart';

void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Splash()));

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Color(0xff05102E),
      body: Padding(
        padding: EdgeInsets.all(35),
        child: Column(
          children: [
            Expanded(child: SvgPicture.asset('assets/people.svg')),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: [
                      TextSpan(text: 'Find your ', style: GoogleFonts.inter(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
                      TextSpan(text: 'twin\n', style: GoogleFonts.inter(color: Color(0xffE44F90), fontSize: 35, fontWeight: FontWeight.bold)),
                      TextSpan(text: 'soul ', style: GoogleFonts.inter(color: Color(0xffE44F90), fontSize: 35, fontWeight: FontWeight.bold)),
                      TextSpan(text: 'near you', style: GoogleFonts.inter(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
                    ])),
                Container(height: 50),
                GestureDetector(
                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home())),
                  child: Container(
                    height: 70,
                    width: double.maxFinite,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xffE44F90), Color(0xffDF5386)], begin: Alignment.topLeft, end: Alignment.bottomRight, stops: [0.3, 0.7]),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text('Find Someone', style: GoogleFonts.inter(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final users = RandomUser();
  List<User> souls = [];
  double width, height;
  CardController cardController;

  @override
  void initState() {
    super.initState();
    cardController = CardController();
    getSouls();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff05102E),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 100,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FaIcon(Foundation.graph_horizontal, color: Colors.white, size: 40),
              RichText(
                  text: TextSpan(children: [
                TextSpan(text: 'Red', style: GoogleFonts.inter(color: Color(0xffE44F90), fontSize: 30, fontWeight: FontWeight.bold)),
                TextSpan(text: 'nit', style: GoogleFonts.inter(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
              ])),
              FaIcon(Ionicons.ios_notifications_outline, color: Colors.white, size: 40),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => getSouls(),
        color: Color(0xffE44F90),
        backgroundColor: Colors.white,
        child: Stack(
          children: [
            ListView(),
            Column(
              children: [
                Expanded(
                    flex: 1,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: returnPeopleList(),
                    )),
                Container(height: 35),
                Expanded(
                    flex: 7,
                    child: Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: double.maxFinite,
                          width: double.maxFinite,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Color(0xff000920), borderRadius: BorderRadius.circular(60)),
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(text: 'No more ', style: GoogleFonts.inter(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
                              TextSpan(text: 'souls ', style: GoogleFonts.inter(color: Color(0xffE44F90), fontSize: 25, fontWeight: FontWeight.bold)),
                              TextSpan(text: 'found.\n', style: GoogleFonts.inter(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold)),
                              TextSpan(text: 'Refresh to get more!', style: GoogleFonts.inter(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                            ]),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TinderSwapCard(
                            totalNum: souls.length,
                            maxHeight: height,
                            maxWidth: width,
                            minWidth: width - 100,
                            minHeight: height - 100,
                            allowVerticalMovement: true,
                            swipeEdge: 4.0,
                            orientation: AmassOrientation.BOTTOM,
                            swipeUp: true,
                            swipeDown: true,
                            cardController: cardController,
                            swipeCompleteCallback: (orientation, index) {
                              switch (orientation) {
                                case CardSwipeOrientation.RECOVER:
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetails(soul: souls[index], index: index)));
                                  break;
                                case CardSwipeOrientation.LEFT:
                                  break;
                                case CardSwipeOrientation.RIGHT:
                                  break;
                                case CardSwipeOrientation.UP:
                                  break;
                                case CardSwipeOrientation.DOWN:
                                  break;
                              }
                            },
                            cardBuilder: (context, index) => returnSoulCard(index),
                          ),
                        ),
                      ],
                    )),
                Container(height: 25),
                Expanded(
                    flex: 2,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () => cardController.triggerLeft(),
                          child: Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Color(0xff5A6175), borderRadius: BorderRadius.circular(20)),
                            child: FaIcon(FontAwesomeIcons.times, color: Colors.white, size: 35),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => cardController.triggerRight(),
                          child: Container(
                            height: 90,
                            width: 90,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [Color(0xffE44F90), Color(0xffDF5386)], begin: Alignment.topLeft, end: Alignment.bottomRight, stops: [0.3, 0.7]), borderRadius: BorderRadius.circular(25)),
                            child: FaIcon(FontAwesomeIcons.heart, color: Colors.white, size: 50),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => cardController.triggerDown(),
                          child: Container(
                            height: 70,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(color: Color(0xff5A6175), borderRadius: BorderRadius.circular(20)),
                            child: FaIcon(FontAwesomeIcons.bolt, color: Colors.white, size: 35),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget returnSoulCard(int index) {
    return Stack(
      children: [
        Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), color: Colors.white.withAlpha(50))),
        Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 5)],
              image: DecorationImage(image: NetworkImage(souls[index].picture.large), fit: BoxFit.cover),
            )),
        Container(
          padding: EdgeInsets.all(35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(children: [FaIcon(FontAwesome.facebook_f, color: Colors.white, size: 25), Container(height: 20, width: 0), FaIcon(FontAwesome.instagram, color: Colors.white, size: 25)]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(souls[index].name.first.replaceFirst(souls[index].name.first[0], souls[index].name.first[0].toUpperCase()) + ", ${souls[index].dob.age}",
                            style: GoogleFonts.inter(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
                        Container(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FaIcon(Feather.navigation, color: Colors.white, size: 25),
                            Container(width: 10),
                            Expanded(
                              child: Text(souls[index].location.city.replaceFirst(souls[index].location.city[0], souls[index].location.city[0].toUpperCase()),
                                  style: GoogleFonts.inter(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(color: Colors.white30, borderRadius: BorderRadius.circular(20)),
                        child: FaIcon(Icons.arrow_upward_rounded, color: Colors.white, size: 30),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  List<Widget> returnPeopleList() {
    return List.generate(
        souls.length,
        (index) => GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetails(soul: souls[index], index: index))),
              child: Hero(
                tag: 'image$index',
                child: Container(
                  width: 65,
                  margin: EdgeInsets.only(left: index == 0 ? 20 : 0, right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.lerp(BorderRadius.circular(30), BorderRadius.circular(15), 0.6),
                      border: Border.all(color: Colors.grey, width: 2),
                      image: DecorationImage(image: NetworkImage(souls[index].picture.medium), fit: BoxFit.cover)),
                ),
              ),
            ));
  }

  getSouls() async => souls = await users.getUsers(gender: 'female', results: 10).whenComplete(() => setState(() {}));
}

class UserDetails extends StatefulWidget {
  final User soul;
  final int index;

  const UserDetails({Key key, this.soul, this.index}) : super(key: key);
  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  List<String> interests = ['Reading', 'Cycling', 'Running', 'Anime', 'Gaming'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff05102E),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 80,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(onTap: () => Navigator.pop(context), child: FaIcon(Icons.arrow_back, color: Colors.white, size: 35)),
            FaIcon(Icons.block, color: Colors.white, size: 35),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: ListView(
          children: [
            Hero(
              tag: 'image${widget.index}',
              child: Container(
                  height: 400, width: double.maxFinite, decoration: BoxDecoration(borderRadius: BorderRadius.circular(60), image: DecorationImage(image: NetworkImage(widget.soul.picture.large), fit: BoxFit.cover))),
            ),
            Container(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.soul.name.first.replaceFirst(widget.soul.name.first[0], widget.soul.name.first[0].toUpperCase()) + ", ${widget.soul.dob.age}",
                        style: GoogleFonts.inter(color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold)),
                    Container(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FaIcon(Feather.navigation, color: Colors.white, size: 25),
                        Container(width: 10),
                        Text(widget.soul.location.city.replaceFirst(widget.soul.location.city[0], widget.soul.location.city[0].toUpperCase()),
                            style: GoogleFonts.inter(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
                      ],
                    )
                  ],
                ),
                Row(children: [FaIcon(FontAwesome.facebook_f, color: Colors.white, size: 35), Container(width: 20), FaIcon(FontAwesome.instagram, color: Colors.white, size: 35)]),
              ],
            ),
            Container(height: 30),
            Text('Interests', style: GoogleFonts.inter(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500)),
            Container(height: 10),
            Wrap(
              direction: Axis.horizontal,
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                  interests.length,
                  (index) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(color: Color(0xff5A6175), borderRadius: BorderRadius.circular(10)),
                      child: Text(interests[index], style: GoogleFonts.inter(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)))),
            ),
            Container(height: 30),
            Text('Interests', style: GoogleFonts.inter(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500)),
            Container(height: 10),
            Text(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                style: GoogleFonts.inter(color: Colors.white, fontSize: 20)),
            Container(height: 30),
          ],
        ),
      ),
    );
  }
}
