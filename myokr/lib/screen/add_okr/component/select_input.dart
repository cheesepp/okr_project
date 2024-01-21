import 'package:flutter/material.dart';
import 'package:myokr/item/text_item.dart';


class SelectInputWidget extends StatefulWidget {
  const SelectInputWidget(
      {Key? key,
      required this.listobject,
      required this.value,
      required this.label,
      required this.onChanged})
      : super(key: key);
  final List<String> listobject;
  final String label;
  final Function(String?) onChanged;
  final String value;
  @override
  State<SelectInputWidget> createState() => _SelectInputWidgetState();
}

class _SelectInputWidgetState extends State<SelectInputWidget> {
  String type = '';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    type = widget.value;
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: Stack(
        children: [
          Container(
            height: 60,
          ),
          Container(
            height: 50,
            width: double.infinity,
            // padding: const EdgeInsets.only(left: 10),
            margin: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1),
                color: Colors.white),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(10),
                  value: type,
                  items: widget.listobject.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: widget.onChanged,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        getTittleTextBlack(widget.label, 16),
                        const Text(
                          ' *',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
