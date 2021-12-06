import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

///PODO ApiResponse

@JsonSerializable()
class UserResponse {
  final int id;
  final String name;
  final String username;
  final String email;
  // final Address address;
  final String phone;
  // final String website;
  // final Company company;

  UserResponse(this.id, this.name, this.username, this.email, this.phone);

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Address {
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final Geo geo;

  Address(this.street, this.suite, this.city, this.zipcode, this.geo);

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Geo {

  final String lat;
  final String lng;

  Geo(this.lat,this.lng);

  factory Geo.fromJson(Map<String, dynamic> json) =>
      _$GeoFromJson(json);

  Map<String, dynamic> toJson() => _$GeoToJson(this);
}


@JsonSerializable(explicitToJson: true)
class Company {

  final String name;
  final String catchPhrase;
  final String bs;

  Company(this.name, this.catchPhrase,this.bs);

  factory Company.fromJson(Map<String, dynamic> json) =>
      _$CompanyFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyToJson(this);
}

