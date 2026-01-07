import 'package:flutter/services.dart';
import 'package:iquarix/iquarx_app.dart';
import 'package:pinput/pinput.dart';

class OtpCodeInput extends StatelessWidget {
  const OtpCodeInput({
    super.key,
    required this.controller,
    required this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.onCompleted,
    this.hasError = false,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function(String)? onCompleted;
  final bool hasError;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChanged,
      autofocus: true,
      length: 6,
      errorTextStyle: const TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.red,
      ),
      onSubmitted: onSubmitted,
      onCompleted: onCompleted,
      keyboardType: TextInputType.number,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      showCursor: false,
      forceErrorState: hasError,
      closeKeyboardWhenCompleted: true,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      useNativeKeyboard: true,
      crossAxisAlignment: CrossAxisAlignment.end,
      defaultPinTheme: PinTheme(
        width: 55,
        height: 55,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 30,
          color: Colors.black,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          border: Border.all(color: const Color(0xFFE8E8E8), width: 1.2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      errorPinTheme: PinTheme(
        width: 55,
        height: 55,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 30,
          color: Colors.black,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          border: Border.all(color: Colors.red, width: 1.2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 55,
        height: 55,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 30,
          color: Colors.black,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          border: Border.all(color: Colors.blueAccent, width: 1.2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
