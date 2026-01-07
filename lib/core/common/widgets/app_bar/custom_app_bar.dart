import 'package:iquarix/iquarx_app.dart';

AppBar customAppBar(
  BuildContext context, {
  double? elevation,
  double? leadingWidth,
  Color? backgroundColor,
  Widget? leading,
  Widget? title,
  String? titleText,
  TextStyle? titleStyle,
  bool? automaticallyImplyLeading,
  bool? centerTitle,
  List<Widget>? actions,
  PreferredSizeWidget? bottom,
}) {
  return AppBar(
    elevation: elevation ?? 0,
    backgroundColor: backgroundColor ?? Colors.white,
    leading: leading,
    automaticallyImplyLeading: automaticallyImplyLeading ?? true,
    centerTitle: centerTitle,
    leadingWidth: leadingWidth,
    surfaceTintColor: Colors.transparent,
    title:
        title ??
        Text(
          titleText ?? '',
          style:
              titleStyle ??
              const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 20,
              ),
        ),
    actions: actions,
    bottom: bottom,
  );
}
