import 'dart:io';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DateTimeUtil {
  DateTime parseTime(date) {
    return Platform.isIOS ? (date as Timestamp).toDate() : (date as Timestamp).toDate();
  }

  String dateTime2str(DateTime dateTime) {
    return DateFormat('yyyy/mm/dd HH:mm').format(dateTime);
  }
}
