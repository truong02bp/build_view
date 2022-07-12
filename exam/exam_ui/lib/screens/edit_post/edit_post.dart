import 'dart:io';

import 'package:exam_ui/components/avatar.dart';
import 'package:exam_ui/components/comment_card.dart';
import 'package:exam_ui/constants.dart';
import 'package:exam_ui/models/post.dart';
import 'package:exam_ui/screens/edit_post/bloc/edit_post_bloc.dart';
import 'package:exam_ui/screens/posts/bloc/post_bloc.dart';
import 'package:exam_ui/time_ultils.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class EditPost extends StatelessWidget {
  Post post;
  final ImagePicker _picker = ImagePicker();

  EditPost({required this.post});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditPostBloc()..add(EditPostInitialEvent(post: post)),
      child: Builder(
        builder: (context) => _buildView(context),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    final user = post.user;
    int likes = 0;
    final bloc = BlocProvider.of<EditPostBloc>(context);
    if (post.interactBy != null) {
      likes = post.interactBy!.length;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Update post'),
        actions: [
          InkWell(
              onTap: () {
                bloc.add(UpdatePost());
              },
              child: const Center(child: Text('Update'))),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
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
                const Spacer(),
                InkWell(
                    onTap: () {
                      getFromSource(bloc);
                    },
                    child: const Icon(
                      Icons.image,
                      color: Colors.grey,
                    )),
                const SizedBox(
                  width: 20,
                )
              ],
            ),
          ),
          TextFormField(
            onChanged: (value) {
              bloc.add(UpdateCaption(value));
            },
            keyboardType: TextInputType.multiline,
            maxLength: null,
            maxLines: null,
            initialValue: post.caption,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(left: 20),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
            ),
          ),
          BlocConsumer<EditPostBloc, EditPostState>(
              bloc: bloc,
              listener: (context, state) {
                if (state.status == EditPostStatus.updatePostSuccess) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.SUCCES,
                    headerAnimationLoop: false,
                    animType: AnimType.TOPSLIDE,
                    closeIcon: const Icon(Icons.close_fullscreen_outlined),
                    desc: 'Upload post success!',
                    btnOkOnPress: () {
                      Navigator.pop(context, {"post" : state.post});
                    },
                  ).show();
                }
              },
              buildWhen: (previous, current) => current.status ==  EditPostStatus.pickImageSuccess || current.status == EditPostStatus.removeImageSuccess,
              builder: (context, state) {
                print(state.status);
                Widget child = Container();
                if (post.media != null && state.mediaId == null) {
                  child = Center(
                    child: ClipRRect(
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return Image.asset('assets/images/loading.gif');
                        },
                        imageUrl: minioHost + post.media!.url,
                      ),
                    ),
                  );
                }
                if (state.status == EditPostStatus.removeImageSuccess) {
                    child = Container();
                }
                if (state.status ==  EditPostStatus.pickImageSuccess) {
                  child = Image.file(state.file!);
                }
                return Stack(children: [
                  child,
                  Positioned(
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        bloc.add(RemoveImage());
                      },
                      child: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                    ),
                  )
                ]);
              }),
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
                Text('${post.totalComment} comments'),
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

  void getFromSource(bloc) async {
    final file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      bloc.add(PickImage(File(file.path)));
    }
  }
}
