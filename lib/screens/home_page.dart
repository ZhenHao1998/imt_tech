import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:imt_tech/components/avatar.dart';
import 'package:imt_tech/cubit/favourite_cubit.dart';
import 'package:imt_tech/cubit/favourite_state.dart';
import 'package:imt_tech/cubit/home_page_cubit.dart';
import 'package:imt_tech/cubit/home_page_state.dart';
import 'package:imt_tech/screens/user_detail_page.dart';
import 'package:imt_tech/utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late HomePageCubit _homePageCubit;
  late FavouriteCubit _favouriteCubit;
  late TabController tabController;

  @override
  void initState() {
    _homePageCubit = HomePageCubit.initial();
    _favouriteCubit = FavouriteCubit.initial();

    tabController = TabController(
      initialIndex: 1,
      length: 2,
      vsync: this,
    );

    _homePageCubit.getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Theme.of(context).colorScheme.inversePrimary,
        child: TabBar(controller: tabController, tabs: const [
          Tab(
            text: 'Home',
            icon: Icon(Icons.home),
          ),
          Tab(
            text: 'Favorite',
            icon: Icon(Icons.favorite),
          ),
        ]),
      ),
      body: BlocBuilder<HomePageCubit, HomePageState>(
        bloc: _homePageCubit,
        builder: (context, state) {
          final americaUsers = state.users
              .where(
                (element) => element.isAmerica,
              )
              .toList();

          final otherUsers = state.users
              .where(
                (element) => !element.isAmerica,
              )
              .toList();

          return TabBarView(
            controller: tabController,
            children: [
              Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Home',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  centerTitle: false,
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: RefreshIndicator(
                    onRefresh: () => _homePageCubit.getUser(),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (americaUsers.isNotEmpty) ...[
                            Text(
                              'From US',
                              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 100,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: americaUsers.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => UserDetailPage(
                                                args: UserDetailArgs(
                                              favCubit: _favouriteCubit,
                                              user: americaUsers[index],
                                            )),
                                          ),
                                        );
                                      },
                                      child: Avatar(user: americaUsers[index]),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                          Text(
                            'Other Countries',
                            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 100,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: otherUsers.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => UserDetailPage(
                                              args: UserDetailArgs(
                                            favCubit: _favouriteCubit,
                                            user: otherUsers[index],
                                          )),
                                        ),
                                      );
                                    },
                                    child: Avatar(
                                      user: otherUsers[index],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 500,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Scaffold(
                appBar: AppBar(
                  title: Text(
                    'Favourite',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  centerTitle: false,
                ),
                body: BlocBuilder<FavouriteCubit, FavouriteState>(
                  bloc: _favouriteCubit,
                  builder: (context, favState) {
                    final favUsers = favState.favUsers;

                    if (favUsers.isEmpty) {
                      return const Center(
                        child: Text('Your favorite list is empty'),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListView.builder(
                        itemCount: favUsers.length,
                        itemBuilder: (context, index) {
                          final favUser = favUsers[index];

                          return Dismissible(
                            key: Key(favUser.uuid),
                            onDismissed: (direction) => _favouriteCubit.removeUser(user: favUser),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => UserDetailPage(
                                        args: UserDetailArgs(
                                          user: favUser,
                                          favCubit: _favouriteCubit,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Avatar(
                                      user: favUser,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      '${favUser.title} ${generateFullName(firstname: favUser.firstname, lastname: favUser.lastname)}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
