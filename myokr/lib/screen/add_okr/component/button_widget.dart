import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:myokr/item/text_item.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget(
      {Key? key,
      required this.onTap,
      required this.color,
      required this.tittle})
      : super(key: key);
  final VoidCallback onTap;
  final Color color;
  final String tittle;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: double.infinity,
        child: tittle == 'Add new key result' || tittle == 'New Obj'
            ? DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(50),
                child: InkWell(
                  onTap: onTap,
                  splashColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Container(
                    color: Colors.white,
                    margin: tittle == 'Add new key result'
                        ? const EdgeInsets.symmetric(horizontal: 15)
                        : const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.add_circle_outline_rounded),
                          const SizedBox(
                            width: 10,
                          ),
                          getTittleTextBlack(tittle, 18)
                        ],
                      ),
                    ),
                  ),
                ))
            : ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: const BorderSide(color: Colors.black))),
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (states) => color)),
                onPressed: onTap,
                child: getTittleTextBlack(
                  tittle,
                  18,
                )));
  }
}
