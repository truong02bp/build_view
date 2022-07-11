import 'package:exam_ui/constants.dart';
import 'package:exam_ui/models/user.dart';
import 'package:exam_ui/screens/posts/posts_screen.dart';
import 'package:exam_ui/screens/users/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class UsersScreen extends StatelessWidget {
  List<User> users = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc()..add(UserInitialEvent()),
      child: Builder(
        builder: (context) => _buildView(context),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
        backgroundColor: Colors.white.withOpacity(0.92),
        appBar: AppBar(
          title: const Text('Users'),
        ),
        body: BlocBuilder(
            bloc: bloc,
            buildWhen: (previous, current) => current is GetUserSuccess,
            builder: (context, state) {
              if (state is GetUserSuccess) {
                users = state.users;
              }
              return ListView(
                padding: const EdgeInsets.all(5),
                children: List.generate(
                    users.length,
                    (index) => InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PostScreen(user: users[index])));
                        },
                        borderRadius: BorderRadius.circular(15),
                        child: _buildItem(user: users[index]))),
              );
            }));
  }

  Container _buildItem({required User user}) {
    return Container(
      height: 90,
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
          ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: CachedNetworkImage(
              height: 70,
              width: 70,
              fit: BoxFit.cover,
              placeholder: (context, url) {
                return Image.asset('assets/images/loading.gif');
              },
              imageUrl: minioHost + user.avatar.url,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Text(
            user.name,
            style: TextStyle(fontSize: 16.5),
          ),
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
