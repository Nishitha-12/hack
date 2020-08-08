import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter sidebar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Offset _offset = Offset(0, 0);
  GlobalKey globalKey = GlobalKey();
  List<double> limits = [];

  bool isMenuOpen = false;

  @override
  void initState() {
    limits = [0, 0, 0, 0, 0];
    WidgetsBinding.instance.addPostFrameCallback(getPosition);
    super.initState();
  }

  getPosition(duration) {
    RenderBox renderBox = globalKey.currentContext.findRenderObject();
    final position = renderBox.localToGlobal(Offset.zero);
    double start = position.dy - 20;
    double contList = position.dy + renderBox.size.height - 20;
    double step = (contList - start) / 5;
    limits = [];
    for (double x = start; x <= contList; x = x + step) {
      limits.add(x);
    }
    setState(() {
      limits = limits;
    });
  }

  double getSize(int x) {
    double size =
        (_offset.dy > limits[x] && _offset.dy < limits[x + 1]) ? 25 : 20;
    return size;
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    double sizebarSize = mediaQuery.width * 0.65;
    double menuContainerHeight = mediaQuery.height / 2;

    return SafeArea(
        child: Scaffold(
            body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(255, 65, 108, 1.0),
        Color.fromRGBO(255, 75, 73, 1.0)
      ])),
      width: mediaQuery.width,
      child: Stack(
        children: <Widget>[
          AnimatedPositioned(
            duration: Duration(milliseconds: 1500),
            left: isMenuOpen ? 0 : -sizebarSize + 20,
            top: 0,
            curve: Curves.elasticOut,
            child: SizedBox(
              width: sizebarSize,
              child: GestureDetector(
                onPanUpdate: (details) {
                  if (details.localPosition.dx <= sizebarSize) {
                    setState(() {
                      _offset = details.localPosition;
                    });
                  }

                  if (details.localPosition.dx > sizebarSize - 20 &&
                      details.delta.distanceSquared > 2) {
                    setState(() {
                      isMenuOpen = true;
                    });
                  }
                },
                onPanEnd: (details) {
                  setState(() {
                    _offset = Offset(0, 0);
                  });
                },
                child: Stack(
                  children: <Widget>[
                    CustomPaint(
                      size: Size(sizebarSize, mediaQuery.height),
                      painter: DrawerPainter(offset: _offset),
                    ),
                    Container(
                      height: mediaQuery.height,
                      width: sizebarSize,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            height: mediaQuery.height * 0.25,
                            child: Center(
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    "assets/dp2.jpeg",
                                    width: sizebarSize / 2,
                                  ),
                                  Text(
                                    "User",
                                    style: TextStyle(color: Colors.black45),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            thickness: 1,
                          ),
                          Container(
                            key: globalKey,
                            width: double.infinity,
                            height: menuContainerHeight,
                            child: Column(
                              children: <Widget>[
                                MyButton(
                                  text: "Profile",
                                  iconData: Icons.person,
                                  textSize: getSize(0),
                                  height: (menuContainerHeight) / 5,
                                ),
                                MyButton(
                                  text: "Notifications",
                                  iconData: Icons.notifications,
                                  textSize: getSize(1),
                                  height: (mediaQuery.height / 2) / 5,
                                ),
                                MyButton(
                                  text: "Settings",
                                  iconData: Icons.settings,
                                  textSize: getSize(2),
                                  height: (menuContainerHeight) / 5,
                                ),
                                MyButton(
                                  text: "Help",
                                  iconData: Icons.help,
                                  textSize: getSize(3),
                                  height: (menuContainerHeight) / 5,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    AnimatedPositioned(
                      duration: Duration(milliseconds: 400),
                      right: (isMenuOpen) ? 10 : sizebarSize,
                      bottom: 30,
                      child: IconButton(
                        enableFeedback: true,
                        icon: Icon(
                          Icons.keyboard_backspace,
                          color: Colors.black45,
                          size: 30,
                        ),
                        onPressed: () {
                          this.setState(() {
                            isMenuOpen = false;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    )));
  }
}

class MyButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final double textSize;
  final double height;

  MyButton({this.text, this.iconData, this.textSize, this.height});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(
            iconData,
            color: Colors.black38,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.black38, fontSize: textSize),
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}

class DrawerPainter extends CustomPainter {
  final Offset offset;

  DrawerPainter({this.offset});

  double getControlPointX(double width) {
    if (offset.dx == 0) {
      return width;
    } else {
      return offset.dx > width ? offset.dx : width + 75;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path();
    path.moveTo(-size.width, 0);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
        getControlPointX(size.width), offset.dy, size.width, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(-size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
