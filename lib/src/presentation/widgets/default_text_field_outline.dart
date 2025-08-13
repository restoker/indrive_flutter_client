import 'package:flutter/material.dart';

class DefaultTextFieldOutline extends StatelessWidget {
  const DefaultTextFieldOutline({
    super.key,
    this.obscureText = false,
    required this.texto,
    required this.icono,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
    this.validator,
    this.initialValue,
    this.enabled = false,
  });

  final bool obscureText;
  final String texto;
  final IconData icono;
  final TextInputType keyboardType;
  final Function(String text) onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.2)),
      child: TextFormField(
        readOnly: enabled,
        initialValue: initialValue,
        onChanged: (value) => onChanged(value),
        validator: validator,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber, width: 2),
          ),
          label: Text(texto),
          prefixIcon: Container(
            margin: EdgeInsets.only(top: 10),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              // crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                Icon(icono),
                Container(width: 1, height: 20, color: Colors.grey),
              ],
            ),
          ),
          suffixIcon: texto.contains('Password')
              ? Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    // crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Icon(icono),
                      Container(width: 1, height: 20, color: Colors.grey),
                    ],
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
