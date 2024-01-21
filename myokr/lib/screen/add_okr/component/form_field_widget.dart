import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myokr/item/text_item.dart';

class FormFieldWidget extends StatefulWidget {
  const FormFieldWidget(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.labelText,
      required this.maxLength,
      required this.maxLines,
      required this.fontStyle,
      required this.padding, required this.onChanged})
      : super(key: key);
  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool maxLength;
  final int maxLines;
  final bool fontStyle;
  final bool padding;
  final Function(String) onChanged;
  @override
  State<FormFieldWidget> createState() => _FormFieldWidgetState();
}

class _FormFieldWidgetState extends State<FormFieldWidget> {
  String text = "";
  int maxLength = 0;
  double height = 55;
  Color color = Colors.black;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Stack(children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          height: widget.fontStyle ? null : height,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: color, width: 1)),
          child: Container(
            padding: EdgeInsets.only(
                left: 10,
                bottom: 5,
                top: widget.fontStyle
                    ? 10
                    : widget.labelText == 'Due Date' ||
                            widget.labelText == 'Data date'
                        ? 4
                        : 0),
            child: TextFormField(
              onChanged: widget.onChanged,
              validator: (val) {
                if (val!.isEmpty) {
                  setState(() {
                    color = Colors.red;
                    height = 70;
                  });
                  return 'Enter value';
                } else {
                  setState(() {
                    color = Colors.black;
                    height = 55;
                  });
                  return null;
                }
              },
              textAlign: TextAlign.start,
              controller: widget.controller,
              maxLength: null,
              maxLines: widget.maxLines,
              keyboardType: widget.labelText == 'Start' ||
                      widget.labelText == 'Target' ||
                      widget.labelText == 'Actual value'
                  ? TextInputType.number
                  : null,
              inputFormatters: <TextInputFormatter>[
                widget.labelText == 'Start' ||
                        widget.labelText == 'Target' ||
                        widget.labelText == 'Actual value'
                    ? FilteringTextInputFormatter.digitsOnly
                    : FilteringTextInputFormatter.singleLineFormatter,
                LengthLimitingTextInputFormatter(500)
              ],
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  suffixIcon: widget.labelText == 'Due Date' ||
                          widget.labelText == 'Data date'
                      ? IconButton(
                          onPressed: () => chooseDate(),
                          icon: const Icon(Icons.calendar_month_outlined))
                      : null,
                  hintStyle: const TextStyle(fontStyle: FontStyle.italic)),
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
                      getTittleTextBlack(widget.labelText, 16),
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
      ]),
    );
  }

  void chooseDate() async {
    DateFormat month = DateFormat.MMMM('en_US');
    final newDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(DateTime.now().year - 10),
        lastDate: DateTime(DateTime.now().year + 10));
    if (newDate == null) return;
    setState(() {
      widget.controller.text =
          '${newDate.day.toString()}/${month.format(newDate)}/${newDate.year.toString()}';
    });
  }
}
