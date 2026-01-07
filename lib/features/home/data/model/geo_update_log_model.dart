import 'dart:convert';

/// eventId : "550e8400-e29b-41d4-a716-446655440000"
/// companyId : "company-123"
/// entityId : "vehicle-456"
/// type : "GEOUPDATE"
/// source : "mobile"
/// payload : {"geo":{"lat":41.195451,"lng":69.203534,"accuracy":10}}
/// occurredAt : "2025-01-15T10:30:00Z"

GeoUpdateLogModel geoUpdateLogModelFromJson(String str) =>
    GeoUpdateLogModel.fromJson(json.decode(str));

String geoUpdateLogModelToJson(GeoUpdateLogModel data) =>
    json.encode(data.toJson());

class GeoUpdateLogModel {
  GeoUpdateLogModel({
    this.eventId,
    this.companyId,
    this.entityId,
    this.type,
    this.source,
    this.payload,
    this.occurredAt,
  });

  GeoUpdateLogModel.fromJson(dynamic json) {
    eventId = json['eventId'];
    companyId = json['companyId'];
    entityId = json['entityId'];
    type = json['type'];
    source = json['source'];
    payload = json['payload'] != null
        ? PayloadModel.fromJson(json['payload'])
        : null;
    occurredAt = json['occurredAt'];
  }

  String? eventId;
  String? companyId;
  String? entityId;
  String? type;
  String? source;
  PayloadModel? payload;
  String? occurredAt;

  GeoUpdateLogModel copyWith({
    String? eventId,
    String? companyId,
    String? entityId,
    String? type,
    String? source,
    PayloadModel? payload,
    String? occurredAt,
  }) => GeoUpdateLogModel(
    eventId: eventId ?? this.eventId,
    companyId: companyId ?? this.companyId,
    entityId: entityId ?? this.entityId,
    type: type ?? this.type,
    source: source ?? this.source,
    payload: payload ?? this.payload,
    occurredAt: occurredAt ?? this.occurredAt,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['eventId'] = eventId;
    map['companyId'] = companyId;
    map['entityId'] = entityId;
    map['type'] = type;
    map['source'] = source;
    if (payload != null) {
      map['payload'] = payload?.toJson();
    }
    map['occurredAt'] = occurredAt;
    return map;
  }
}

/// geo : {"lat":41.195451,"lng":69.203534,"accuracy":10}

PayloadModel payloadModelFromJson(String str) =>
    PayloadModel.fromJson(json.decode(str));

String payloadModelToJson(PayloadModel data) => json.encode(data.toJson());

class PayloadModel {
  PayloadModel({this.geo});

  PayloadModel.fromJson(dynamic json) {
    geo = json['geo'] != null ? GeoModel.fromJson(json['geo']) : null;
  }

  GeoModel? geo;

  PayloadModel copyWith({GeoModel? geo}) => PayloadModel(geo: geo ?? this.geo);

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (geo != null) {
      map['geo'] = geo?.toJson();
    }
    return map;
  }
}

/// lat : 41.195451
/// lng : 69.203534
/// accuracy : 10

GeoModel geoModelFromJson(String str) => GeoModel.fromJson(json.decode(str));

String geoModelToJson(GeoModel data) => json.encode(data.toJson());

class GeoModel {
  GeoModel({this.lat, this.lng, this.accuracy});

  GeoModel.fromJson(dynamic json) {
    lat = json['lat'];
    lng = json['lng'];
    accuracy = json['accuracy'];
  }

  num? lat;
  num? lng;
  num? accuracy;

  GeoModel copyWith({num? lat, num? lng, num? accuracy}) => GeoModel(
    lat: lat ?? this.lat,
    lng: lng ?? this.lng,
    accuracy: accuracy ?? this.accuracy,
  );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lng'] = lng;
    map['accuracy'] = accuracy;
    return map;
  }
}
