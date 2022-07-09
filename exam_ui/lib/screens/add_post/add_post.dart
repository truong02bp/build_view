import 'dart:io';

import 'package:exam_ui/components/avatar.dart';
import 'package:exam_ui/models/user.dart';
import 'package:exam_ui/screens/add_post/bloc/add_post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class AddPostScreen extends StatelessWidget {
  final User user;
  final ImagePicker _picker = ImagePicker();
  XFile? file;
  String caption = '';

  AddPostScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPostBloc(),
      child: Builder(
        builder: (context) => _buildView(context),
      ),
    );
  }

  Widget _buildView(BuildContext context) {
    final bloc = BlocProvider.of<AddPostBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create post"),
        actions: [
          InkWell(onTap: () {
            File? uploadFile;
            if (file != null) {
              uploadFile = File(file!.path);
            }
            bloc.add(UploadPost(file: uploadFile, caption: caption, userId: user.id));
          }, child: const Center(child: Text('Upload'))),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Row(
              children: [
                Avatar(
                  url: user.avatar.url,
                  size: 60,
                ),
                const SizedBox(
                  width: 20,
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
                    const Text(
                      'What\'s on your mind ?',
                      style: TextStyle(fontWeight: FontWeight.w300),
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
            TextFormField(
              onChanged: (value) {
                caption = value;
              },
              keyboardType: TextInputType.multiline,
              maxLength: null,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'Enter your think',
                contentPadding: EdgeInsets.only(left: 20),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
            ),
            BlocConsumer(
                bloc: bloc,
                listener: (context, state) {
                  if (state is UploadPostSuccess) {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.SUCCES,
                      headerAnimationLoop: false,
                      animType: AnimType.TOPSLIDE,
                      closeIcon: const Icon(Icons.close_fullscreen_outlined),
                      desc: 'Upload post success!',
                      btnOkOnPress: () {
                        Navigator.pop(context);
                      },
                    ).show();
                  }
                },
                buildWhen: (previous, current) => current is PickImageSuccess || current is RemoveImageSuccess,
                builder: (context, state) {
                  if (state is RemoveImageSuccess) {
                    file = null;
                  }
                  if (state is PickImageSuccess) {
                    return Stack(children: [
                      Image.file(state.file),
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
                  }
                  return Container();
                })
          ],
        ),
      ),
    );
  }

  void getFromSource(bloc) async {
    file = await _picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      bloc.add(PickImage(File(file!.path)));
    }
  }
}
