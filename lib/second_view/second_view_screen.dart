import 'package:flutter/material.dart';
import 'package:rikkeisoft_intern/third_view/third_view_screen.dart';

class SecondViewScreen extends StatelessWidget {
  const SecondViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.92),
        appBar: AppBar(title: const Text('Second view'), actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ThirdViewScreen()));
            },
            child: const Icon(Icons.arrow_forward_outlined),
          ),
          const SizedBox(
            width: 30,
          ),
        ]),
        body: ListView(
          padding: const EdgeInsets.all(5),
          children: [
            _buildTitle(title: 'Team A'),
            _buildListItem(name: 'John'),
            _buildListItem(name: 'Beth'),
            const SizedBox(
              height: 15,
            ),
            _buildTitle(title: 'Team B'),
            _buildListItem(name: 'Will'),
            _buildListItem(name: 'Miranda'),
            const SizedBox(
              height: 15,
            ),
            _buildTitle(title: 'Team C'),
            _buildListItem(name: 'Mike'),
            _buildListItem(name: 'Danny'),
          ],
        ));
  }

  Widget _buildTitle({required String title}) {
    return Center(
        child: Text(
      title,
      style: const TextStyle(
          fontSize: 18, color: Colors.black, fontWeight: FontWeight.w800),
    ));
  }

  Container _buildListItem({required String name}) {
    return Container(
      height: 70,
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 7,
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Icon(
              Icons.account_circle,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Text(name),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_outlined,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 15,
          )
        ],
      ),
    );
  }
}
