import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

StreamTransformer transformer<T>(T Function(dynamic data) fromJson) =>
    StreamTransformer<QuerySnapshot, List<T>>.fromHandlers(
      handleData: (QuerySnapshot data, EventSink<List<T>> sink) {
        final snaps = data.docs.map((doc) => doc.data()).toList();
        final users = snaps.map<T>((json) => fromJson(json)).toList();
        sink.add(users);
      },
    );

DateTime toDateTime(Timestamp value) {
  return value.toDate();
}

dynamic fromDateTimeToJson(DateTime date) {
  return date.toUtc();
}
