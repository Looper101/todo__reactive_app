class DateParser {
  String addedDate;
  // static List<Todo> manipulate(List<Todo> todox) {
  //   List<Todo> manipulatedTodo = todox
  //       .asMap()
  //       .map(
  //         (i, value) => MapEntry(
  //           i,
  //           Todo(
  //               id: value.id,
  //               //add the function here
  //               addDate: fixIncomingDate(value.addDate),
  //               description: value.description,
  //               isDone: value.isDone),
  //         ),
  //       )
  //       .values
  //       .toList();

  //   return manipulatedTodo;
  // }

  // static Stream<String> dateEmmitter(String date) {
  //   return Stream.periodic(Duration(seconds: 5), (x) {
  //     DateTime parsedDate = DateTime.parse(date);

  //     Duration remTime = DateTime.now().difference(parsedDate);

  //     return remTime.inMinutes.toString();
  //   });
  // }

  // static fixIncomingDate(String date) {
  //   try {
  //     DateTime dt = DateTime.parse(date);
  //     String formatedDate = DateFormatModel.dateFormatter(dt);

  //     return formatedDate;
  //   } on FormatException {
  //     print("error message: format exception");
  //     return 'format error';
  //   }
  // }

  static Stream<String> dateStream(String dateAdded) {
    var parsedDate = DateTime.parse(dateAdded).toLocal();
    return Stream.periodic(
      Duration(seconds: 2),
      (x) {
        Duration remDate = DateTime.now().toLocal().difference(parsedDate);
        // var remDate = timeSinceCreated(dateDiff);
        // return '${dateDiff.inMinutes.toString()}  minutes ago';

        var stringifiedHour = hourAndMinuteDigitFixer(parsedDate.hour);
        var minute = hourAndMinuteDigitFixer(parsedDate.minute);
        var amPm = amPmDetector(parsedDate.hour);

        if (remDate.inDays >= 0) {
          return 'today $stringifiedHour:$minute:$amPm';
        } else {
          return "$remDate days ago $stringifiedHour:$minute:$amPm";
        }
      },
    );
  }

  static int timeSinceCreated(Duration duration) {
    DateTime currentDate = DateTime.now().toLocal();
    var dateDiff = currentDate.day - (duration.inDays);
    return dateDiff;
  }

  static amPmDetector(int hour) {
    if (hour >= 12) {
      return 'PM';
    } else {
      return 'AM';
    }
  }

  static String hourAndMinuteDigitFixer(int digit) {
    String stringifyedDigit = digit.toString();
    if (stringifyedDigit.length == 1) {
      return "0$stringifyedDigit";
    } else {
      return stringifyedDigit;
    }
  }
//TODO:  Create another method to convert String to DateTime

  //TODO: create a method that will take Date as an argument then return DateTime

  //or

  //TODO: create a method that will Take [the added DateTime ]and check its diff/subtrac t[from DateTime.now] (proly  getting a duration ) ,then if the duration is more than seven days then return TRUE if not return FALSE

  static bool dateDifference(DateTime x1) {
    DateTime today = DateTime.now().toLocal();

    Duration dateDiff = today.difference(x1);

    if (dateDiff.inDays < 7) {
      return true;
    } else {
      return false;
    }
  }

  //TODO: String to DateTime

  static DateTime stringToDateTime(String value) {
    DateTime parsedStringToDate = DateTime.parse(value);

    return parsedStringToDate;
  }

//String to duration

  static Duration stringToDateDiff(String value) {
    DateTime now = DateTime.now();
    DateTime parsedString = DateTime.parse(value);

    final dateDiff = now.difference(parsedString);
    return dateDiff;
  }
}
