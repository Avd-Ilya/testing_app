import 'package:core/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasicTextFieldWidget extends StatefulWidget {
  const BasicTextFieldWidget(
      {super.key,
      this.controller,
      this.error,
      required this.onChanged,
      required this.label,
      required this.hintText,
      this.errorHintText});
  final TextEditingController? controller;
  final String? error;
  final ValueChanged<String> onChanged;
  final String label;
  final String hintText;
  final String? errorHintText;

  @override
  State<BasicTextFieldWidget> createState() => _BasicTextFieldWidgetState();
}

class _BasicTextFieldWidgetState extends State<BasicTextFieldWidget> {
  late FocusNode myFocusNode;

  @override
  void initState() {
    myFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            myFocusNode.requestFocus();
          },
          child: SizedBox(
            width: double.infinity,
            height: 60,
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: ColorConstants.gray),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  bottom: 10,
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Builder(
                      builder: (context) {
                        if (widget.controller?.text != '') {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Text(
                              widget.label,
                              style: TextStyle(
                                fontSize: 12,
                                color:
                                    widget.error != null && widget.error != ''
                                        ? ColorConstants.error
                                        : ColorConstants.gray,
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                    TextField(
                      controller: widget.controller,
                      onChanged: (value) {
                        // onChanged!(maskFormatter.getUnmaskedText());
                        widget.onChanged(value);
                      },
                      onTapOutside: (event) {
                        // widget.onChanged(widget.controller?.text ?? '');
                        FocusScope.of(context).unfocus();
                      },
                      focusNode: myFocusNode,
                      // inputFormatters: [maskFormatter],
                      inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        isDense: true,
                        border: InputBorder.none,
                        hintText: widget.error != null && widget.error != ''
                            ? widget.errorHintText ?? widget.hintText
                            : widget.hintText,
                        hintStyle: const TextStyle(color: ColorConstants.gray),
                      ),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Builder(
          builder: (context) {
            if (widget.error != null && widget.error != '') {
              return Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  widget.error ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorConstants.error,
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
