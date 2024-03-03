import 'package:equatable/equatable.dart';
import 'package:imt_tech/model/user.dart';

abstract class HomePageState extends Equatable {
  final List<User> users;

  const HomePageState({
    this.users = const [],
  });

  @override
  List<Object?> get props => [users];
}

class HomePageIntial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageLoadSuccess extends HomePageState {
  const HomePageLoadSuccess({required super.users});
}

class HomePageLoadFail extends HomePageState {
  final String errorMessage;

  const HomePageLoadFail({
    super.users,
    required this.errorMessage,
  });

  @override
  List<Object?> get props => [
        super.props,
        users,
      ];
}
