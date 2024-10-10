import 'package:curved_navigation_bar_with_label/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled6/shared/business_logic/cubit/cubit.dart';
import 'package:untitled6/shared/business_logic/Provider/theme_provider.dart';
import 'package:flutter_offline/flutter_offline.dart';

import '../shared/business_logic/cubit/state.dart';
import '../shared/network/connection.dart';

class HomeLayout extends StatefulWidget {
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  List<String> titles = [
    'Dashboard',
    'AI',
    'Controls',
    'Report',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    final themeProvider =
    Provider.of<ThemeProvider>(context); // toggle provider

    return Scaffold(
      body: Builder(
        builder: (BuildContext context) {
          return OfflineBuilder(
            connectivityBuilder: (
                BuildContext connectivityContext,
                ConnectivityResult connectivity,
                Widget child,
                ) {
              if (connectivity == ConnectivityResult.none) {
                // لا يوجد اتصال بالإنترنت
                return ConnectionScreen();
              } else {
                return child;
              }
            },
            child: BlocProvider(
              create: (context) =>
                  GreenCubit(Provider.of<ThemeProvider>(context, listen: false)),
              child: BlocConsumer<GreenCubit, GreenStates>(
                listener: (context, state) {},
                builder: (context, state) {
                  var cubit = GreenCubit.get(context);
                  return Scaffold(
                    appBar: AppBar(
                      forceMaterialTransparency: true,
                      iconTheme: Theme.of(context).iconTheme, /// toggle provider
                      automaticallyImplyLeading: false,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            titles[cubit.currentIndex],
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24.0,
                                letterSpacing: 1.0),
                          ),
                          // if (cubit.currentIndex == 0)
                          //   Container(
                          //     margin: EdgeInsets.only(left: width * 0.1),
                          //     child: IconButton(
                          //       icon: Icon(
                          //         Icons.notifications,
                          //         size: 30.0,
                          //       ),
                          //       onPressed: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) =>
                          //                 NotificationsPage(),
                          //           ),
                          //         );
                          //       },
                          //     ),
                          //   ),
                          if (cubit.currentIndex == 4)
                            Container(
                              margin: EdgeInsets.only(left: width * 0.1),
                              child: IconButton(
                                icon: themeProvider.isDarkMode
                                    ? Icon(
                                  Icons.lightbulb_outline_sharp,
                                  size: 30.0,
                                )
                                    : Icon(
                                  Icons.nightlight_outlined,
                                  size: 30.0,
                                ),
                                onPressed: () {
                                  final provider = Provider.of<ThemeProvider>(
                                      context,
                                      listen: false);
                                  provider.toggleTheme(
                                      !themeProvider.isDarkMode);
                                },
                              ),
                            ),
                        ],
                      ),
                      backgroundColor: Theme.of(context)
                          .appBarTheme
                          .backgroundColor,
                      elevation: 0.0,
                    ),
                    body: cubit.screens[cubit.currentIndex],
                    bottomNavigationBar: CurvedNavigationBar(
                      height: height * 0.08,
                      backgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                      buttonBackgroundColor: Colors.teal.shade300,
                      buttonLabelColor: Colors.teal.shade300,
                      index: cubit.currentIndex,
                      onTap: (index) {
                        cubit.changeBottomNavBar(index);
                      },
                      items: cubit.bottomItems(context),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
