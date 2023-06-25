import 'package:flutter/material.dart';
import 'package:tablica_mnozenja/models/ratings_info.dart';
import 'package:tablica_mnozenja/utils/globals.dart';
import '../models/trophies_collections.dart';
import '../widgets/widget_functions.dart';

class Trophies extends StatefulWidget {
  const Trophies({Key? key}) : super(key: key);

  @override
  State<Trophies> createState() => _TrophiesState();
}

class _TrophiesState extends State<Trophies> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return TabBarView(
      children: [
        Column(
          children: [
            addVerticalSpace(30),
            _titleSection(tabOrder: 1),
            addVerticalSpace(30),
            _topSection(width: width, tabOrder: 1),
            addVerticalSpace(30),
            Expanded(
              child: SizedBox(
                width: width * 0.92,
                child: ListView.builder(
                  itemCount: TrophiesCollections.trophiesNumberCorrect.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TrophiesCollections.trophiesNumberCorrect[index].display(width * 0.92);
                  },
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            addVerticalSpace(30),
            _titleSection(tabOrder: 2),
            addVerticalSpace(30),
            _topSection(width: width, tabOrder: 2),
            addVerticalSpace(30),
            Expanded(
              child: SizedBox(
                width: width * 0.92,
                child: ListView.builder(
                  itemCount: TrophiesCollections.trophiesStrikes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TrophiesCollections.trophiesStrikes[index].display(width * 0.92);
                  },
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

Widget _titleSection({required int tabOrder}) {
  return Text(
    tabOrder == 1 ? "Nagrade za tačne odgovore" : "Nagrade za combo",
    style: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: tabOrder == 1
          ? const Color.fromARGB(255, 2, 51, 91)
          : const Color.fromARGB(255, 2, 68, 17),
    ),
  );
}

Widget _topSection({required double width, required int tabOrder}) {
  int maxStars = tabOrder == 1
      ? TrophiesCollections.maxStars(TrophiesCollections.trophiesNumberCorrect)
      : TrophiesCollections.maxStars(TrophiesCollections.trophiesStrikes);
  int currentStars = tabOrder == 1
      ? TrophiesCollections.stars(TrophiesCollections.trophiesNumberCorrect)
      : TrophiesCollections.stars(TrophiesCollections.trophiesStrikes);

  List<double> ratingsBoundsInPerc =
      tabOrder == 1 ? Globals.rankBoundsTab1 : Globals.rankBoundsTab2;
  double starsPercentage = currentStars / maxStars * 100;
  RatingInfoSet ratingInfoSet =
      tabOrder == 1 ? RatingInfoSet.initCountRatings() : RatingInfoSet.initStrikeRatings();
  RatingInfo ratingInfo = ratingInfoSet.getRatingInfo(starsPercentage, ratingsBoundsInPerc);

  TextStyle numStarsStyle = const TextStyle(
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
  return Container(
    width: width * 0.92,
    height: 100,
    decoration: BoxDecoration(
      color: tabOrder == 1 ? Colors.blue[100] : Colors.green[100],
      border: Border.all(
        width: 4,
        color: tabOrder == 1 ? Colors.blue : Colors.green,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
        Container(
          width: 65,
          height: 65,
          color: Colors.transparent,
          margin: const EdgeInsets.fromLTRB(5, 0, 0, 0),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "NIVO ${ratingInfo.level.toString()} : ${ratingInfo.title}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 32,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    currentStars.toString(),
                    style: numStarsStyle,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    " od ",
                    style: numStarsStyle,
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  Text(
                    maxStars.toString(),
                    style: numStarsStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: 70,
          height: 70,
          color: Colors.transparent,
          margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage("assets/level_avatars/${ratingInfo.fileName}"),
          ),
        )
      ],
    ),
  );
}
