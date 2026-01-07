import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iquarix/core/common/widgets/app_icon/svg_icon.dart';
import 'package:iquarix/iquarx_app.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomPhoneInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool enabled;
  final FocusNode? focusNode;

  const CustomPhoneInput({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.focusNode,
  });

  @override
  State<CustomPhoneInput> createState() => _CustomPhoneInputState();
}

class _CustomPhoneInputState extends State<CustomPhoneInput> {
  late final MaskTextInputFormatter _maskFormatter;
  late final FocusNode _internalFocusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _maskFormatter = MaskTextInputFormatter(
      mask: '## ### ## ##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy,
    );
    _internalFocusNode = widget.focusNode ?? FocusNode();
    _internalFocusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _internalFocusNode.removeListener(_handleFocusChange);
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _internalFocusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText != null) ...[
          Text(
            widget.labelText!,
            style: AppTextStyles.controlInputLabel1.copyWith(
              color: AppColors.cx1E1E1E,
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: widget.controller,
          focusNode: _internalFocusNode,
          enabled: widget.enabled,
          keyboardType: TextInputType.phone,
          inputFormatters: [_maskFormatter],
          onChanged: widget.onChanged,
          validator: widget.validator,
          style: AppTextStyles.controlInputValue.copyWith(
            color: AppColors.cx1E1E1E,
          ),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTextStyles.controlInputValue.copyWith(
              color: AppColors.cx6B7280,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SvgIcon(
                    icon: AppIcon.phoneIcon,
                    size: 24,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 9),
                  Text(
                    '+998',
                    style: AppTextStyles.controlInputValue.copyWith(
                      color: AppColors.cx1E1E1E,
                    ),
                  ),
                  const SizedBox(width: 13),
                  const SizedBox(
                    height: 24,
                    width: 1,
                    child: ColoredBox(color: AppColors.cxDBDBDB),
                  ),
                ],
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 16,
            ),
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(width: 1, color: _enabledBorderColor()),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 1.3,
                color: AppColors.mainColor,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                width: 1.3,
                color: AppColors.cxC11302,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(width: 1, color: AppColors.cxDBDBDB),
            ),
          ),
        ),
      ],
    );
  }

  Color _enabledBorderColor() {
    if (widget.controller == null) {
      return AppColors.cxDBDBDB;
    } else {
      if (widget.controller!.text.isNotEmpty) {
        return AppColors.mainColor;
      } else {
        return AppColors.cxDBDBDB;
      }
    }
  }
}
