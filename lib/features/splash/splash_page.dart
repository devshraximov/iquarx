import 'package:iquarix/iquarx_app.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SplashBloc>(
      create: (context) => sl<SplashBloc>()..add(SplashReadyEvent()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is GoToAuthState) {
            sl<AppRouter>().go(context, location: RouterKeys.qrScanner);
          } else if (state is GoToHomeState) {
            sl<AppRouter>().go(context, location: RouterKeys.qrScanner);
          }
        },
        child: Scaffold(
          body: Center(
            child: Icon(
              Icons.flutter_dash,
              size: 100,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
