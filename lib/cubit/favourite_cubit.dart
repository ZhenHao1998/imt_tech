import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imt_tech/cubit/favourite_state.dart';
import 'package:imt_tech/model/user.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit._({required FavouriteState state}) : super(state);

  factory FavouriteCubit.initial({FavouriteState? state}) {
    return FavouriteCubit._(state: state ?? const FavouriteInitial(favUsers: []));
  }

  void addFavUsers({required User user}) {
    emit(FavouriteLoading(favUsers: state.favUsers));

    final isSameUser = state.favUsers.where((e) => e.uuid == user.uuid).isNotEmpty;

    if (isSameUser) {
      emit(FavouriteInitial(favUsers: state.favUsers));
    }

    final users = [...state.favUsers, user];

    emit(FavouriteLoadSuccess(favUsers: users));
  }

  void removeUser({required User user}) {
    emit(FavouriteLoading(favUsers: state.favUsers));

    final users = state.favUsers..removeWhere((u) => user.uuid == u.uuid);

    emit(FavouriteLoadSuccess(favUsers: users));
  }
}
