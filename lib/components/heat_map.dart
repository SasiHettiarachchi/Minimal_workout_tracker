import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:tracker/datetime/date_time.dart';

class MyHeatMap extends StatelessWidget {

  final Map<DateTime, int>? datasets;
  final String startDateYYYYMMDD; 

  const MyHeatMap({
    super.key,
    required this.datasets,
    required this.startDateYYYYMMDD,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: HeatMap(
           startDate: createDateTimeObject(startDateYYYYMMDD),
           endDate: DateTime.now().add(const Duration(days: 0)),
           datasets: datasets,
           colorMode: ColorMode.color,
           defaultColor: Colors.grey[100],
           textColor:Color.fromRGBO(109, 0, 82, 1),
           showColorTip: false,
           showText: true,
           scrollable: true,
           size: 30,
           colorsets: { 
            1: Color.fromRGBO(209, 120, 192, 1),
           },
           ),
      );
  
  }
}