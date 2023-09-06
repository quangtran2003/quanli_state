import 'dart:async';

import 'package:flutter/material.dart';

class BlocCount {
  int count_like = 0;
  int count_comment = 0;
  bool check = false;
  StreamController<int> _streamControllerLike = StreamController.broadcast();
  Stream<int> get streamLike => _streamControllerLike.stream;
  StreamSink<int> get _streamSinkLike => _streamControllerLike.sink;

  StreamController<int> _streamControllerComment = StreamController.broadcast();
  Stream<int> get streamComment => _streamControllerComment.stream;
  StreamSink<int> get _streamSinkComment => _streamControllerComment.sink;

  StreamController<bool> _streamControllerColor = StreamController.broadcast();
  Stream<bool> get streamColor => _streamControllerColor.stream;
  StreamSink<bool> get _streamSinkColor => _streamControllerColor.sink;
  int interAct = 0;
  StreamController<int> _streamControllerInterAct =
      StreamController.broadcast();
  Stream<int> get streamInterAct => _streamControllerInterAct.stream;
  StreamSink<int> get _streamSinkInterAct => _streamControllerInterAct.sink;

  void obseverChange() {
    streamLike.listen((event) {
      increaseLikeComment();
    });
    streamComment.listen((event) {
      increaseLikeComment();
    });
  }

  void increaseLikeComment() {
    interAct = count_comment + count_like;
    _streamSinkInterAct.add(interAct);
  }

  void increaseLike() {
    if (check == true) {
      count_like -= 1;
      check = !check;
    } else {
      count_like += 1;
      check = !check;
    }
    _streamSinkLike.add(count_like);
  }

  bool test = false;
  void boolCheck() {
    test = !test;
    _streamSinkColor.add(test);
  }

  void increaseComment() {
    count_comment += 1;
    _streamSinkComment.add(count_comment);
  }

  void dispo() {
    _streamSinkLike.close();
    _streamSinkComment.close();
    _streamSinkColor.close();
  }
}
