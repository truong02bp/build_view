import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final User user;

  Header(this.user);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.withOpacity(0.05),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {},
            child: Container(
              height: 30,
              width: 30,
              child: Icon(Icons.search),
            ),
          ),
          Spacer(),
          Text('Home',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              )),
          Spacer(),
          user.photoURL != null ? Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                    image: CachedNetworkImageProvider(user.photoURL!),
                    fit: BoxFit.cover),
              )) : Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                    image: AssetImage("assets/images/background3.jpg"),
                    fit: BoxFit.cover),
              )) ,
          SizedBox(
            width: 10,
          )
        ],
      ),
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
