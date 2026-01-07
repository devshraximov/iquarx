class PhoneAuthRequestModel {
  final String phone;
  final String deviceId;
  final String deviceName;

  PhoneAuthRequestModel({
    required this.phone,
    required this.deviceId,
    required this.deviceName,
  });

  Map<String, dynamic> toJson() => {
    'phone': phone,
    'deviceId': deviceId,
    'deviceName': deviceName,
  };
}
