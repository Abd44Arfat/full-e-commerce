import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:untitled4/modules/cart_screen.dart';
import 'package:untitled4/modules/favourit_screen.dart';
import 'package:untitled4/modules/home_screen.dart';
import 'package:untitled4/modules/searchscreen.dart';
import 'package:untitled4/modules/setting_screen.dart';
import 'package:untitled4/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/cubit.dart';
import 'package:untitled4/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/status.dart';
import 'package:untitled4/shared/constance/combonants.dart';

class ShopAppLayout extends StatelessWidget {
  const ShopAppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppcubit, ShopStatus>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = ShopAppcubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 1.0,
            titleSpacing: 10,
            title: Row(
              children: const [

                Text(
                  'Salla',
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () {
                  PushToNextScreen(context, const CartScreen());
                },
                icon: const Icon(Icons.shopping_cart_outlined,
                    color: Colors.black),
              ),
              IconButton(
                onPressed: () {
                  PushToNextScreen(context, SearchScreen());
                },
                icon: const Icon(Icons.search, color: Colors.black),
              ),
            ],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            buttonBackgroundColor: Colors.white,
            height: 60.0,
            color: cubit.color!,
            backgroundColor: Colors.transparent,
            items: cubit.iconData,
            animationDuration: const Duration(milliseconds: 350),
            index: cubit.currentindex,
            onTap: (index) {
              cubit.OnChangeTabs(index);
            },
          ),
          body: cubit.Screens[cubit.currentindex],
        );
      },
    );
  }
}
