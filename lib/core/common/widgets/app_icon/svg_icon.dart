import 'package:flutter_svg/flutter_svg.dart';
import 'package:iquarix/iquarx_app.dart';

enum AppIcon {
  phoneIcon('phone_icon.svg'),
  search('search.svg');

  const AppIcon(this.fileName);

  final String fileName;

  String get path => 'assets/svg/$fileName';
}

class SvgIcon extends StatelessWidget {
  const SvgIcon({super.key, required this.icon, this.size = 24, this.color});

  final AppIcon icon;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon.path,
      width: size,
      height: size,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
    );
  }
}
