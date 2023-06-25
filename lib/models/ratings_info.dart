class RatingInfo {
  String title;
  String fileName;
  int level;

  RatingInfo({
    required this.title,
    required this.fileName,
    required this.level,
  });
}

class RatingInfoSet {
  List<RatingInfo> ratingsInfo;

  RatingInfoSet({required this.ratingsInfo});
  static RatingInfoSet initCountRatings() {
    return RatingInfoSet(ratingsInfo: [
      RatingInfo(fileName: "snail.png", level: 1, title: "PUŽ"),
      RatingInfo(fileName: "zec.png", level: 2, title: "ZEC"),
      RatingInfo(fileName: "fox.png", level: 3, title: "LISICA"),
      RatingInfo(fileName: "tigar.png", level: 4, title: "TIGAR"),
      RatingInfo(fileName: "dragon.png", level: 5, title: "ZMAJ"),
    ]);
  }

  static RatingInfoSet initStrikeRatings() {
    return RatingInfoSet(ratingsInfo: [
      RatingInfo(fileName: "snail.png", level: 1, title: "PUŽ"),
      RatingInfo(fileName: "zec.png", level: 2, title: "ZEC"),
      RatingInfo(fileName: "fox.png", level: 3, title: "LISICA"),
      RatingInfo(fileName: "tigar.png", level: 4, title: "TIGAR"),
      RatingInfo(fileName: "dragon.png", level: 5, title: "ZMAJ"),
    ]);
  }

  RatingInfo getRatingInfo(double percentOfStars, List<double> bounds) {
    bounds.add(double.infinity);
    RatingInfo rez = ratingsInfo[0];
    for (int i = 1; i < bounds.length; i++) {
      if (percentOfStars >= bounds[i - 1] && percentOfStars < bounds[i]) {
        rez = ratingsInfo[i];
      }
    }
    return rez;
  }
}
