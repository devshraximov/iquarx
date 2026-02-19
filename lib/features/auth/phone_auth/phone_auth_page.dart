import 'package:easy_localization/easy_localization.dart';
import 'package:iquarix/iquarx_app.dart';

class PhoneAuthPage extends StatelessWidget {
  const PhoneAuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PhoneAuthCubit>(
      create: (context) => sl<PhoneAuthCubit>(),
      child: const Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(child: _PhoneAuthPageForm()),
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
    final normalizedPhone = _phoneController.text.replaceAll(' ', '');
    final isValid = normalizedPhone.length >= _minPhoneLength;

    if (_isPhoneValidNotifier.value != isValid) {
      _isPhoneValidNotifier.value = isValid;
    }
  }

  String _getNormalizedPhone() {
    return _phoneController.text.replaceAll(' ', '').trim();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (_phoneFocus.hasFocus) {
      _phoneFocus.unfocus();
    }

    final phone = _getNormalizedPhone();
    context.read<PhoneAuthCubit>().submitPhone('$_countryCode$phone');
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return LocaleKeys.authPhoneAuthPhoneRequired.tr();
    }

    final normalizedValue = value.replaceAll(' ', '');
    if (normalizedValue.length < _minPhoneLength) {
      return LocaleKeys.authErrorInvalidPhone.tr();
    }

    return null;
  }

  void _handlePhoneAuthSuccess(BuildContext context) {
    sl<AppRouter>().push(
      context,
      location: RouterKeys.otp,
      extra: {'phoneNum': _getNormalizedPhone()},
    );
    // Reset state to initial after navigation to prevent loading state from persisting
    context.read<PhoneAuthCubit>().completeShowError();
  }

  void _handlePhoneAuthError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
    );
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
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 80),
                  _buildPageHeader(context),
                  const SizedBox(height: 48),
                  CustomPhoneInput(
                    controller: _phoneController,
                    focusNode: _phoneFocus,
                    labelText: LocaleKeys.authPhoneAuthInputLabel.tr(),
                    hintText: LocaleKeys.authPhoneAuthInputHintText.tr(),
                    validator: _validatePhone,
                    onChanged: (_) => _onPhoneChanged(),
                  ),
                  const SizedBox(height: 32),
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

  Widget _buildPageHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.authPhoneAuthTitle.tr(),
          style: AppTextStyles.largeTitleSemiBold.copyWith(
            color: AppColors.cx1E1E1E,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          LocaleKeys.authPhoneAuthDescription.tr(),
          style: AppTextStyles.bodyRegular.copyWith(color: AppColors.cx1E1E1E),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    required this.isLoadingNotifier,
    required this.isPhoneValidNotifier,
    this.onPressed,
  });

  final ValueNotifier<bool> isLoadingNotifier;
  final ValueNotifier<bool> isPhoneValidNotifier;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isPhoneValidNotifier,
      builder: (context, isPhoneValid, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: isLoadingNotifier,
          builder: (context, isLoading, child) {
            return SizedBox(
              height: 50,
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: !isPhoneValid || isLoading ? null : onPressed,
                style: ButtonStyle(
                  elevation: const MaterialStatePropertyAll(0),
                  shape: const MaterialStatePropertyAll(StadiumBorder()),
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (isLoading) {
                      return AppColors.mainColor;
                    }
                    if (states.contains(MaterialState.disabled)) {
                      return AppColors.cxF3F4F6;
                    }
                    if (states.contains(MaterialState.pressed)) {
                      return AppColors.mainColor.withOpacity(0.85);
                    }
                    if (states.contains(MaterialState.hovered)) {
                      return AppColors.mainColor.withOpacity(0.92);
                    }
                    return AppColors.mainColor;
                  }),
                  overlayColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return AppColors.cx575757.withOpacity(0.12);
                    }
                    if (states.contains(MaterialState.hovered)) {
                      if (!isPhoneValid) {
                        return null;
                      }
                      return AppColors.cx575757.withOpacity(0.08);
                    }
                    return null;
                  }),
                ),
                child: isLoading
                    ? const _LoadingIndicator()
                    : Text(
                        LocaleKeys.authPhoneAuthSubmitButtonText.tr(),
                        style: AppTextStyles.controlInputLabel1.copyWith(
                          color: !isPhoneValid
                              ? AppColors.cx575757
                              : Colors.white,
                        ),
                      ),
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
      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
    );
  }
}
