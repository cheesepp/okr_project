import 'package:flutter/material.dart';
import 'package:myokr/model/firebase/objective_model.dart';
import 'package:myokr/provider/firebase/objectives_provider.dart';
import 'package:myokr/screen/my_okr/component/item_objectives.dart';

class ListObjectives extends StatefulWidget {
  const ListObjectives({
    Key? key,
    required this.listObjectives,
    required this.status,
  }) : super(key: key);
  final List<ObjectivesModel> listObjectives;
  final ObjectivesStatus status;

  @override
  State<ListObjectives> createState() => _ListObjectivesState();
}

class _ListObjectivesState extends State<ListObjectives> {
  String tittle = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) =>
            ItemMyOKR(objectivesModel: widget.listObjectives[index],index:index),
        itemCount: widget.listObjectives.length);
  }
}
