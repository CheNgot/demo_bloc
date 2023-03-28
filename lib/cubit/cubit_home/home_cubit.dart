import 'dart:math';

import 'package:bloc_login_form/bloc/bloc_home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading());
  List<String> _list=[];
  void fetchList() async {
    try {
      // Perform some asynchronous action to fetch the list items
      final items = await _fetchItems();
      _list=items;
      emit(HomeLoaded(items: _list));
    } catch (error) {
      emit(HomeFailure(error: error.toString()));
    }
  }

  Future<List<String>> _fetchItems() async {
    int random= Random().nextInt(20)+10;
    print("random==$random");
    await Future.delayed(Duration(seconds: 3));
    return _generateList(random);
  }
  void loadMore() async {
    try {
      // Perform some asynchronous action to fetch the list items
      final items = await _fetchItems();
      _list.addAll(items);
      emit(HomeLoaded(items: _list));
    } catch (error) {
      emit(HomeFailure(error: error.toString()));
    }
  }

  List<String> _generateList(int random) {
    List<String> temp=[];
    for(int i=0;i<random;i++){
      temp.add("item: $i");
    }
    return temp;
  }

  void addItem() {
    List<String> temp=_list;
    temp.insert(0,"item new");
    _list=temp;
    emit(HomeLoaded(items: _list));
  }

  void deleteItem(int index) {
    List<String> temp=_list;
    temp.removeAt(index);
    _list=temp;
    emit(HomeLoaded(items: _list));
  }

  void editItem({required String content, required int index}) {
    List<String> temp=_list;
    temp[index]=content;
    _list=temp;
    emit(HomeLoaded(items: _list));
  }



}
