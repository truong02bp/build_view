import 'package:flutter/material.dart';
import 'package:rikkeisoft_intern/third_view/third_view_screen.dart';

class SecondViewScreen extends StatelessWidget {
  final employees = [
    {'name': 'Nguyễn Huy Trường', 'team': 'A'},
    {'name': 'Lê Thu Trang', 'team': 'B'},
    {'name': 'Nguyễn Khả Khiêm', 'team': 'A'},
    {'name': 'Nguyễn Huy Giang', 'team': 'C'},
    {'name': 'Phạm Hồng Thái', 'team': 'A'},
    {'name': 'Vũ Ngọc Hồng Nhung', 'team': 'B'},
    {'name': 'Nguyễn Thị Thanh Phương', 'team': 'C'},
    {'name': 'Hoàng Thái Sơn', 'team': 'A'},
    {'name': 'Nguyễn Giang Ngân', 'team': 'B'},
  ];

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
          children: _buildListViewBody(),
        ));
  }

  List<Widget> _buildListViewBody() {
    List<Widget> widgets = [];
    employees.sort(
      (a, b) => a['team']!.compareTo(b['team']!),
    );
    String team = '';
    for (int i = 0; i < employees.length; i++) {
      final employee = employees[i];
      if (team == '' || i >0 && employees[i - 1]['team'] != employee['team']) {
        team = employee['team']!;
        widgets.add(_buildTitle(title: 'Team $team'));
      }
      widgets.add(_buildItem(name: employee['name']!));
    }
    return widgets;
  }

  Widget _buildTitle({required String title}) {
    return Center(
        child: Container(
      margin: const EdgeInsets.only(top: 5),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.w800),
      ),
    ));
  }

  Container _buildItem({required String name}) {
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
