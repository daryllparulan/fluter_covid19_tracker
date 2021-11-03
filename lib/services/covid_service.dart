import 'dart:convert';

import 'package:flutter_covid19_tracker/models/country.dart';
import 'package:flutter_covid19_tracker/models/country_summary.dart';
import 'package:flutter_covid19_tracker/models/global_summary.dart';
import 'package:http/http.dart' as http;

class CovidService {
  Future<GlobalSummaryModel> getGlobalSummary() async {
    final data = await http.Client()
        .get(Uri.parse('https://api.covid19api.com/summary'));

    if (data.statusCode != 200) throw Exception();

    GlobalSummaryModel summary =
        GlobalSummaryModel.fromJson(json.decode(data.body));

    return summary;
  }

  Future<List<CountrySummaryModel>> getCountrySummary(String slug) async {
    final data = await http.Client().get(
        Uri.parse('https://api.covid19api.com/total/dayone/country/' + slug));

    if (data.statusCode != 200) throw Exception();

    List<CountrySummaryModel> summaryList = (json.decode(data.body) as List)
        .map<CountrySummaryModel>((item) => CountrySummaryModel.fromJson(item))
        .toList();
    return summaryList;
  }

  Future<List<CountryModel>> getCountryList() async {
    final data = await http.Client()
        .get(Uri.parse('https://api.covid19api.com/countries'));

    if (data.statusCode != 200) throw Exception();

    List<CountryModel> countries = (json.decode(data.body) as List)
        .map<CountryModel>((item) => CountryModel.fromJson(item))
        .toList();

    return countries;
  }
}