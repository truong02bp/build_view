import 'package:exam_ui/components/avatar.dart';
import 'package:exam_ui/models/comment.dart';
import 'package:exam_ui/models/user.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final Comment comment;

  CommentCard({required this.comment});

  @override
  Widget build(BuildContext context) {
    final User user = comment.user;
    return Container(
      child: Column(
        children:[
          Row(
          children: [
            SizedBox(width: 15,),
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
                      fontSize: 17,
                      fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${comment.content}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ],
        ),
          SizedBox(height: 15,),
          Column(
            children:         List.generate(comment.replies!.length, (index) => Row(
              children: [
                SizedBox(
                  width: 50,
                ),
                CommentCard(comment: comment.replies![index]),
              ],
            )),
          )
        ],
      ),
    );
  }
}
