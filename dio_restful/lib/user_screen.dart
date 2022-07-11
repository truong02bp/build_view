import 'package:dio_restful/bloc/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => UserBloc()..add(UserInitialEvent()),
      child: Builder(builder: (context) => _buildView(context),),);
  }

  Widget _buildView(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(context);
    return Scaffold(
      body: Center(child: BlocBuilder<UserBloc, UserState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is GetUserSuccess) {
            return Text(state.user.name);
          }
          return const Text('');
        },
      ),),
    );
  }
}

