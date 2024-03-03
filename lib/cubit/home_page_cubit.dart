import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:imt_tech/cubit/home_page_state.dart';
import 'package:imt_tech/model/user.dart';
import 'package:imt_tech/services/user_service.dart';

class HomePageCubit extends Cubit<HomePageState> {
  final userService = GetIt.I<UserService>();
  HomePageCubit._({HomePageState? state})
      : super(
          state ?? HomePageIntial(),
        );

  factory HomePageCubit.initial({HomePageState? state}) {
    return HomePageCubit._(state: state ?? HomePageIntial());
  }

  Future<void> getUser() async {
    emit(HomePageLoading());

    final response = await userService.getUserList().catchError(
          (ex) => {'error': 'Something went wrong'},
        );

    if (response['error'] != null) {
      emit(
        HomePageLoadFail(
          errorMessage: response['error'],
        ),
      );
    }

    final users = (response['results'] as List).map<User>((val) => User.fromJson(val)).toList();

    emit(HomePageLoadSuccess(users: users));
  }
}
