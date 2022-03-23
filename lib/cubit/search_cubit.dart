import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/constants/constant.dart';
import 'package:shop_app1/cubit/search_states.dart';
import 'package:shop_app1/dio/dio_helper.dart';
import 'package:shop_app1/models/search_model.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);
  SearchModel? searchModel;
  void search(text) {
    emit(SearchLoadingState());
    DioHelper.sendData(
            url: 'products/search',
            data: {
              'text': text,
            },
            token: token)
        .then((value) {
      emit(SearchSuccessState());
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel);
      print(value);
    }).catchError((error) {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}
