part of 'widgets.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final EdgeInsetsGeometry margin;
  final TextEditingController controller;
  final TextInputAction action;
  final TextInputType type;
  final TextCapitalization caps;
  final String hintText;
  final String field;
  bool obscureText;
  bool validator;

  CustomTextField({
    this.margin,
    this.controller,
    this.action,
    this.type,
    this.caps = TextCapitalization.none,
    this.hintText,
    this.field,
    this.obscureText = false,
    this.validator,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              width: double.infinity,
              margin: widget.margin,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black),
              ),
              child: TextField(
                obscureText: widget.obscureText,
                textInputAction: widget.action,
                textCapitalization: widget.caps,
                keyboardType: widget.type,
                controller: widget.controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: greyFontStyle,
                  hintText: widget.hintText,
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    setState(() => widget.validator = false);
                  }
                },
              ),
            ),
            widget.field == 'pass'
                ? Container(
                    height: 50,
                    margin: EdgeInsets.only(right: 14),
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        if (widget.obscureText == true) {
                          setState(() => widget.obscureText = false);
                        } else {
                          setState(() => widget.obscureText = true);
                        }
                      },
                      child: Icon(
                        widget.obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.black,
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
        SizedBox(height: 8),
        widget.validator
            ? Row(
                children: [
                  Icon(Icons.error, color: redColor, size: 12),
                  SizedBox(width: 4),
                  Text(
                    (widget.validator && widget.controller.text.isEmpty)
                        ? "Please fill in this field"
                        : (widget.field == 'pass'
                            ? (widget.controller.text.length < 8
                                ? "Password must be at least 8 characters"
                                : null)
                            : (!widget.controller.text.contains('@')
                                ? "Invalid value for email address"
                                : null)),
                    style: statusFontStyle.copyWith(color: redColor),
                  ),
                ],
              )
            : SizedBox()
      ],
    );
  }
}
