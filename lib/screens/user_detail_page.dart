import 'package:flutter/material.dart';
import 'package:imt_tech/components/detail_tile.dart';
import 'package:imt_tech/cubit/favourite_cubit.dart';
import 'package:imt_tech/model/user.dart';

class UserDetailArgs {
  final User user;
  final FavouriteCubit favCubit;

  UserDetailArgs({
    required this.user,
    required this.favCubit,
  });
}

class UserDetailPage extends StatefulWidget {
  final UserDetailArgs args;

  const UserDetailPage({
    super.key,
    required this.args,
  });

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late User _user;
  late FavouriteCubit _favouriteCubit;
  late bool _isFav;

  @override
  void initState() {
    final args = widget.args;
    _user = args.user;
    _favouriteCubit = args.favCubit;
    _isFav = _favouriteCubit.state.favUsers.contains(_user);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Profile Detail',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          _user.image,
                          scale: 20,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 85,
                      top: 60,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.white,
                        child: GestureDetector(
                          onTap: () {
                            if (_isFav) {
                              _favouriteCubit.removeUser(user: _user);

                              setState(() {
                                _isFav = false;
                              });

                              return;
                            }
                            _favouriteCubit.addFavUsers(user: _user);

                            setState(() {
                              _isFav = true;
                            });
                          },
                          child: CircleAvatar(
                            radius: 13,
                            backgroundColor: _isFav ? Colors.yellow : Colors.grey,
                            child: Center(
                              child: Icon(
                                Icons.favorite_border,
                                size: 14,
                                color: _isFav ? Colors.red : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Text('${_user.title} ${_user.firstname} ${_user.lastname}'),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Divider(
                  thickness: 1,
                ),
              ),
              DetailTile(
                title: 'Email',
                detail: _user.email,
              ),
              DetailTile(
                title: 'State',
                detail: _user.country.stateName,
              ),
              DetailTile(
                title: 'Country',
                detail: _user.country.name,
              ),
              DetailTile(
                title: 'Gender',
                detail: _user.isMale ? 'Male' : 'Female',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
