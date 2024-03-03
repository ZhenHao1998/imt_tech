import 'package:equatable/equatable.dart';
import 'package:imt_tech/model/user.dart';

abstract class FavouriteState extends Equatable {
  final List<User> favUsers;

  const FavouriteState({required this.favUsers});

  @override
  List<Object?> get props => [favUsers];
}

class FavouriteInitial extends FavouriteState {
  const FavouriteInitial({required super.favUsers});
}

class FavouriteLoading extends FavouriteState {
  const FavouriteLoading({required super.favUsers});
}

class FavouriteLoadSuccess extends FavouriteState {
  const FavouriteLoadSuccess({required super.favUsers});
}
