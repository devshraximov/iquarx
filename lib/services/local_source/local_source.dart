abstract class LocalSource {
  Future<void> setPhoneNum({required String phone});

  String getPhoneNum();

  Future<void> setAccessToken({required String accessToken});

  String getAccessToken();

  Future<void> setRefreshToken({required String refreshToken});

  String getRefreshToken();
}
