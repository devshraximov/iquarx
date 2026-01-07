import 'package:iquarix/core/constants/ls_keys.dart';
import 'package:iquarix/iquarx_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSourceImpl implements LocalSource {
  final SharedPreferences _preferences;

  LocalSourceImpl(this._preferences);

  @override
  String getPhoneNum() {
    // TODO: implement getPhoneNum
    throw UnimplementedError();
  }

  @override
  Future<void> setPhoneNum({required String phone}) {
    // TODO: implement setPhoneNum
    throw UnimplementedError();
  }

  @override
  Future<void> setAccessToken({required String accessToken}) async {
    await _preferences.setString(LsKeys.accessToken, accessToken);
  }

  @override
  String getAccessToken() {
    if (_preferences.containsKey(LsKeys.accessToken)) {
      return _preferences.getString(LsKeys.accessToken) ?? '';
    } else {
      return '';
    }
  }

  @override
  Future<void> setRefreshToken({required String refreshToken}) {
    // TODO: implement setRefreshToken
    throw UnimplementedError();
  }

  @override
  String getRefreshToken() {
    // TODO: implement getRefreshToken
    throw UnimplementedError();
  }
}
