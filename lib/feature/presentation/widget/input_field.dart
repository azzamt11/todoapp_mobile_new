import 'package:flutter/material.dart';


class InputField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode node;
  final int index;
  final String string;
  final bool obscure;
  final TextInputType textInputType;
  final Function onSubmitFunction;
  final Function? onTextIsNotEmptyFunction;
  final Function? onTextIsEmptyFunction;
  const InputField({
    Key? key,
    required this.controller,
    required this.node,
    required this.index,
    required this.string,
    required this.obscure,
    required this.textInputType,
    required this.onSubmitFunction,
    this.onTextIsNotEmptyFunction,
    this.onTextIsEmptyFunction
  }) : super(key: key);

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool hasBeenChanged= false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return inputTextField(
        size, widget.string, widget.controller, widget.obscure, 0);
  }
  Widget inputTextField(var size, String string, controller, bool obscureText, int index) {
    return SizedBox(
      height: 40,
      child: Focus(
        child: TextField(
          autofocus: false,
          cursorHeight: 25,
          cursorWidth: 1,
          cursorColor: Colors.black12,
          focusNode: widget.node,
          controller: controller,
          obscureText: obscureText,
          style: const TextStyle(
              fontSize: 15.5,
              height: 1.5,
              color: Colors.black
          ),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: 2, top: 2),
              alignLabelWithHint: true,
              isDense: true,
              focusColor: Colors.black,
              hintStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 15.5,
                  height: 1.5
              ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: string
          ),
          onSubmitted: (value) async{
            widget.onSubmitFunction();
          },
          onChanged: (value) async{
            if(value!="" && !hasBeenChanged) {
              widget.onTextIsNotEmptyFunction!();
              setState(() {
                hasBeenChanged= true;
              });
            } else if(value=="" && hasBeenChanged) {
              setState(() {
                widget.onTextIsEmptyFunction!();
                hasBeenChanged= false;
              });
            }
          },
          keyboardType: widget.textInputType,
        ),
      ),
    );
  }
}