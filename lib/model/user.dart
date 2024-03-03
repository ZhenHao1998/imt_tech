import 'package:equatable/equatable.dart';
import 'package:imt_tech/model/country.dart';

class User extends Equatable {
  final String uuid;
  final String firstname;
  final String lastname;
  final String title;
  final String email;
  final String image;
  final Country country;
  final bool isAmerica;
  final bool isMale;

  const User({
    required this.uuid,
    required this.firstname,
    required this.lastname,
    required this.title,
    required this.email,
    required this.image,
    required this.country,
    required this.isAmerica,
    required this.isMale,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      uuid: data['login']['uuid'],
      firstname: data['name']['first'],
      lastname: data['name']['last'],
      title: data['name']['title'],
      email: data['email'],
      image: data['picture']['medium'],
      country: Country.fromJson(data['location']),
      isAmerica: data['nat'] == 'US',
      isMale: data['gender'] == 'male',
    );
  }

  @override
  List<Object?> get props => [
        uuid,
        firstname,
        lastname,
        title,
        email,
        image,
        country,
        isAmerica,
        isMale,
      ];
}
