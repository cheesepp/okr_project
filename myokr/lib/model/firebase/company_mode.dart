import 'department_model.dart';

class Company {
  String name, country, phone, id, userID;
  DateTime date;
  List<Department>? list;
  // List<Employee>? listEmployee;
  Company({
    required this.id,
    required this.userID,
    required this.name,
    required this.country,
    required this.phone,
    required this.date,
    this.list,
    // this.listEmployee,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userID': userID,
      'name': name,
      'country': country,
      'phone': phone,
      'date': date,
      'list': list,
    };
  }

  Company.fromMap(Map<String, dynamic> map)
      : id = map['id'] ?? "",
        userID = map['userID'] ?? "",
        name = map['name'] ?? "",
        country = map['country'] ?? "",
        phone = map['phone'] ?? "",
        date = map['date'].toDate(),
        list = map['list'] ?? [];
}
