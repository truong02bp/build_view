import 'package:exam_ui/components/avatar.dart';
import 'package:exam_ui/constants.dart';
import 'package:exam_ui/models/post.dart';
import 'package:exam_ui/models/user.dart';
import 'package:exam_ui/screens/add_post/add_post.dart';
import 'package:exam_ui/screens/detail_post/detail_post_screen.dart';
import 'package:exam_ui/screens/posts/bloc/post_bloc.dart';
import 'package:exam_ui/time_ultils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostScreen extends StatelessWidget {
  final User user;
  List<Post> posts = [];
  int page = 0;
  int limit = 20;
  ScrollController _scrollController = ScrollController();

  PostScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc()..add(PostInitialEvent(user: user)),
      child: Builder(
        builder: (context) => _buildView(context),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    final bloc = BlocProvider.of<PostBloc>(context);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        bloc.add(GetPostEvent(userId: user.id, page: page + 1, limit: limit));
        page += 1;
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddPostScreen(user: user))).then((value){
                        posts.clear();
                        page = 0;
                        bloc.add(PostInitialEvent(user: user));
              });
            },
            child: SizedBox(
                height: 20,
                width: 20,
                child: SvgPicture.asset(
                  "assets/svgs/add.svg",
                  semanticsLabel: 'Acme Logo',
                  color: Colors.white,
                )),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: BlocBuilder<PostBloc, PostState>(
        bloc: bloc,
        buildWhen: (previous, current) => current is GetPostSuccess || current is DeletePostSuccess,
        builder: (context, state) {
          if (state is GetPostSuccess) {
            posts.addAll(state.posts);
          }
          if (state is DeletePostSuccess) {
            posts.removeWhere((element) => element.id == state.postId);
          }
          return ListView.builder(
              controller: _scrollController,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                int likes = 0;
                int comments = 0;
                if (post.interactBy != null) {
                  likes = post.interactBy!.length;
                }
                if (post.comments != null) {
                  comments = post.comments!.length;
                }
                return InkWell(
                  onDoubleTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPostScreen(post: post)));
                  },
                  child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 1.5, color: Colors.grey.withOpacity(0.2)))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      formatDate(time: post.createdDate),
                                      style: const TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                PopupMenuButton(itemBuilder: (context) => [
                                  PopupMenuItem(child: Text('Edit')),
                                  PopupMenuItem(child: InkWell(onTap: (){
                                    Navigator.pop(context);
                                    bloc.add(DeletePostEvent(postId: post.id));
                                  },child: Text('Delete'))),
                                ])
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, bottom: 10, top: 10),
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
                                      return Image.asset(
                                          'assets/images/loading.gif');
                                    },
                                    imageUrl: minioHost + post.media!.url,
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(width: 10,),
                                SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: SvgPicture.asset(
                                      "assets/svgs/heart.svg",
                                      semanticsLabel: 'Acme Logo',
                                      color: Colors.black,
                                    )),
                                SizedBox(width: 7,),
                                Text('$likes', style: TextStyle(fontSize: 16),),
                                Spacer(),
                                Text('$comments comments'),
                                SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      )),
                );
              });
        },
      ),
    );
  }
}
