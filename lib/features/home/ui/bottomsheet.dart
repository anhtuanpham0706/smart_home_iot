// import 'package:core_advn/common/ui/text_custom.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:smart_home_dev/common/ui/theme_textfield.dart';
//
// class BottomSheet extends StatefulWidget {
//
//   const BottomSheet({Key? key}) : super(key: key);
//
//   @override
//   State<BottomSheet> createState() => _BottomSheetState();
// }
//
// class _BottomSheetState extends State<BottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 300.0,
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(
//         horizontal: 20,
//         vertical: 20,
//       ),
//       child: Column(
//           children: <Widget>[
//             TextCustom('Chọn Thông số phòng',color: Colors.red,size: 18.sp,),
//             ThemeTextField(_ctrRoom, _focusRoom, Icons.phone_android_outlined, 'Name Room',type: TextInputType.name),
//             SizedBox(
//               width: 160,
//               child: DropdownButton(
//                 hint: _dropName == null
//                     ? Text('Chọn kiểu phòng')
//                     : Text(
//                   _dropName,
//                   style: TextStyle(color: Colors.black),
//                 ),
//                 isExpanded: true,
//                 iconSize: 30.0,
//                 style: TextStyle(color: Colors.black),
//                 items: _room.map(
//                       (RoomAdd list) {
//                     return DropdownMenuItem<String>(
//                       value: list.name,
//                       child: Text(list.name),
//                     );
//                   },
//                 ).toList(),
//                 onChanged: (val) {
//                   setState(
//                         () {
//                       // _dropName = 'abc';
//                       _dropName = val.toString();
//                       // _change_image(_dropName);
//                     },
//                   );
//                 },
//               ),
//             ),
//             ButtonCustom(_addRoom,TextCustom('Thêm Phòng',color: Colors.blue,)),
//           ]),
//
//     );
//   }
// }
