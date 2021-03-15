import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'dart:math';

void main() => runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Home()));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isOvenActive = false;
  int totalPokes = 61;
  double radius = 120, length = 20, sliderVal = 0;
  List<Map<String, dynamic>> ovenValues = [
    {'temp': 220, 'time': 35},
    {'temp': 180, 'time': 20},
    {'temp': 200, 'time': 20},
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Color(0xffF5F4F6),
      body: CustomScrollView(
        slivers: [
          SliverList(delegate: SliverChildListDelegate([Container(margin: EdgeInsets.symmetric(vertical: 50), child: returnDial())])),
          SliverList(delegate: SliverChildListDelegate([returnStartSlider()])),
          SliverList(delegate: SliverChildListDelegate(returnStages())),
        ],
      ),
    );
  }

  Widget returnDial() {
    return Stack(
      children: [
        Center(
          child: Container(
            height: 320,
            width: 320,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(offset: Offset(10, 10), blurRadius: 20, color: Colors.black26, spreadRadius: 8)],
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xff61616C), Color(0xff303039)], stops: [0.2, 0.8]),
            ),
            child: SleekCircularSlider(
              min: 0,
              max: 500,
              initialValue: isOvenActive ? double.parse(ovenValues[0]['temp'].toString()) : 0,
              appearance: CircularSliderAppearance(
                startAngle: 90,
                angleRange: 360,
                infoProperties: InfoProperties(
                  mainLabelStyle: GoogleFonts.inter(color: Colors.white.withAlpha(isOvenActive ? 255 : 50), fontSize: 60),
                  bottomLabelText: "\n${isOvenActive ? "ACTIVE" : "OFF"}",
                  modifier: (val) => val == 0 ? ' 000°' : ' ${val.toInt()}°',
                  bottomLabelStyle: GoogleFonts.inter(letterSpacing: 3, fontWeight: FontWeight.bold, fontSize: 16, color: isOvenActive ? Color(0xffFF5A41) : Colors.white24),
                ),
                animationEnabled: true,
                customColors: CustomSliderColors(
                    dotColor: isOvenActive ? Color(0xffFF7D24) : Color(0xff6F717D), progressBarColors: [Color(0xffFF7D24), Color(0xffFF5A41)], progressBarColor: Colors.black12, trackColor: Colors.black12),
                customWidths: CustomSliderWidths(handlerSize: 8, progressBarWidth: 10, shadowWidth: 0, trackWidth: 10),
              ),
            ),
          ),
        ),
        Transform(
          transform: Matrix4.translationValues(6, 15, 0),
          child: Transform.rotate(
            angle: 215 * (pi / 180),
            origin: Offset(0, radius),
            child: Center(
              child: Stack(
                children: List.generate(
                    totalPokes,
                    (index) => Transform(
                          origin: Offset(0, radius),
                          transform: Matrix4.rotationZ(((1.62 * pi) / totalPokes) * index),
                          child: Container(height: index % 10 == 0 ? length + 5 : length, width: index % 10 == 0 ? 3 : 2, color: Colors.white12),
                        )),
              ),
            ),
          ),
        ),
        Container(
            height: 275,
            alignment: Alignment.bottomCenter,
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(text: '${ovenValues[0]['time']}:00\n', style: GoogleFonts.inter(color: Colors.white24, fontWeight: FontWeight.bold, fontSize: 18)),
                  TextSpan(text: 'Time Left', style: GoogleFonts.inter(color: Colors.white24, fontWeight: FontWeight.bold, fontSize: 16))
                ])))
      ],
    );
  }

  Widget returnStartSlider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Stack(
        children: [
          Container(
            height: 65,
            width: double.maxFinite,
            decoration: BoxDecoration(color: Color(0xffE9E7EB), borderRadius: BorderRadius.circular(70)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Swipe to Stop', style: GoogleFonts.inter(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Swipe to Start', style: GoogleFonts.inter(color: Color(0xffFF7D24), fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          AnimatedContainer(
            duration: Duration(milliseconds: 100),
            height: 65,
            width: 150,
            transform: Matrix4.translationValues(sliderVal, 0, 0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(65),
              boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(5, 5), blurRadius: 10, spreadRadius: 5)],
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: sliderVal > 80 ? [Color(0xffFF901A), Color(0xffFF5A41)] : [Color(0xff61616C), Color(0xff303039)], stops: [0.2, 0.8]),
            ),
            child: Transform.rotate(angle: sliderVal > 80 ? 180 * (pi / 180) : 0 * (pi / 180), child: Icon(Icons.arrow_forward_ios_rounded, color: Colors.white, size: 30)),
          ),
          Opacity(
              opacity: 0.0,
              child: Slider(
                  value: sliderVal,
                  min: 0,
                  max: 160,
                  onChanged: (val) => setState(() => sliderVal = val),
                  onChangeEnd: (val) => setState(() {
                        sliderVal = val > 80 ? 160 : 0;
                        val > 80 ? isOvenActive = true : isOvenActive = false;
                      })))
        ],
      ),
    );
  }

  List<Widget> returnStages() {
    return List.generate(
        3,
        (index) => GestureDetector(
            onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) => BottomSheet(data: ovenValues[index], index: index, update: updateData),
                isDismissible: true,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(15)))),
            child: Padding(
              padding: EdgeInsets.only(right: 15, left: 15, top: index == 0 ? 50 : 0, bottom: 20),
              child: Container(
                padding: EdgeInsets.all(20),
                width: double.maxFinite,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 5, spreadRadius: 5)]),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(padding: EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10)), child: Icon(FontAwesomeIcons.fan, color: Colors.white)),
                            Container(width: 15),
                            RichText(
                              textAlign: TextAlign.start,
                              text: TextSpan(children: [
                                TextSpan(text: 'Stage ${index + 1}\n', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87)),
                                TextSpan(text: 'Bottom & Top Heater', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black87)),
                              ]),
                            )
                          ],
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, color: Colors.black)
                      ],
                    ),
                    Container(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(FontAwesomeIcons.thermometerQuarter, color: Colors.grey, size: 35),
                                Container(width: 5),
                                Text('${ovenValues[index]['temp']}°', style: GoogleFonts.inter(color: Colors.black87, fontSize: 28, fontWeight: FontWeight.w500))
                              ],
                            ),
                            Container(height: 20),
                            Container(
                              height: 8,
                              width: 150,
                              decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(20)),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(FontAwesomeIcons.clock, color: Colors.grey, size: 30),
                                Container(width: 10),
                                Text('${ovenValues[index]['time']}:00', style: GoogleFonts.inter(color: Colors.black87, fontSize: 28, fontWeight: FontWeight.w500))
                              ],
                            ),
                            Container(height: 20),
                            Container(
                              height: 8,
                              width: 150,
                              decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(20)),
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )));
  }

  updateData(Map<String, dynamic> data, int index) => setState(() => ovenValues[index] = data);
}

