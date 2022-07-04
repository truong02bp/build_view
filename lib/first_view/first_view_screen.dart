import 'package:flutter/material.dart';
import 'package:rikkeisoft_intern/second_view/second_view_screen.dart';

class FirstViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('First View'), actions: [
        InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SecondViewScreen()));
          },
          child: const Icon(Icons.arrow_forward_outlined),
        ),
        const SizedBox(
          width: 30,
        ),
      ]),
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.red,
            ),
          ),
          _buildBlueRow(),
          _buildBlueRow(),
          _buildYellowRow(height: 120),
          _buildYellowRow(height: 25),
        ],
      ),
    );
  }

  Row _buildBlueRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 6, right: 3),
            height: 175,
            color: Colors.blue,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 6, left: 3),
            height: 175,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }

  Row _buildYellowRow({required double height}) {
    return Row(
      children: [
        Expanded(
            child: Container(
                height: height,
                margin: const EdgeInsets.only(top: 6, right: 3),
                color: Colors.yellow)),
        Expanded(
            child: Container(
                height: height,
                margin: const EdgeInsets.only(top: 6, left: 3, right: 3),
                color: Colors.yellow)),
        Expanded(
            child: Container(
                height: height,
                margin: const EdgeInsets.only(top: 6, left: 3),
                color: Colors.yellow))
      ],
    );
  }
}
