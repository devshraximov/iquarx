import 'package:easy_localization/easy_localization.dart';
import 'package:iquarix/features/auth/otp/components/otp_code_input.dart';
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
        appBar: customAppBar(context, titleText: LocaleKeys.login.tr()),
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
    return BlocListener<OtpCubit, OtpState>(
      listener: (context, state) {
        state.whenOrNull(
          showErrorMessage: (msg) {
            // CustomSnackBar.error(context, message: msg);
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(msg)));
          },
          success: (request, data) {
            sl<LocalSource>().setAccessToken(
              accessToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9",
            );
            sl<AppRouter>().go(context, location: RouterKeys.home);
          },
        );
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsetsGeometry.symmetric(
            horizontal: 20,
            vertical: 24,
          ),
          child: Column(
            spacing: 14,
            children: [
              Text(
                LocaleKeys.enterCodeSendToYourNumber.tr(),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: 26,
                  letterSpacing: -0.03 * 30,
                ),
              ),

              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: Colors.grey,
                    letterSpacing: -0.01 * 17,
                  ),
                  children: [
                    TextSpan(text: "${tr("otp.sent_prefix")} "),
                    TextSpan(text: formatUzPhone(initialArgs['phoneNum'])),
                    TextSpan(text: " ${tr("otp.sent_suffix")}"),
                  ],
                ),
              ),

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
                  invalidCode: (v) {
                    if (v) {
                      return Text(
                        LocaleKeys.incorrectConfirmationCode.tr(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Colors.red,
                          letterSpacing: -0.001 * 15,
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                  orElse: () => const SizedBox.shrink(),
                ),
              ),

              BlocBuilder<TimerCubit, TimerState>(
                builder: (context, state) {
                  return state.maybeWhen(
                    timerProgress: (duration) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          "00:${duration.toString().padLeft(2, "0")}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF686876),
                            letterSpacing: -0.01 * 17,
                            fontSize: 17,
                          ),
                        ),
                      );
                    },
                    timerStop: () {
                      return TextButton(
                        onPressed: () {
                          _otpCodeController.clear();
                          context.read<OtpCubit>().resendCodeButtonPres(
                            initialArgs,
                          );
                          setState(() {});
                        },
                        child: Text(
                          LocaleKeys.resendCode.tr(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.blueAccent,
                            letterSpacing: -0.01 * 17,
                            fontSize: 17,
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
  }
}
