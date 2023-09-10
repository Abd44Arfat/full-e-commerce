import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/modules/login_screen.dart';
import 'package:untitled4/modules/on_bording_screen.dart';
import 'package:untitled4/shared/AppBloc/shoplogin_bloc/blocobservar.dart';


import 'layout/shop_app_layout.dart';
import 'shared/AppBloc/Appcubit&&ٍSearchCubit/cubit.dart';
import 'shared/AppBloc/register.screen/cubit.dart';
import 'shared/AppBloc/shoplogin_bloc/cubit.dart';
import 'shared/constance/cons.dart';
import 'shared/remote/dio.helper.dart';
import 'shared/remote/catch.helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Diohelper.init();
  await cachHelper.init();
  dynamic onBoardingFinish = false;
  onBoardingFinish = cachHelper.getData('ShowOnBoard');
  token = cachHelper.getData('token');
  print(token);
  late Widget start;
  if (onBoardingFinish != null) {
    if (token == null) {
      start = ShopLoginScreen();
    } else {
      start =  ShopAppLayout();
    }
  } else {
    start = OnBording_Screen();
  }

  runApp(MyApp(start));
}
// BlocOverrides.runZoned(
// () {
// // Use cubits...
// },
// blocObserver: MyBlocObserver(),
// );

class MyApp extends StatelessWidget {
  Widget startApp;

  MyApp(this.startApp);

  // his widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShopAppLogincubit()),
        BlocProvider(
            create: (context) => ShopAppcubit()
              ..gethomedata()
              ..getAddresses()
              ..GetCategoryModel()
              ..getOrders()),
        BlocProvider(create: (context) => ShopAppRegistercubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(
        fontFamily: 'Raleway',

          scaffoldBackgroundColor: Colors.white,
        ),
        debugShowCheckedModeBanner: false,
        home: startApp,
      ),
    );
  }
}
