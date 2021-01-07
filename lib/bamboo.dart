void main() {
  var berlinWallFell = DateTime.utc(1960, DateTime.october, 1);
  var todayDate = DateTime.now();

  var difference = todayDate.difference(berlinWallFell);

  print(difference.inDays);
}
