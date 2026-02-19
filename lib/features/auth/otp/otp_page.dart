import 'package:easy_localization/easy_localization.dart';
import 'package:iquarix/iquarx_app.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key, this.arguments});

  final DataMap? arguments;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TimerCubit>(create: (context) => sl<TimerCubit>()),
        BlocProvider<OtpCubit>(create: (context) => sl<OtpCubit>()),
      ],
      child: Scaffold(
        appBar: customAppBar(context, titleText: ""),
        body: _OtpPageForm(arguments: arguments),
      ),
    );
  }
}

class _OtpPageForm extends StatefulWidget {
  const _OtpPageForm({super.key, this.arguments});

  final DataMap? arguments;

  @override
  State<_OtpPageForm> createState() => _OtpPageFormState();
}

class _OtpPageFormState extends State<_OtpPageForm> {
  final _otpCodeController = TextEditingController();
  final _otpCodeFocus = FocusNode();
  late DataMap initialArgs;

  @override
  void initState() {
    super.initState();
    initialArgs = widget.arguments ?? {};
    context.read<TimerCubit>().onStartTimer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OtpCubit, OtpState>(
      listener: (context, state) {
        state.whenOrNull(
          showErrorMessage: (failure) {
            if (failure.label != 'invalid_code') {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(failure.message)));
            }
          },
          success: (request, data) {
            sl<LocalSource>().setAccessToken(
              accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9",
            );
            sl<AppRouter>().go(context, location: RouterKeys.home);
          },
          restartTimer: () {
            // Restart timer when resend is complete
            context.read<TimerCubit>().onStartTimer();
            // Auto focus OTP input after resend
            Future.delayed(const Duration(milliseconds: 100), () {
              if (mounted && !_otpCodeFocus.hasFocus) {
                _otpCodeFocus.requestFocus();
              }
            });
          },
        );
      },
      builder: (context, otpState) {
        final isResendLoading = otpState.maybeWhen(
          resendLoading: () => true,
          orElse: () => false,
        );

        return AbsorbPointer(
          absorbing: isResendLoading,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsetsGeometry.symmetric(
                horizontal: 20,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.authOtpTitle.tr(),
                    style: AppTextStyles.largeTitleSemiBold.copyWith(
                      color: AppColors.cx1E1E1E,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    LocaleKeys.authOtpDescription.tr(),
                    style: AppTextStyles.bodyRegular.copyWith(
                      color: AppColors.cx1E1E1E,
                    ),
                  ),
                  const SizedBox(height: 20),
                  BlocBuilder<OtpCubit, OtpState>(
                    builder: (context, state) {
                      return OtpCodeInput(
                        controller: _otpCodeController,
                        focusNode: _otpCodeFocus,
                        hasError: state.maybeWhen(
                          invalidCode: (v) => v,
                          orElse: () => false,
                        ),
                        onChanged: (v) {
                          context.read<OtpCubit>().otpCodeChanged(v);
                        },
                        onCompleted: (code) {
                          context.read<OtpCubit>().confirmCodeButtonPres(
                            initialArgs,
                            code,
                          );
                        },
                      );
                    },
                  ),

                  BlocBuilder<OtpCubit, OtpState>(
                    builder: (context, state) => state.maybeWhen(
                      showErrorMessage: (v) {
                        if (v.label == 'invalid_code') {
                          return Padding(
                            padding: const EdgeInsetsGeometry.only(
                              top: 16,
                              left: 50,
                              right: 50,
                            ),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                LocaleKeys.authErrorOtpCodeError.tr(),
                                textAlign: TextAlign.center,
                                style: AppTextStyles.bodyRegular.copyWith(
                                  color: AppColors.cxC11302,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                      orElse: () => const SizedBox.shrink(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Show loading indicator when resending or timer progress
                  if (isResendLoading)
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.mainColor,
                          ),
                        ),
                      ),
                    )
                  else
                    BlocBuilder<TimerCubit, TimerState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          timerProgress: (duration) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "00:${duration.toString().padLeft(2, "0")}",
                                  style: AppTextStyles.bodyRegular.copyWith(
                                    color: AppColors.mainColor,
                                  ),
                                ),
                              ),
                            );
                          },
                          timerStop: () {
                            return Align(
                              alignment: Alignment.center,
                              child: TextButton(
                                onPressed: () {
                                  _otpCodeController.clear();
                                  if (_otpCodeFocus.hasFocus) {
                                    _otpCodeFocus.unfocus();
                                  }
                                  context.read<OtpCubit>().resendCodeButtonPres(
                                    initialArgs,
                                  );
                                },
                                child: Text(
                                  LocaleKeys.authOtpResendCode.tr(),
                                  style: AppTextStyles.bodyRegular.copyWith(
                                    color: AppColors.cx575757,
                                    height: 1,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            );
                          },
                          orElse: () => const SizedBox.shrink(),
                        );
                      },
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
