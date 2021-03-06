import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryLoading extends StatelessWidget {
  final bool inputTextLoading;
  const CountryLoading({Key? key, required this.inputTextLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        inputTextLoading ? loadingInputCard() : Container(),
        loadingCard(),
        loadingCard(),
        loadingChartCard()
      ],
    );
  }

  Widget loadingInputCard() {
    return Card(
      elevation: 1,
      child: Container(
        height: 105,
        padding: const EdgeInsets.all(24),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            width: double.infinity,
            height: 57,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget loadingCard() {
    return Card(
      elevation: 1,
      child: Container(
        height: 95,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                Container(
                  width: 100,
                  height: 20,
                  color: Colors.white,
                ),
                Expanded(child: Container()),
                Container(
                  width: double.infinity,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  width: double.infinity,
                  height: 30,
                  color: Colors.white,
                )
              ],
            )),
      ),
    );
  }

  Widget loadingChartCard() {
    return Card(
      elevation: 1,
      child: Container(
        height: 165,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Expanded(
              child: Container(
            color: Colors.white,
          )),
        ),
      ),
    );
  }
}
