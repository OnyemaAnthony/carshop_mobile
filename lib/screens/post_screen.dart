import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:appinio_swiper/appinio_swiper.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final AppinioSwiperController controller = AppinioSwiperController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CupertinoPageScaffold(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: AppinioSwiper(
                swipeOptions: const AppinioSwipeOptions.all(),
                unlimitedUnswipe: true,
                controller: controller,
                unswipe: _unswipe,
                onSwipe: _swipe,
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 30,
                ),
                onEnd: _onEnd,
                cardsCount: candidates.length,
                cardsBuilder: (BuildContext context, int index) {
                  return ExampleCard(candidate: candidates[index]);
                },
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     const SizedBox(
            //       width: 80,
            //     ),
            //     swipeLeftButton(controller),
            //     const SizedBox(
            //       width: 20,
            //     ),
            //     swipeRightButton(controller),
            //     const SizedBox(
            //       width: 20,
            //     ),
            //     unSwipeButton(controller),
            //   ],
            //)
          ],
        ),
      ),
    );
  }

  void _swipe(int index, AppinioSwiperDirection direction) {}

  void _unswipe(bool unswiped) {
    if (unswiped) {
    } else {}
  }

  void _onEnd() {}
}

class ExampleCandidateModel {
  String? name;
  String? job;
  String? city;
  LinearGradient? color;

  ExampleCandidateModel({
    this.name,
    this.job,
    this.city,
    this.color,
  });
}

List<ExampleCandidateModel> candidates = [
  ExampleCandidateModel(
    name: 'Eight, 8',
    job: 'Manager',
    city: 'Town',
    color: gradientPink,
  ),
  ExampleCandidateModel(
    name: 'Seven, 7',
    job: 'Manager',
    city: 'Town',
    color: gradientBlue,
  ),
  ExampleCandidateModel(
    name: 'Six, 6',
    job: 'Manager',
    city: 'Town',
    color: gradientPurple,
  ),
  ExampleCandidateModel(
    name: 'Five, 5',
    job: 'Manager',
    city: 'Town',
    // color: gradientRed,
  ),
  ExampleCandidateModel(
    name: 'Four, 4',
    job: 'Manager',
    city: 'Town',
    //color: gradientPink,
  ),
  ExampleCandidateModel(
    name: 'Three, 3',
    job: 'Manager',
    city: 'Town',
    //color: gradientBlue,
  ),
  ExampleCandidateModel(
    name: 'Two, 2',
    job: 'Manager',
    city: 'Town',
    // color: gradientPurple,
  ),
  ExampleCandidateModel(
    name: 'One, 1',
    job: 'Manager',
    city: 'Town',
    //color: gradientRed,
  ),
];

const LinearGradient gradientRed = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFFFF3868),
    Color(0xFFFFB49A),
  ],
);

const LinearGradient gradientPurple = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF736EFE),
    Color(0xFF62E4EC),
  ],
);

const LinearGradient gradientBlue = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF0BA4E0),
    Color(0xFFA9E4BD),
  ],
);

const LinearGradient gradientPink = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFFFF6864),
    Color(0xFFFFB92F),
  ],
);

const LinearGradient kNewFeedCardColorsIdentityGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Color(0xFF7960F1),
    Color(0xFFE1A5C9),
  ],
);

class ExampleCard extends StatelessWidget {
  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      )),
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return DraggableScrollableSheet(
          maxChildSize: 1,
          expand: false,
          builder: (_, controller) {
            return Column(
              children: [
                Container(
                  width: 100,
                  height: 8,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: 100,
                    itemBuilder: (_, i) => ListTile(title: Text('Item $i')),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String d =
      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.';
  final ExampleCandidateModel candidate;

  ExampleCard({
    Key? key,
    required this.candidate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Flexible(
            child: Container(
              //alignment: Alignment.bottomCenter,
              padding: EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.grey,
                // gradient: candidate.color,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    d,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  Expanded(
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.thumb_up,
                            size: 50,
                          ),
                          GestureDetector(
                              onTap: () {
                                _showModalBottomSheet(context);
                              },
                              child: Icon(
                                Icons.comment,
                                size: 50,
                              ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // Container(
          //   padding: const EdgeInsets.all(15),
          //   decoration: const BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.only(
          //       bottomLeft: Radius.circular(10),
          //       bottomRight: Radius.circular(10),
          //     ),
          //   ),
          //   child: Row(
          //     children: [
          //       Column(
          //         mainAxisSize: MainAxisSize.min,
          //         mainAxisAlignment: MainAxisAlignment.center,
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           Text(
          //             candidate.name!,
          //             style: const TextStyle(
          //               color: Colors.black,
          //               fontWeight: FontWeight.bold,
          //               fontSize: 20,
          //             ),
          //           ),
          //           const SizedBox(
          //             height: 5,
          //           ),
          //           Text(
          //             candidate.job!,
          //             style: const TextStyle(
          //               color: Colors.grey,
          //               fontSize: 15,
          //             ),
          //           ),
          //           const SizedBox(
          //             height: 5,
          //           ),
          //           Text(
          //             candidate.city!,
          //             style: const TextStyle(
          //               color: Colors.grey,
          //               fontSize: 15,
          //             ),
          //           )
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

class ExampleButton extends StatelessWidget {
  final Function onTap;
  final Widget child;

  const ExampleButton({
    required this.onTap,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: child,
    );
  }
}

//swipe card to the right side
Widget swipeRightButton(AppinioSwiperController controller) {
  return ExampleButton(
    onTap: () => controller.swipeRight(),
    child: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: CupertinoColors.activeGreen,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: CupertinoColors.activeGreen.withOpacity(0.9),
            spreadRadius: -10,
            blurRadius: 20,
            offset: const Offset(0, 20), // changes position of shadow
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.check,
        color: CupertinoColors.white,
        size: 40,
      ),
    ),
  );
}

//swipe card to the left side
Widget swipeLeftButton(AppinioSwiperController controller) {
  return ExampleButton(
    onTap: () => controller.swipeLeft(),
    child: Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFFF3868),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF3868).withOpacity(0.9),
            spreadRadius: -10,
            blurRadius: 20,
            offset: const Offset(0, 20), // changes position of shadow
          ),
        ],
      ),
      alignment: Alignment.center,
      child: const Icon(
        Icons.close,
        color: CupertinoColors.white,
        size: 40,
      ),
    ),
  );
}

Widget unSwipeButton(AppinioSwiperController controller) {
  return ExampleButton(
    onTap: () => controller.unswipe(),
    child: Container(
      height: 60,
      width: 60,
      alignment: Alignment.center,
      child: const Icon(
        Icons.rotate_left_rounded,
        color: CupertinoColors.systemGrey2,
        size: 40,
      ),
    ),
  );
}
