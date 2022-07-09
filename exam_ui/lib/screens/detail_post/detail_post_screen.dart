import 'package:exam_ui/components/CommentCard.dart';
import 'package:exam_ui/components/avatar.dart';
import 'package:exam_ui/constants.dart';
import 'package:exam_ui/models/comment.dart';
import 'package:exam_ui/models/post.dart';
import 'package:exam_ui/time_ultils.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DetailPostScreen extends StatelessWidget {
  final Post post;

  DetailPostScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    final user = post.user;
    int likes = 0;
    int comments = 0;
    if (post.interactBy != null) {
      likes = post.interactBy!.length;
    }
    if (post.comments != null) {
      comments = post.comments!.length;
    }
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Avatar(
                  url: user.avatar.url,
                  size: 50,
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      formatDate(time: post.createdDate),
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, bottom: 10, top: 10),
            child: Text(
              '${post.caption}',
              style: TextStyle(fontSize: 17, color: Colors.black),
            ),
          ),
          post.media == null
              ? Container()
              : ClipRRect(
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Image.asset('assets/images/loading.gif');
                    },
                    imageUrl: minioHost + post.media!.url,
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                SizedBox(
                    height: 25,
                    width: 25,
                    child: SvgPicture.asset(
                      "assets/svgs/heart.svg",
                      semanticsLabel: 'Acme Logo',
                      color: Colors.black,
                    )),
                SizedBox(
                  width: 7,
                ),
                Text(
                  '$likes',
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                Text('$comments comments'),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
          Container(
            height: 20,
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
              width: 0.5,
              color: Colors.grey.withOpacity(0.3),
            ))),
          ),
          Column(
            children: List.generate(
                post.comments!.length,
                    (index) => CommentCard(
                  comment: post.comments![index],
                )),
          )
        ],
      ),
    );
  }
}
