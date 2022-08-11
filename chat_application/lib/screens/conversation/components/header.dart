import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            height: 30,
            width: 30,
            child: Icon(Icons.arrow_back),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            image: DecorationImage(
                image: AssetImage("assets/images/background3.jpg"),
                fit: BoxFit.cover
            ),
          )
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nguyen Huy Truong',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    )),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Active now',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
                ),
              ],
            ),
        Spacer(),
        Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.15),
            borderRadius: BorderRadius.circular(5)
          ),
          child: Icon(
            Icons.videocam_rounded,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.15),
              borderRadius: BorderRadius.circular(5)
          ),
          child: Icon(
            Icons.phone,
            color: Colors.grey,
          ),
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }

  PopupMenuItem buildItem(
      {required String text, required String value, required Icon icon}) {
    return PopupMenuItem(
        value: value,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            SizedBox(
              width: 10,
            ),
            Text('$text'),
          ],
        ));
  }
}
