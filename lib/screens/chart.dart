import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_covid19_tracker/models/time_series_cases.dart';

class Chart extends StatelessWidget {
  final List<charts.Series<TimeSeriesCases, DateTime>> seriesList;
  final bool animate;

  const Chart(this.seriesList, {Key? key, required this.animate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      domainAxis: const charts.EndPointsTimeAxisSpec(),
    );
  }
}
