import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:url_launcher/url_launcher.dart';

// class ProfilePage extends StatelessWidget {
//   String webUrl = 'http://m2cs.org/';
//   String emailUrl = 'mailto:m2cs786@gmail.com';
//   String fbUrl = 'https://www.facebook.com/M2CS-179991619396541/';

//   Widget _buildAvatar() {
//     return Container(
//       width: 110.0,
//       height: 110.0,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//       ),
//       padding: EdgeInsets.all(3.0),
//       child: ClipRect(child: Image.asset('assets/images/logo.png')),
//     );
//   }

//   Widget _buildCard() {
//     return Card(
//       color: Colors.black87,
//       margin: EdgeInsets.only(left: 10.0, right: 10.0),
//       elevation: 8.0,
//       child: Container(
//         margin: EdgeInsets.all(8.0),
//         padding: EdgeInsets.only(bottom: 8.0, left: 8.0),
//         child: Column(
//           children: <Widget>[
//             Align(
//               alignment: Alignment.topLeft,
//               child: Container(
//                 margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
//                 child: Text(
//                   'Contact Us',
//                   style: TextStyle(color: Colors.white, fontSize: 20.0),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () => _launchUrl(webUrl),
//               child: Row(
//                 children: <Widget>[
//                   Image.asset('assets/images/internet.png'),
//                   SizedBox(
//                     width: 20.0,
//                   ),
//                   Text(
//                     'http://m2cs.org/',
//                     maxLines: 2,
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10.0,
//             ),
//             GestureDetector(
//               onTap: () => _launchUrl(fbUrl),
//               child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   Image.asset('assets/images/facebook.png'),
//                   SizedBox(
//                     width: 20.0,
//                   ),
//                   Flexible(
//                     child: Text(
//                         'https://www.facebook.com/M2CS-179991619396541/',
//                         style: TextStyle(color: Colors.white)),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 10.0,
//             ),
//             GestureDetector(
//               onTap: () {
//                 _launchUrl(emailUrl);
//               },
//               child: Row(
//                 mainAxisSize: MainAxisSize.max,
//                 children: <Widget>[
//                   Image.asset('assets/images/email.png'),
//                   SizedBox(
//                     width: 20.0,
//                   ),
//                   Text('m2cs786@gmail.com',
//                       style: TextStyle(color: Colors.white)),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildContent() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         Text(
//           'Developed By',
//           style: TextStyle(
//               fontSize: 30.0,
//               color: Colors.white,
//               letterSpacing: 0.1,
//               fontWeight: FontWeight.bold,
//               fontFamily: 'serif-monospace'),
//         ),
//         _buildAvatar(),
//         _buildCard(),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Center(
//               child:
//               Image.asset('assets/images/3.jpeg',
//                fit: BoxFit.cover,
//                height: double.infinity,
//                width: double.infinity,)),
//           BackdropFilter(
//             filter: ui.ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
//             child: Container(
//               color: Colors.black.withOpacity(0.8),
//             ),
//           ),
//           _buildContent()
//         ],
//       ),
//     );
//   }


//   _launchUrl(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }


// }
