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
    var parsedDate = DateTime.parse(dateAdded);
    return Stream.periodic(
      Duration(seconds: 1),
      (x) {
        var dateDiff = DateTime.now().difference(parsedDate);

        return '${dateDiff.inMinutes.toString()}  minutes ago';
      },
    );
  }
}
