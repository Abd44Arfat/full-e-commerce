import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/models/get_homedata.dart';
import 'package:untitled4/shared/constance/cons.dart';

import '../shared/AppBloc/Appcubit&&ٍSearchCubit/cubit.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/status.dart';
import '../shared/constance/combonants.dart';


class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppcubit, ShopStatus>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        var cubit = ShopAppcubit.get(context);
        return cubit.categoryModel == null ? const Center(child: CircularProgressIndicator()) : ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildCategoriesItem(
                cubit.categoryModel!.data!.data[index] as Data    , context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: cubit.categoryModel!.data!.data.length);
      },
    );
  }
}