class BottomSheet extends StatefulWidget {
  final Map<String, dynamic> data;
  final int index;
  final Function update;

  const BottomSheet({Key key, this.data, this.index, this.update}) : super(key: key);

  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheet> {
  double height;
  int selectedTemp = Random().nextInt(80), selectedTimeMins = 0, _hour = Random().nextInt(24), _min = Random().nextInt(60);

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return Container(
      height: height - 80,
      decoration: BoxDecoration(color: Color(0xffF5F4F6)),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: GestureDetector(onTap: () => Navigator.pop(context), child: Text('Cancel', style: GoogleFonts.inter(color: Color(0xffFF7D24), fontSize: 18, fontWeight: FontWeight.w500)))),
              Expanded(child: Text('Stage ${widget.index + 1}', style: GoogleFonts.inter(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
              Expanded(child: Container())
            ],
          ),
          Container(height: 30),
          Text('Temperature', style: GoogleFonts.inter(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.bold)),
          Container(height: 15),
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 65),
                  child: PageView.builder(
                    itemCount: 81,
                    controller: PageController(viewportFraction: 0.27, initialPage: selectedTemp),
                    onPageChanged: (value) => setState(() => selectedTemp = value),
                    itemBuilder: (context, index) => Transform.translate(
                        offset: Offset(20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${100 + (index * 5)}', style: GoogleFonts.inter(fontSize: 35, color: index == selectedTemp ? Colors.black87 : Colors.black38, fontWeight: FontWeight.w500)),
                            Container(height: 15),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: List.generate(5, (ii) => Container(height: ii == 1 ? 20 : 12, width: 2, color: Colors.grey.withAlpha(index == selectedTemp ? 255 : 150))))
                          ],
                        )),
                  ),
                ),
                Center(
                  child: Container(
                    height: 135,
                    width: 100,
                    decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.bottomCenter,
                    child: Transform.translate(
                      offset: Offset(0, 10),
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Icon(Icons.play_arrow, color: Colors.white, size: 30),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(height: 50),
          Text('Cooking Time', style: GoogleFonts.inter(color: Colors.black87, fontSize: 22, fontWeight: FontWeight.bold)),
          Container(height: 15),
          Container(
            height: 200,
            width: double.maxFinite,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Hours', style: GoogleFonts.inter(color: Colors.black87, fontSize: 18)),
                      Container(width: 10),
                      Expanded(
                        child: Container(
                          height: 80,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Transform.translate(
                                offset: Offset(-10, 0),
                                child: RotatedBox(quarterTurns: 0, child: Icon(Icons.play_arrow, color: Colors.white, size: 30)),
                              ),
                              Transform.translate(offset: Offset(0, -5), child: Text(':', style: GoogleFonts.inter(fontSize: 50, color: Colors.grey))),
                              Transform.translate(
                                offset: Offset(10, 0),
                                child: RotatedBox(quarterTurns: 2, child: Icon(Icons.play_arrow, color: Colors.white, size: 30)),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(width: 10),
                      Text('Mins', style: GoogleFonts.inter(color: Colors.black87, fontSize: 18)),
                    ],
                  ),
                ),
                Transform.translate(
                  offset: Offset(10, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        child: PageView.builder(
                          itemCount: 25,
                          controller: PageController(viewportFraction: 0.27, initialPage: _hour),
                          scrollDirection: Axis.vertical,
                          onPageChanged: (val) => setState(() => _hour = val),
                          itemBuilder: (context, index) => Text('$index', style: GoogleFonts.inter(fontSize: 35, color: index == _hour ? Colors.black87 : Colors.black38, fontWeight: FontWeight.w500)),
                        ),
                      ),
                      Container(width: 50),
                      Container(
                        width: 50,
                        child: PageView.builder(
                          itemCount: 61,
                          controller: PageController(viewportFraction: 0.27, initialPage: _min),
                          scrollDirection: Axis.vertical,
                          onPageChanged: (val) => setState(() => _min = val),
                          itemBuilder: (context, index) => Text('$index', style: GoogleFonts.inter(fontSize: 35, color: index == _min ? Colors.black87 : Colors.black38, fontWeight: FontWeight.w500)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(height: 30),
          GestureDetector(
            onTap: () {
              widget.update({'temp': 100 + (selectedTemp * 5), 'time': (_hour * 60) + _min}, widget.index);
              Navigator.pop(context);
            },
            child: Container(
              height: 60,
              width: double.maxFinite,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xffFF901A), Color(0xffFF5A41)], stops: [0.2, 0.8]),
              ),
              child: Text('SAVE', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 18)),
            ),
          )
        ],
      ),
    );
  }
}
