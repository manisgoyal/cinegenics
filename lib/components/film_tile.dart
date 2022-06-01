import 'package:cinegenics/components/poster_image.dart';
import 'package:cinegenics/theme.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../models/models.dart';

class MovieCard extends StatelessWidget {
  final TileData td;

  const MovieCard({
    Key? key,
    required this.td,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFF303030),
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.all(20),
        width: double.maxFinite,
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    td.title,
                    style: AppTheme.darkTextTheme.headline2,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: PieChart(
                      centerText: "${td.userRating}/10",
                      centerTextStyle: AppTheme.darkTextTheme.headline4,
                      initialAngleInDegree: -90,
                      ringStrokeWidth: 8.25,
                      chartRadius: 80,
                      legendOptions: const LegendOptions(
                        showLegends: false,
                      ),
                      dataMap: <String, double>{
                        td.title: td.userRating,
                      },
                      chartType: ChartType.ring,
                      baseChartColor: Colors.grey[50]!.withOpacity(0.15),
                      colorList: <Color>[
                        (td.userRating >= 8)
                            ? Colors.green
                            : (td.userRating >= 4)
                                ? Colors.yellow
                                : Colors.red
                      ],
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValueBackground: false,
                        showChartValues: false,
                        showChartValuesOutside: false,
                      ),
                      totalValue: 10,
                    ),
                  ),
                ],
              ),
              PosterImage(
                imageUrl: td.imageUrl,
              ),
              // Lottie.asset(
              //   "assets/animations/img_loading.json",
              //   height: 150,
              // )
            ],
          ),
        ),
      ),
      // ),
    );
  }
}
