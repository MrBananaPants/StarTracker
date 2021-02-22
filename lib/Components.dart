//           Card(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//             elevation: 4,
//             clipBehavior: Clip.antiAlias,
//             margin: EdgeInsets.only(left: 13, right: 13, top: 3),
//             child: Container(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: Column(
//                 children: [
//                   ListTile(
//                     title: Text(
//                       'Timer',
//                     ),
//                   ),
//                   ButtonBar(
//                          buttonHeight: 40,
//                         buttonMinWidth: SizeConfig.blockSizeHorizontal * 38,
//                     alignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       RaisedButton(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         color: Color(0xFF3D5AFE),
//                         onPressed: () {},
//                         child: const Text('START'),
//                       ),
//                       RaisedButton(
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(5),
//                         ),
//                         color: Color(0xFF3D5AFE),
//                         onPressed: () {},
//                         child: const Text('STOP'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),

// MaterialBanner
//            if (showBanner == 1)
//                     MaterialBanner(
//                       content: const Text(
//                           'Deze app is nog in ontwikkeling. Er kunnen zich bugs voordoen.'),
//                       leading: CircleAvatar(
//                         child: Icon(Icons.error_outline),
//                       ),
//                       actions: [
//                         FlatButton(
//                           child: const Text('INFO'),
//                           onPressed: () {
//                             launch(
//                                 "https://github.com/MrBananaPants/StarTracker");
//                           },
//                         ),
//                         FlatButton(
//                           child: const Text('SLUITEN'),
//                           onPressed: () {
//                             setState(
//                               () {
//                                 showBanner = 0;
//                               },
//                             );
//                           },
//                         ),
//                       ],
//                     ),

// SnackBar test

//  Card(
//                     shape:
//                         RoundedRectangleBorder(                    borderRadius: BorderRadius.circular(10),
//                   ),
//                   elevation: 10,
//                     clipBehavior: Clip.antiAlias,
//                     margin: EdgeInsets.only(left: 13, right: 13, top: 3),
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: Column(
//                         children: [
//                           ListTile(
//                             title: Text(
//                               'Snackbar',
//                             ),
//                           ),
//                           ButtonBar(
//                             buttonHeight: 40,
//                             buttonMinWidth: 150,
//                             alignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               RaisedButton(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(7),
//                                 ),
//                                 color: Color(0xFF3D5AFE),
//                                 child: const Text('TOON SNACKBAR'),
//                                 onPressed: () {
//                                   //action
//                                 },
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   class SnackBarDemo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'SnackBar Demo',
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('SnackBar Demo'),
//         ),
//         body: MaterialApp(),
//       ),
//     );
//   }
// }
