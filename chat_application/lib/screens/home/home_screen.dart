import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_application/screens/home/bloc/home_bloc.dart';
import 'package:chat_application/screens/home/components/header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  final storys = [
    'a',
    'a',
    'a',
  ];

  HomeScreen(this.user);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(GetUsers()),
      child: Builder(
        builder: (context) => _buildView(context),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);
    return SafeArea(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          size: 30,
          Icons.message,
          color: Colors.white,
        ),
        backgroundColor: Colors.orange,
      ),
      body: BlocListener<HomeBloc, HomeState>(
        bloc: bloc,
        listener: (context, state) {
          if (state.status == HomeStatus.getConversationSuccess) {
            print('Success');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Header(user),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 153,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: storys.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 153,
                              width: 115.78,
                              margin: EdgeInsets.only(right: 25),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 171,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 125,
                    width: 103,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 20,
                        width: 231,
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 231,
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 231,
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 231,
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  bloc: bloc,
                  builder: (context, state) {
                    return ListView.builder(
                        itemCount: state.users.length,
                        itemBuilder: (context, index) {
                          final guest = state.users[index];
                          return InkWell(
                            onTap: () {
                              bloc.add(GetConversation(
                                  userId: user.uid, guestId: guest.id));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  guest.avatar != null
                                      ? Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            image: DecorationImage(
                                                image:
                                                    CachedNetworkImageProvider(
                                                        guest.avatar!),
                                                fit: BoxFit.cover),
                                          ))
                                      : Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/background3.jpg"),
                                                fit: BoxFit.cover),
                                          )),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${guest.username}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
