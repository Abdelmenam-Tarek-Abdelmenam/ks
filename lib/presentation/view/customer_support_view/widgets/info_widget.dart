import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../resources/asstes_manager.dart';
import '../../../resources/styles_manager.dart';
import '../../../shared/widget/dividers.dart';

class InfoWidget extends StatefulWidget {
  const InfoWidget({super.key});

  @override
  State<InfoWidget> createState() => _InfoWidgetState();
}

class _InfoWidgetState extends State<InfoWidget> {
  List<InfoData> info = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              bottom: 10.0,
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(AssetsManager.ta, height: 180),
                Dividers.h15,
                CarouselSlider(
                  options: CarouselOptions(
                    enableInfiniteScroll: false,
                    autoPlay: true,
                  ),
                  items: InfoData.infoList.map((e) => InfoCard(e)).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard(this.item, {super.key});
  final InfoData item;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 400,
      width: double.infinity,
      padding: PaddingManager.p2.copyWith(top: 0),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  item.title,
              style: Theme.of(context)
                            .textTheme
                            .displayLarge!
                            .copyWith(fontSize: 16),
                  // style: const TextStyle(
                  //   fontSize: 20,
                  //   fontWeight: FontWeight.bold,
                  //   color: Colors.blueAccent,
                  // ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.body,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      // child: Card(
      //   color: Theme.of(context).colorScheme.onPrimary.withOpacity(0.3),
      //   elevation: 0,
      //   child: Directionality(
      //     textDirection: TextDirection.rtl,
      //     child: Column(
      //       children: [
      //         Text(
      //           item.title,
      //           style: Theme.of(context)
      //               .textTheme
      //               .displayLarge!
      //               .copyWith(fontSize: 16),
      //         ),
      //         Text(
      //           item.body,
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

class InfoData {
  String title;
  String body;

  InfoData(this.title, this.body);

  static List<InfoData> get infoList => [
    InfoData(
      "من نحن",
      "أكاديمية رياضية دولية تنظم مسابقات وفعاليات دولية لتطوير مهارات اللاعبين من جميع الأعمار والجنسيات.",
    ),
    InfoData(
      "مهمتنا",
      "• تنظيم مسابقات عالمية.\n"
          "• تطوير المهارات الرياضية.\n"
          "• التوسع عالميًا.",
    ),
    InfoData(
      "أكاديمية المواهب لكرة القدم",
      "نوفر برامج تدريبية حديثة لتطوير مهارات الشباب بأعلى المعايير الدولية مع مدربين خبراء.",
    ),
    InfoData(
      "برامج الأكاديمية",
      "• دورات تدريبية متخصصة.\n"
          "• مدربون عالميون.\n"
          "• فرص تنافسية دولية.",
    ),
    InfoData(
      "الانتشار العالمي",
      "نعمل في عدة دول لتطوير مهارات الرياضيين من جميع المستويات والتنافس عالميًا.",
    ),
  ];

}
