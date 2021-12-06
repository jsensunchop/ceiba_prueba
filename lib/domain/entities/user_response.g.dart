// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      json['name'] as String,
      json['username'] as String,
      json['email'] as String,
      json['phone'] as String,
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'phone': instance.phone,
    };

Address _$AddressFromJson(Map<String, dynamic> json) => Address(
      json['street'] as String,
      json['suite'] as String,
      json['city'] as String,
      json['zipcode'] as String,
      Geo.fromJson(json['geo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'street': instance.street,
      'suite': instance.suite,
      'city': instance.city,
      'zipcode': instance.zipcode,
      'geo': instance.geo.toJson(),
    };

Geo _$GeoFromJson(Map<String, dynamic> json) => Geo(
      json['lat'] as String,
      json['lng'] as String,
    );

Map<String, dynamic> _$GeoToJson(Geo instance) => <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
    };

Company _$CompanyFromJson(Map<String, dynamic> json) => Company(
      json['name'] as String,
      json['catchPhrase'] as String,
      json['bs'] as String,
    );

Map<String, dynamic> _$CompanyToJson(Company instance) => <String, dynamic>{
      'name': instance.name,
      'catchPhrase': instance.catchPhrase,
      'bs': instance.bs,
    };
