import 'package:easy_localization/easy_localization.dart';

import 'package:iquarix/iquarx_app.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class PhoneAuthPage extends StatelessWidget {
  const PhoneAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhoneAuthCubit>(
      create: (context) => sl<PhoneAuthCubit>(),
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        body: _PhoneAuthPageForm(),
      ),
    );
  }
}

class _PhoneAuthPageForm extends StatefulWidget {
  const _PhoneAuthPageForm();

  @override
  State<_PhoneAuthPageForm> createState() => _PhoneAuthPageFormState();
}

class _PhoneAuthPageFormState extends State<_PhoneAuthPageForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _phoneController;
  late final FocusNode _phoneFocus;
  late final ValueNotifier<bool> _isPhoneValidNotifier;

  static final _phoneMaskFormatter = MaskTextInputFormatter(
    mask: '## ### ## ##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  static const int _minPhoneLength = 9;
  static const String _countryCode = '+998';

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _phoneFocus = FocusNode();
    _isPhoneValidNotifier = ValueNotifier<bool>(false);

    _phoneController.addListener(_onPhoneChanged);
  }

  @override
  void dispose() {
    _phoneController
      ..removeListener(_onPhoneChanged)
      ..dispose();
    _phoneFocus.dispose();
    _isPhoneValidNotifier.dispose();
    super.dispose();
  }

  void _onPhoneChanged() {
    final isValid =
        _phoneController.text.replaceAll(' ', '').length >= _minPhoneLength;
    if (_isPhoneValidNotifier.value != isValid) {
      _isPhoneValidNotifier.value = isValid;
    }
  }

  String _getNormalizedPhone() {
    return _phoneController.text.replaceAll(' ', '').trim();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final phone = _getNormalizedPhone();
    context.read<PhoneAuthCubit>().submitPhone('$_countryCode$phone');
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.phoneRequired.tr();
    }

    if (value.replaceAll(' ', '').length < _minPhoneLength) {
      return LocaleKeys.invalidPhone.tr();
    }

    return null;
  }

  void _handlePhoneAuthSuccess(BuildContext context) {
    sl<AppRouter>().push(
      context,
      location: RouterKeys.otp,
      extra: {'phoneNum': _getNormalizedPhone()},
    );
  }

  void _handlePhoneAuthError(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
    context.read<PhoneAuthCubit>().completeShowError();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
      listener: (context, state) {
        switch (state) {
          case PhoneAuthError():
            _handlePhoneAuthError(context, state.failure.message);
          case PhoneAuthSuccess():
            _handlePhoneAuthSuccess(context);
          default:
            break;
        }
      },
      buildWhen: (prev, curr) =>
          curr is PhoneAuthLoading || curr is PhoneAuthInitial,
      builder: (context, state) {
        final isLoading = state is PhoneAuthLoading;

        return AbsorbPointer(
          absorbing: isLoading,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _PhoneInputField(
                    controller: _phoneController,
                    focusNode: _phoneFocus,
                    validator: _validatePhone,
                  ),
                  const SizedBox(height: 40),
                  _SubmitButton(
                    isLoadingNotifier: ValueNotifier<bool>(isLoading),
                    isPhoneValidNotifier: _isPhoneValidNotifier,
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PhoneInputField extends StatelessWidget {
  const _PhoneInputField({
    required this.controller,
    required this.focusNode,
    required this.validator,
  });

  final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(String?) validator;

  static final _phoneMaskFormatter = MaskTextInputFormatter(
    mask: '## ### ## ##',
    filter: {'#': RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.phone,
      inputFormatters: [_phoneMaskFormatter],
      decoration: InputDecoration(
        hintText: LocaleKeys.phoneNumber.tr(),
        prefixIcon: const _PhonePrefixIcon(),
        suffixIcon: _ClearButtonWrapper(controller: controller),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      validator: validator,
    );
  }
}

class _PhonePrefixIcon extends StatelessWidget {
  const _PhonePrefixIcon();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [SizedBox(width: 16), Text('+998')],
    );
  }
}

class _ClearButtonWrapper extends StatelessWidget {
  const _ClearButtonWrapper({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        if (value.text.isEmpty) {
          return const SizedBox.shrink();
        }
        return ClearButton(onTap: controller.clear);
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    required this.isLoadingNotifier,
    required this.isPhoneValidNotifier,
    required this.onPressed,
  });

  final ValueNotifier<bool> isLoadingNotifier;
  final ValueNotifier<bool> isPhoneValidNotifier;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isPhoneValidNotifier,
      builder: (context, isPhoneValid, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: isLoadingNotifier,
          builder: (context, isLoading, child) {
            return SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: !isPhoneValid || isLoading ? null : onPressed,
                child: isLoading
                    ? const _LoadingIndicator()
                    : Text(LocaleKeys.submit.tr()),
              ),
            );
          },
        );
      },
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(strokeWidth: 2),
    );
  }
}
