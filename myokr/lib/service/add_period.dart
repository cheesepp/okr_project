import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myokr/item/random_string.dart';

Future<void> createPeriod() async {
  CollectionReference ob = FirebaseFirestore.instance.collection('periods');
  String period = '';
  int month = 0;
  int quarter = 0;
  int year = 2022;
  for (month = 1; month < 12; month += 3) {
  
    String id = getRandomString(20);
    if (month == 1) {
      period = 'Kỳ 4/$year';
      quarter = 1;
    } else if (month == 4) {
      period = 'Kỳ 1/$year';
      quarter = 2;
    } else if (month == 7) {
      period = 'Kỳ 2/$year';
      quarter = 3;
    } else {
      period = 'Kỳ 3/$year';
      quarter = 4;
    }
    ob.doc(id).set({
      'id': id,
      'month': '$month-${month + 1}-${month + 2}',
      'year': year,
      'quarter': quarter,
      'period': period
    });
  }
}
