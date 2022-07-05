import 'package:flutter/material.dart';

class ThirdViewScreen extends StatelessWidget {
  const ThirdViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.92),
      appBar: AppBar(title: const Text('Third view')),
      body: Center(
          child: InkWell(
        borderRadius: BorderRadius.circular(7),
        onTap: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    content: Container(
                      height: 400,
                      width: 450,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Image.asset("assets/images/congratulations.png")),
                          const Text(
                            'Congratulations',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 17),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const Text('Congratulations, you won 500 points'),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 120,
                                height: 35,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey)),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Center(
                                      child: Row(
                                    children: const [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        Icons.cancel,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 120,
                                height: 35,
                                decoration: const BoxDecoration(
                                  color: Colors.blue,
                                ),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Center(
                                      child: Row(
                                    children: const [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        Icons.check,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Claim',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ));
        },
        splashColor: Colors.pink,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(7),
          ),
          child: const Text(
            'Push here',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      )),
    );
  }
}
