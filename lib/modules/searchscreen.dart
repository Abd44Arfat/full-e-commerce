import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



import '../models/search_model.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/searchcubit.dart';
import '../shared/AppBloc/Appcubit&&ٍSearchCubit/status.dart';
import '../shared/constance/combonants.dart';
import '../shared/constance/cons.dart';
import 'home_product_data_screean.dart';

class SearchScreen extends StatelessWidget {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStatus>(
        listener: (context, state) {},
        builder: (context, state) {
          SearchCubit cubit = SearchCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                toolbarHeight: 60,
                title: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Row(
                    children: [
                      Container(
                        height: 35,
                        width: 250,
                        child: TextFormField(
                          style: Theme.of(context).textTheme.bodyText1,
                          controller: searchController,
                          textCapitalization: TextCapitalization.words,
                          keyboardType: TextInputType.text,
                          autofocus: true,
                          decoration: const InputDecoration(
                            hintText: 'What are you looking for ?',
                            hintStyle: TextStyle(fontSize: 15),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.red,
                            ),
                          ),
                          onChanged: (value) {
                            cubit.getSearchData(value);
                          },
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'cancel',
                            style: TextStyle(color: Colors.black),
                          )),
                    ],
                  ),
                ),
              ),
              body: state is ShopLodingSearchStatus
                  ? const Center(child: CircularProgressIndicator())
                  : cubit.searchModel != null
                      ? searchController.text.isEmpty
                          ? Container()
                          : ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) =>
                                  searchItemBuilder(
                                      cubit.searchModel?.data.data[index],
                                      context),
                              separatorBuilder: (context, index) => myDivider(),
                              itemCount:
                                  cubit.searchModel?.data.data.length ?? 10,
                            )
                      : Container());
        },
      ),
    );
  }

  Widget searchItemBuilder(SearchProduct? model, context) {
    return InkWell(
      onTap: () {
        PushToNextScreen(context, ProductDetails(model!.id));
      },
      child: Container(
        height: 120,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model!.image}'),
              width: 100,
              height: 100,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    'EGP ' + '${model.price}',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
