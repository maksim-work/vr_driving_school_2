import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.fromLTRB(24,0,24,0),
              child: Text('We Got You.', style: TextStyle(fontSize: 60, fontWeight: FontWeight.w600, letterSpacing: -3, color: Colors.black87),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24,0,24,0),
              child: Text('Anytime.', style: TextStyle(fontSize: 60, fontWeight: FontWeight.w600, letterSpacing: -3, color: Colors.black26),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24,0,24,0),
              child: Text('Anything,', style: TextStyle(fontSize: 60, fontWeight: FontWeight.w600, letterSpacing: -3, color: Colors.black26),),
            ),
            SizedBox(height: 100,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,10,0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                    ),
                    onPressed: () async {
                      if(Platform.isAndroid){
                        if (!await launchUrl(Uri.parse(waMesAndroid('971521080615',
                        'Hello, I have an inquiry. Can you help?')), mode: LaunchMode.externalApplication)) {
                      }
                      }else{
                      if (!await launchUrl(Uri.parse(waMes('971521080615',
                      'Hello, I have an inquiry. Can you help?')), mode: LaunchMode.externalApplication)) {
                      if (!await launchUrl(Uri.parse(waMesWeb('971521080615',
                      'Hello, I have an inquiry. Can you help?')), mode: LaunchMode.externalApplication)) {}
                      }
                      }
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.whatsapp_rounded, size: 40,),
                        SizedBox(width: 4,),
                        Text('Chat', style: TextStyle(fontSize: 40, letterSpacing: -1),)
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }

  String waMes(String n, String m) => 'whatsapp://wa.me/$n?text=${Uri.encodeFull(m)}';
  String waMesAndroid(String n, String m) => 'whatsapp://send?phone=$n&text=${Uri.encodeFull(m)}';
  String waMesWeb(String n, String m) => 'https://wa.me/$n?text=${Uri.encodeFull(m)}';
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
