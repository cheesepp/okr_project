class Department {
  String nameLeader, emailLeader, phoneLeader, name, id;
  String idPrevious;
  List<Department>? list;
  // List<Employee>? listEmployee;
  Department({
    required this.idPrevious,
    required this.id,
    required this.nameLeader,
    required this.emailLeader,
    required this.phoneLeader,
    required this.name,
    this.list,
    // this.listEmployee,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idPrevious': idPrevious,
      'name': name,
      'nameLeader': nameLeader,
      'emailLeader': emailLeader,
      'phoneLeader': phoneLeader,
      'list': list,
    };
  }

  Department.fromMap(Map<String, dynamic> map)
      : id = map['id'] ?? "",
        idPrevious = map['idPrevious'] ?? "",
        name = map['name'] ?? "",
        nameLeader = map['nameLeader'] ?? "",
        emailLeader = map['emailLeader'] ?? "",
        phoneLeader = map['phoneLeader'] ?? "",
        list = map['list'] ?? [];
}
