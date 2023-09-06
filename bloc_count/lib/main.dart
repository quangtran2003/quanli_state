import 'package:bloc_count/bloc_count.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHome(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  BlocCount _bloc = BlocCount();

  @override
  void initState() {
    _bloc.obseverChange();
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispo();
    super.dispose();
  }

  bool check = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          //color: Colors.blue,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StreamBuilder<int>(
                      stream: _bloc.streamLike,
                      initialData: 0,
                      builder: (context, snapshot) {
                        return Text('Số lượt like: ${snapshot.data}');
                      }),
                  StreamBuilder<int>(
                      stream: _bloc.streamComment,
                      initialData: 0,
                      builder: (context, snapshot) {
                        return Text('Số lượt comment:  ${snapshot.data}');
                      }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: StreamBuilder<int>(
                    stream: _bloc.streamInterAct,
                    initialData: 0,
                    builder: (context, snapshot) {
                      return Text('Số lượt tương tác: ${snapshot.data}');
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      _bloc.increaseLike();

                      _bloc.boolCheck();
                    },
                    child: Container(
                      child: Row(
                        children: [
                          StreamBuilder<bool>(
                              stream: _bloc.streamColor,
                              initialData: false,
                              builder: (context, snapshot) {
                                print(snapshot.data);
                                return Icon(
                                  Icons.thumb_up,
                                  color: snapshot.data == true
                                      ? Colors.blue
                                      : Colors.black.withOpacity(0.7),
                                );
                              }),
                          Text('Like')
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      //print('object');
                      _bloc.increaseComment();
                    },
                    child: Container(
                      child: const Row(
                        children: [Icon(Icons.comment), Text('Comment')],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
