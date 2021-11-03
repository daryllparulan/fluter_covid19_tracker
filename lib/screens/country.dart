import 'package:flutter/material.dart';
import 'package:flutter_covid19_tracker/models/country.dart';
import 'package:flutter_covid19_tracker/models/country_summary.dart';
import 'package:flutter_covid19_tracker/screens/country_loading.dart';
import 'package:flutter_covid19_tracker/screens/country_statistics.dart';
import 'package:flutter_covid19_tracker/services/covid_service.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

CovidService covidService = CovidService();

class Country extends StatefulWidget {
  const Country({Key? key}) : super(key: key);

  @override
  _CountryState createState() => _CountryState();
}

class _CountryState extends State<Country> {
  final TextEditingController _typeAheadController = TextEditingController();
  Future<List<CountryModel>>? countryList;
  Future<List<CountrySummaryModel>>? summaryList;

  @override
  void initState() {
    super.initState();
    countryList = covidService.getCountryList();
    summaryList = covidService.getCountrySummary("united-states");
    _typeAheadController.text = "United States of America";
  }

  List<String> _getSuggestions(List<CountryModel> list, String query) {
    List<String> matches = [];
    for (var item in list) {
      matches.add(item.country);
    }

    matches.retainWhere(
        (element) => element.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CountryModel>>(
      future: countryList,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Error"),
          );
        }
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CountryLoading(inputTextLoading: true),
            );
          default:
            return !snapshot.hasData
                ? const Center(
                    child: Text("Empty"),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                        child: Text(
                          "Type the country name",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      ),
                      TypeAheadFormField(
                        textFieldConfiguration: TextFieldConfiguration(
                            controller: _typeAheadController,
                            decoration: InputDecoration(
                                hintText: "Type here country name",
                                hintStyle: const TextStyle(fontSize: 16),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none)),
                                filled: true,
                                fillColor: Colors.grey[200],
                                contentPadding: const EdgeInsets.all(20),
                                prefixIcon: const Padding(
                                  padding: EdgeInsets.only(left: 24, right: 16),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                ))),
                        suggestionsCallback: (pattern) {
                          return _getSuggestions(snapshot.data!, pattern);
                        },
                        itemBuilder: (context, String suggestion) {
                          return ListTile(
                            title: Text(suggestion),
                          );
                        },
                        transitionBuilder:
                            (context, suggestionsBox, controller) {
                          return suggestionsBox;
                        },
                        onSuggestionSelected: (String suggestion) {
                          _typeAheadController.text = suggestion;
                          setState(() {
                            summaryList = covidService.getCountrySummary(
                                snapshot.data!
                                    .firstWhere((element) =>
                                        element.country == suggestion)
                                    .slug);
                          });
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      FutureBuilder<List<CountrySummaryModel>>(
                        future: summaryList,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text("Error"),
                            );
                          }
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return const Center(
                                child: CountryLoading(inputTextLoading: false),
                              );
                            default:
                              return !snapshot.hasData
                                  ? const Center(
                                      child: Text("Empty"),
                                    )
                                  : CountryStatistics(
                                      summaryList: snapshot.data!);
                          }
                        },
                      )
                    ],
                  );
        }
      },
    );
  }
}
