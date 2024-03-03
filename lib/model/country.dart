import 'package:equatable/equatable.dart';

class Country extends Equatable {
  final String name;
  final String stateName;

  const Country({
    required this.name,
    required this.stateName,
  });

  factory Country.fromJson(Map<String, dynamic> data) {
    return Country(name: data['country'], stateName: data['state']);
  }

  @override
  List<Object?> get props => [
        name,
        stateName,
      ];
}
