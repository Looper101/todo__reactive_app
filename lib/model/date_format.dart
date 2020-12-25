import 'package:intl/intl.dart';

class DateFormatModel {
  String dateFormatter(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime justNow = now.subtract(Duration(minutes: 1));
    DateTime localDate = dateTime.toLocal();

    //just now
    if (!localDate.difference(justNow).isNegative) {
      return 'justnow';
    }
//today

    String roughString = DateFormat('jm').format(dateTime);
    if (localDate.day == now.day &&
        localDate.month == now.month &&
        localDate.year == now.year) {
      print(roughString);

      return roughString;
    }
//yesterday
    DateTime yesterday = now.subtract(Duration(days: 1));

    if (localDate.day == yesterday.day &&
        localDate.month == yesterday.month &&
        localDate.year == yesterday.year) {
      return 'Yesterday';
    }

    //weekday
    if (now.difference(localDate).inDays > 4 &&
        now.month == localDate.month &&
        now.year == localDate.year) {
      String weekDay = DateFormat('EEEE').format(localDate);
      print('week : $weekDay');
      return 'week ago';
    }

    if (now.difference(localDate).inDays > 30 &&
        localDate.month == now.month &&
        localDate.year == now.year) {
      return 'month ago';
    }

    if (now.difference(localDate).inDays > 32 && localDate.year == now.year) {
      Duration weeks = now.difference(localDate);
      var daysToWeek = (weeks.inDays ~/ 7);
      return '$daysToWeek weeks ago';
    }
  }
}

// class DateFormatModel {
//   String dateFormatter(DateTime dateTime) {
//     DateTime now = DateTime.now();
//     DateTime justNow = now.subtract(Duration(minutes: 1));
//     DateTime localDate = dateTime.toLocal();

//     //just now
//     if (!localDate.difference(justNow).isNegative) {
//       return 'justnow';
//     }
// //today

// //     String roughString = DateFormat('jm').format(dateTime);
// //     if (localDate.day == now.day &&
// //         localDate.month == now.month &&
// //         localDate.year == now.year) {
// //       print(roughString);

// //       return roughString;
// //     }
// //yesterday
//     DateTime yesterday = now.subtract(Duration(days: 1));

//     if (localDate.day == yesterday.day &&
//         localDate.month == yesterday.month &&
//         localDate.year == yesterday.year) {
//       return 'Yesterday';
//     }

//     //weekday
// //     if (now.difference(localDate).inDays > 4 &&
// //         now.month == localDate.month &&
// //         now.year == localDate.year) {
// //       String weekDay = DateFormat('EEEE').format(localDate);
// //       print('week : $weekDay');
// //       return 'week ago';
// //     }

//     if (now.difference(localDate).inDays > 30 &&
//         localDate.month == now.month &&
//         localDate.year == now.year) {
//       return 'month ago';
//     }

//     if (now.difference(localDate).inDays > 32 && localDate.year == now.year) {
//       Duration weeks = now.difference(localDate);
//       var daysToWeek = weeks.inDays ~/ 7;

//       String weekCount = '$daysToWeek weeks ago';
//       return weekCount;
//     }
//   }
// }
