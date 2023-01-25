import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:vr_driving_school_2/help.dart';
import 'package:vr_driving_school_2/lesson.dart';
import 'package:vr_driving_school_2/menu.dart';

void main() async {
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VR Driving School',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        fontFamily: 'Manrope'
      ),
      home: const MyHomePage(title: 'VR Driving School'),
      routes: {
        '/help': (context) => const HelpPage(),
        '/menu': (context) => const MenuPage(),
        '/lesson': (context) => const LessonPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{
  bool _isIntroDone = false;
  late AnimationController _animationController;
  double _mWidth = 0;
  double _mHeight = 0;
  bool _isFirstRun = false;

  listItem() {
    return
      Padding(
        padding: const EdgeInsets.all(4),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/lesson');
          },
          child: Card(
            elevation: 5,
            shadowColor: Colors.black26,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(image: AssetImage('assets/temp.jpg')),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18,10,10,0),
                        child: Text('Introduction', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18,0,10,6),
                        child: Text('Extra driving lessons aren’t cheap, exams aren’t cheap, you wanna get it right on your first try. This course has your extra lessons. You can rewatch it over and over until you know how it’s done and you know you can do it too.',
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black54),),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18,0,12,8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Duration: 60 minutes', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.black26),),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.play_arrow_rounded),
                                      Text('Watch in VR')
                                    ],
                                  )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                      child:
                      IconButton(onPressed: () {},
                          icon: Icon(Icons.favorite_border_rounded),
                      color: Colors.white,)),
                ],
              ),
            ),
          ),
        ),
      );
  }

  @override
  void initState() {
    // TODO: implement initState
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 4));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isFirstRun) {
      _mWidth = MediaQuery.of(context).size.width;
      _mHeight = MediaQuery.of(context).size.height;
      _isFirstRun = true;
    }
    double aR = _mWidth/_mHeight;

    return FutureBuilder(
      future: Hive.openBox('mBox'),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          var box = Hive.box('mBox');
          if(box.get('introDone')!=null){
            _isIntroDone = box.get('introDone');
          }
          if(!_isIntroDone){
            const PageDecoration pDeco = PageDecoration(
              titleTextStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white),
              bodyTextStyle: TextStyle(fontSize: 18, color: Colors.white54),
              titlePadding: EdgeInsets.fromLTRB(0,20,0,0),
              imagePadding: EdgeInsets.zero,
              bodyFlex: 1,
              imageFlex: 4,
            );

            return Scaffold(
              body: Stack(
                children: [
                  AnimateGradient(
                    controller: _animationController,
                    primaryBegin: Alignment.topLeft,
                    primaryEnd: Alignment.bottomLeft,
                    secondaryBegin: Alignment.bottomLeft,
                    secondaryEnd: Alignment.topRight,
                    primaryColors: const [
                      Colors.yellow,
                      Colors.yellowAccent,
                    ],
                    secondaryColors: const [
                      Colors.yellow,
                      Colors.white,
                    ],
                    child: Container(),
                  ),
                  IntroductionScreen(
                    globalBackgroundColor: Colors.transparent,
                    pages: [
                      PageViewModel(
                          image: Padding(
                            padding: const EdgeInsets.all(50),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  <Widget> [
                                SizedBox(height: 200,),
                                SizedBox(width: 100,
                                    child: Image(image: AssetImage('assets/logo_0.png',), fit: BoxFit.cover, alignment: Alignment.center, width: aR < 0.5 ? _mWidth/3*2 : aR < 0.7 ? _mWidth*aR : _mWidth/3)),
                                SizedBox(height: 20,),
                                Text('Learn how to drive in practice through drive-along, explanation and graphics',
                                  style: TextStyle(
                                      fontSize: 36,
                                      letterSpacing: -1,
                                    fontWeight: FontWeight.w200
                                  ),)
                              ],
                            ),
                          ),
                          decoration: pDeco,
                        titleWidget: SizedBox.shrink(),
                        bodyWidget: SizedBox.shrink()
                      ),
                      PageViewModel(
                          image: Padding(
                            padding: const EdgeInsets.all(50),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  <Widget> [
                                SizedBox(height: 200,),
                                SizedBox(width: 100,
                                    child: Image(image: AssetImage('assets/logo_0.png',), fit: BoxFit.cover, alignment: Alignment.center, width: aR < 0.5 ? _mWidth/3*2 : aR < 0.7 ? _mWidth*aR : _mWidth/3)),
                                SizedBox(height: 20,),
                                Text('Identify flaws and risks and replay the lessons as often as you need to smooth them out',
                                  style: TextStyle(
                                      fontSize: 36,
                                      letterSpacing: -1,
                                    fontWeight: FontWeight.w200
                                  ),)
                              ],
                            ),
                          ),
                          decoration: pDeco,
                        titleWidget: SizedBox.shrink(),
                        bodyWidget: SizedBox.shrink()
                      ),
                      PageViewModel(
                          image: Padding(
                            padding: const EdgeInsets.all(50),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  <Widget> [
                                SizedBox(height: 200,),
                                SizedBox(width: 100,
                                    child: Image(image: AssetImage('assets/logo_0.png',), fit: BoxFit.cover, alignment: Alignment.center, width: aR < 0.5 ? _mWidth/3*2 : aR < 0.7 ? _mWidth*aR : _mWidth/3)),
                                SizedBox(height: 20,),
                                Text('Drive smoothly and confidently',
                                  style: TextStyle(
                                      fontSize: 36,
                                      letterSpacing: -1,
                                    fontWeight: FontWeight.w200
                                  ),)
                              ],
                            ),
                          ),
                          decoration: pDeco,
                        titleWidget: SizedBox.shrink(),
                        bodyWidget: SizedBox.shrink()
                      ),
                      PageViewModel(
                          image: Padding(
                            padding: const EdgeInsets.all(50),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  <Widget> [
                                SizedBox(height: 200,),
                                SizedBox(width: 100,
                                    child: Image(image: AssetImage('assets/logo_0.png',), fit: BoxFit.cover, alignment: Alignment.center, width: aR < 0.5 ? _mWidth/3*2 : aR < 0.7 ? _mWidth*aR : _mWidth/3)),
                                SizedBox(height: 20,),
                                Text('Tips and recommendations before heading into your driving exam',
                                  style: TextStyle(
                                      fontSize: 36,
                                      letterSpacing: -1,
                                    fontWeight: FontWeight.w200
                                  ),)
                              ],
                            ),
                          ),
                          decoration: pDeco,
                        titleWidget: SizedBox.shrink(),
                        bodyWidget: SizedBox.shrink()
                      ),
                      PageViewModel(
                          image: Padding(
                            padding: const EdgeInsets.all(50),
                            child:  Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children:  <Widget> [
                                SizedBox(height: 200,),
                                SizedBox(width: 100,
                                    child: Image(image: AssetImage('assets/logo_0.png',), fit: BoxFit.cover, alignment: Alignment.center, width: aR < 0.5 ? _mWidth/3*2 : aR < 0.7 ? _mWidth*aR : _mWidth/3)),
                                SizedBox(height: 20,),
                                Text('AED 50',
                                  style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                      fontSize: 18,
                                      letterSpacing: -.5,
                                    fontWeight: FontWeight.w200,

                                  ),),
                                Text('AED 30',
                                  style: TextStyle(
                                      fontSize: 48,
                                      letterSpacing: -1,
                                      fontWeight: FontWeight.w200
                                  ),),
                                Text('Subscribe and get everything you need for you to pass the exam',
                                  style: TextStyle(
                                      fontSize: 18,
                                      letterSpacing: -.4,
                                      fontWeight: FontWeight.w200
                                  ),)
                              ],
                            ),
                          ),
                          decoration: pDeco,
                        titleWidget: SizedBox.shrink(),
                        bodyWidget: SizedBox.shrink()
                      ),
                    ],
                    onDone: () {
                      setState(() {
                        box.put('introDone', true);
                        // _animationController.dispose();
                      });
                      HapticFeedback.heavyImpact();
                    },
                    onSkip: () {
                    },
                    showSkipButton: false,
                    skip: const Icon(Icons.skip_next, color: Colors.black87),
                    next: const Icon(Icons.arrow_forward_rounded, color: Colors.black87),
                    done: const Text("Learn", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
                    dotsDecorator: DotsDecorator(
                        size: const Size.square(10.0),
                        activeSize: const Size(20.0, 10.0),
                        activeColor: Colors.black87,
                        color: Colors.black54,
                        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                        activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)
                        )
                    ),
                  ),
                ],
              ),
            );
          }
        }

        return Scaffold(
          appBar: AppBar(
            title: Center(child: Text(widget.title,)),
            elevation: 0,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.menu_rounded,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/menu');
                },
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                listItem(),
                listItem(),
                listItem(),
                listItem(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 10,
            onPressed: () {
              Navigator.pushNamed(context, '/help');
            },
            child: const Icon(Icons.question_mark_rounded),
          ), //
        );
      },
    );

  }
}
