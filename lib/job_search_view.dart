import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Intro()));

class Intro extends StatefulWidget {
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Stack(children: [
        Row(children: [
          Expanded(flex: 8, child: Container(color: Colors.white)),
          Expanded(flex: 2, child: Container(color: Colors.black)),
        ]),
        Row(children: [
          Expanded(flex: 6, child: Container(color: Colors.white)),
          Expanded(
              flex: 3,
              child: Column(
                children: [
                  Expanded(flex: 7, child: Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)))),
                  Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Home())),
                        child: Container(
                          decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
                          alignment: Alignment.center,
                          child: Text('Start', style: GoogleFonts.inter(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500)),
                        ),
                      )),
                  Expanded(flex: 2, child: Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)))),
                ],
              )),
          Expanded(flex: 1, child: Container()),
        ]),
        Padding(
          padding: EdgeInsets.all(30),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(flex: 6, child: Container(alignment: Alignment.center, child: SvgPicture.asset('assets/job_search.svg', fit: BoxFit.contain, width: 280))),
            RichText(
              textAlign: TextAlign.start,
              text: TextSpan(children: [
                TextSpan(text: 'Find your\n', style: GoogleFonts.inter(color: Colors.black, fontSize: 35, fontWeight: FontWeight.w400)),
                TextSpan(text: 'dream job.', style: GoogleFonts.inter(color: Colors.black, fontSize: 40, fontWeight: FontWeight.w600)),
              ]),
            ),
            Expanded(flex: 4, child: Container()),
          ]),
        )
      ]),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> categories = [
    {'icon': FontAwesomeIcons.java, 'title': 'Java Developer', 'vacancies': 190},
    {'icon': FontAwesomeIcons.terminal, 'title': 'Server Manager', 'vacancies': 50},
    {'icon': FontAwesomeIcons.bug, 'title': 'QA Tester', 'vacancies': 250},
    {'icon': FontAwesomeIcons.html5, 'title': 'Web Developer', 'vacancies': 10},
    {'icon': FontAwesomeIcons.mobile, 'title': 'App Developer', 'vacancies': 100},
  ];

  List<Map<String, dynamic>> suggestions = [
    {
      'icon': FontAwesomeIcons.spotify,
      'company': 'Spotify',
      'position': 'QA Tester',
      'location': 'Sweden',
      'tasks': ['Fix Bugs', 'Listen Songs']
    },
    {
      'icon': FontAwesomeIcons.facebook,
      'position': 'App Developer',
      'company': 'Facebook Inc.',
      'location': 'USA',
      'tasks': ['Find new ways', 'to steal data']
    },
    {
      'icon': FontAwesomeIcons.google,
      'position': 'Server Manager',
      'company': 'Google Inc.',
      'location': 'USA',
      'tasks': ['Make room for', 'more stolen data']
    },
    {
      'icon': FontAwesomeIcons.youtube,
      'position': 'Web Developer',
      'company': 'YouTube Co.',
      'location': 'USA',
      'tasks': ['More Unskippable Ads', 'Thats It']
    },
    {
      'icon': FontAwesomeIcons.apple,
      'position': 'Java Developer',
      'company': 'Apple Co.',
      'location': 'USA',
      'tasks': ['Clean Washrooms', 'Go home']
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: null,
        toolbarHeight: 120,
        elevation: 0,
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(15)),
                alignment: Alignment.center,
                child: FaIcon(FontAwesomeIcons.gripLines, color: Colors.white, size: 25)),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => UserSkills())),
            child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(15)),
                alignment: Alignment.center,
                child: FaIcon(FontAwesomeIcons.userCog, color: Colors.white, size: 20)),
          )
        ]),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                      height: 65,
                      width: double.maxFinite,
                      decoration: BoxDecoration(color: Colors.black.withAlpha(20), borderRadius: BorderRadius.circular(20)),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          FaIcon(FontAwesomeIcons.search, color: Colors.black87),
                          Container(width: 15),
                          Expanded(
                              child: TextField(
                            maxLines: 1,
                            cursorColor: Colors.black,
                            style: GoogleFonts.inter(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w500),
                            decoration: InputDecoration.collapsed(hintText: 'Search for jobs', hintStyle: GoogleFonts.inter(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.w500)),
                          ))
                        ],
                      ))),
              Container(height: 30)
            ]),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Job Category', style: GoogleFonts.inter(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('View All', style: GoogleFonts.inter(color: Colors.black26, fontSize: 18)),
                ],
              ),
            ),
            Container(height: 20)
          ])),
          SliverList(delegate: SliverChildListDelegate([Container(height: 170, child: ListView(scrollDirection: Axis.horizontal, children: returnCategories())), Container(height: 30)])),
          SliverList(
              delegate: SliverChildListDelegate([
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Suggestions', style: GoogleFonts.inter(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('View All', style: GoogleFonts.inter(color: Colors.black26, fontSize: 18)),
                ],
              ),
            ),
            Container(height: 20)
          ])),
          SliverList(delegate: SliverChildListDelegate(returnSuggestions())),
        ],
      ),
    );
  }

  List<Widget> returnCategories() {
    return List.generate(
        categories.length,
        (index) => Container(
              height: 170,
              width: 140,
              margin: EdgeInsets.only(right: 20, left: index == 0 ? 20 : 0),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.accents[Random().nextInt(Colors.accents.length)], borderRadius: BorderRadius.circular(20)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                FaIcon(categories[index]['icon'], color: Colors.white, size: 40),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(children: [
                        TextSpan(text: categories[index]['title'], style: GoogleFonts.inter(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        TextSpan(text: "\n${categories[index]['vacancies']} Vacancies", style: GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w400)),
                      ]),
                    ),
                  ),
                )
              ]),
            ));
  }

  List<Widget> returnSuggestions() {
    return List.generate(
        suggestions.length,
        (index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 140,
                width: double.maxFinite,
                margin: EdgeInsets.only(bottom: 20),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 65,
                          width: 65,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.accents[Random().nextInt(Colors.accents.length)], borderRadius: BorderRadius.circular(15)),
                          child: FaIcon(suggestions[index]['icon'], color: Colors.white, size: 35),
                        ),
                        Container(width: 15),
                        Expanded(
                          child: RichText(
                            text: TextSpan(children: [
                              TextSpan(text: suggestions[index]['company'] + "\n", style: GoogleFonts.inter(color: Colors.black38, fontSize: 18, fontWeight: FontWeight.bold)),
                              TextSpan(text: suggestions[index]['position'], style: GoogleFonts.inter(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold)),
                            ]),
                          ),
                        ),
                        Container(width: 15),
                        Text(
                          suggestions[index]['location'],
                          style: GoogleFonts.inter(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Container(height: 15),
                    Expanded(
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: List.generate(
                            suggestions[index]['tasks'].length,
                            (ii) => Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(color: Colors.black.withAlpha(20), borderRadius: BorderRadius.circular(30)),
                                  child: Text(
                                    suggestions[index]['tasks'][ii],
                                    style: GoogleFonts.inter(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                )),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }
}

class UserSkills extends StatefulWidget {
  @override
  _UserSkillsState createState() => _UserSkillsState();
}

class _UserSkillsState extends State<UserSkills> {
  List<Map<String, dynamic>> userSkills = [
    {'color': Colors.accents[Random().nextInt(Colors.accents.length)], 'icon': FontAwesomeIcons.java, 'topic': 'Java', 'xp': 6.0},
    {'color': Colors.accents[Random().nextInt(Colors.accents.length)], 'icon': FontAwesomeIcons.python, 'topic': 'Python', 'xp': 5.0},
    {'color': Colors.accents[Random().nextInt(Colors.accents.length)], 'icon': FontAwesomeIcons.wordpress, 'topic': 'Web', 'xp': 2.0},
    {'color': Colors.accents[Random().nextInt(Colors.accents.length)], 'icon': FontAwesomeIcons.mobile, 'topic': 'Android', 'xp': 8.0},
    {'color': Colors.accents[Random().nextInt(Colors.accents.length)], 'icon': FontAwesomeIcons.html5, 'topic': 'HTML/CSS', 'xp': 4.0}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        leading: null,
        toolbarHeight: 120,
        elevation: 0,
        title: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(15)),
              alignment: Alignment.center,
              child: Icon(Icons.arrow_back_ios_rounded, color: Colors.white, size: 25)),
        ),
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text('Choose your skills\nand experiences', style: GoogleFonts.inter(color: Colors.black, fontSize: 35, fontWeight: FontWeight.w300)),
        ),
        Container(height: 40),
        Expanded(
            child: ListView(
          scrollDirection: Axis.horizontal,
          children: returnSkills(),
        )),
        Container(height: 20),
        Padding(
          padding: EdgeInsets.all(20),
          child: GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Intro())),
            child: Container(
                height: 65,
                width: double.maxFinite,
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(20)),
                child: Text('Show Results', style: GoogleFonts.inter(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500))),
          ),
        )
      ]),
    );
  }

  List<Widget> returnSkills() {
    return List.generate(
        userSkills.length,
        (index) => Stack(
              children: [
                Container(
                  width: 90,
                  height: double.maxFinite,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 20, left: index == 0 ? 20 : 0),
                  decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(20)),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 90,
                    height: userSkills[index]['xp'] * 45,
                    margin: EdgeInsets.only(right: 20, left: index == 0 ? 20 : 0),
                    decoration: BoxDecoration(color: userSkills[index]['color'], borderRadius: BorderRadius.circular(20)),
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.only(top: 10),
                    child: FaIcon(FontAwesomeIcons.gripHorizontal, color: Colors.white30, size: 30),
                  ),
                ),
                Container(
                  width: 90,
                  height: double.maxFinite,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(right: 20, left: index == 0 ? 20 : 0),
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FaIcon(userSkills[index]['icon'], color: Colors.white, size: 35),
                      Container(height: 20),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Text(userSkills[index]['topic'], style: GoogleFonts.inter(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
                Opacity(
                  opacity: 0.0,
                  child: Container(
                    width: 90,
                    height: double.maxFinite,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 20, left: index == 0 ? 20 : 0),
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Slider(value: userSkills[index]['xp'], max: 10, min: 1, onChanged: (double value) => setState(() => userSkills[index]['xp'] = value)),
                    ),
                  ),
                )
              ],
            ));
  }
}
