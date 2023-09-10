import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/models/search_model.dart';
import 'package:untitled4/network/end_points/end_points.dart';
import 'package:untitled4/shared/AppBloc/Appcubit&&%D9%8DSearchCubit/status.dart';
import 'package:untitled4/shared/constance/cons.dart';
import 'package:untitled4/shared/remote/dio.helper.dart';



class SearchCubit extends Cubit<SearchStatus> {
  SearchCubit() : super(ShopSearchInitialStatus());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void getSearchData(String searchText) {
    emit(ShopLodingSearchStatus());
    Diohelper.PostData(url: productssearch, Token: token, data: {
      'text': '$searchText',
    }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print('Search ' + searchModel!.status.toString());
      emit(ShopSuccessSearchStatus(searchModel!));
    }).catchError((error) {
      emit(ShopErrorSearchStatus());
      print(error.toString());
    });
  }
}
