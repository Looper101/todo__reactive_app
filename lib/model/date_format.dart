// import 'package:intl/intl.dart';

// class DateFormatModel {
//   //This method converts DateTime to String
//   static String dateFormatter(DateTime dateTime) {
//     DateTime today = DateTime.now().toLocal();
//     DateTime justnow = today.subtract(Duration(minutes: 1));
//     DateTime localDate = dateTime.toLocal();
//     // DateFormat('jm');

//     //just today
//     if (!localDate.difference(justnow).isNegative) {
//       return 'justnow';
//     }

// // minutes ago--
//     Duration minutesago = today.difference(dateTime);
//     if (minutesago.inMinutes >= 2) {
//       return "${minutesago.inMinutes.toString()} min ago";
//     }

// // //today
//     String roughString = DateFormat('jm').format(dateTime);
//     if (localDate.day == today.day &&
//         localDate.month == today.month &&
//         localDate.year == today.year) {
//       print(roughString);

//       return roughString;
//     }
// //yesterday
//     DateTime yesterday = today.subtract(Duration(days: 1));

//     if (localDate.day == yesterday.day &&
//         localDate.month == yesterday.month &&
//         localDate.year == yesterday.year) {
//       return 'Yesterday';
//     }

//     //weekday
//     if (today.difference(localDate).inDays > 4 &&
//         today.month == localDate.month &&
//         today.year == localDate.year) {
//       String weekDay = DateFormat('EEEE').format(localDate);
//       print('week : $weekDay');
//       return 'week ago';
//     }

//     if (today.difference(localDate).inDays > 30 &&
//         localDate.month == today.month &&
//         localDate.year == today.year) {
//       return 'month ago';
//     }

//     if (today.difference(localDate).inDays > 32 &&
//         localDate.year == today.year) {
//       Duration weeks = today.difference(localDate);
//       var daysToWeek = (weeks.inDays ~/ 7);
//       return '$daysToWeek weeks ago';
//     }
//     return dateTime.toString();
//   }
// }

// // class DateFormatModel {
// //   String dateFormatter(DateTime dateTime) {
// //     DateTime today = DateTime.today();
// //     DateTime justtoday = today.subtract(Duration(minutes: 1));
// //     DateTime localDate = dateTime.toLocal();

// //     //just today
// //     if (!localDate.difference(justtoday).isNegative) {
// //       return 'justtoday';
// //     }
// // //today

// // //     String roughString = DateFormat('jm').format(dateTime);
// // //     if (localDate.day == today.day &&
// // //         localDate.month == today.month &&
// // //         localDate.year == today.year) {
// // //       print(roughString);

// // //       return roughString;
// // //     }
// // //yesterday
// //     DateTime yesterday = today.subtract(Duration(days: 1));

// //     if (localDate.day == yesterday.day &&
// //         localDate.month == yesterday.month &&
// //         localDate.year == yesterday.year) {
// //       return 'Yesterday';
// //     }

// //     //weekday
// // //     if (today.difference(localDate).inDays > 4 &&
// // //         today.month == localDate.month &&
// // //         today.year == localDate.year) {
// // //       String weekDay = DateFormat('EEEE').format(localDate);
// // //       print('week : $weekDay');
// // //       return 'week ago';
// // //     }

// //     if (today.difference(localDate).inDays > 30 &&
// //         localDate.month == today.month &&
// //         localDate.year == today.year) {
// //       return 'month ago';
// //     }

// //     if (today.difference(localDate).inDays > 32 && localDate.year == today.year) {
// //       Duration weeks = today.difference(localDate);
// //       var daysToWeek = weeks.inDays ~/ 7;

// //       String weekCount = '$daysToWeek weeks ago';
// //       return weekCount;
// //     }
// //   }
// // }
