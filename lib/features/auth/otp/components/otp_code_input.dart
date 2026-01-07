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
      errorTextStyle: AppTextStyles.bodyRegular.copyWith(
        color: AppColors.cxC11302,
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
          fontFamily: AppFonts.archivo,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          height: 1.4,
          letterSpacing: -0.01 * 18,
          color: AppColors.cx1E1E1E,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.cxDBDBDB, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      errorPinTheme: PinTheme(
        width: 55,
        height: 55,
        textStyle: const TextStyle(
          fontFamily: AppFonts.archivo,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          height: 1.4,
          letterSpacing: -0.01 * 18,
          color: AppColors.cx1E1E1E,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.cxC11302, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      focusedPinTheme: PinTheme(
        width: 55,
        height: 55,
        textStyle: const TextStyle(
          fontFamily: AppFonts.archivo,
          fontWeight: FontWeight.w600,
          fontSize: 18,
          height: 1.4,
          letterSpacing: -0.01 * 18,
          color: AppColors.cx1E1E1E,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.mainColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
