import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thriftly/model/category_model.dart';
import 'package:thriftly/model/productModel.dart';
import 'package:thriftly/repositories/category/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;
  StreamSubscription? _categorySubscription;

  CategoryBloc({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository,
        super(CategoryLoading()){
    on<LoadCategories>(_onLoadCategories);
    on<UpdateCategories>(_onUpdateCategories);

  }
  void _onLoadCategories(event ,Emitter<CategoryState> emit){
    _categorySubscription?.cancel();
    _categorySubscription = _categoryRepository.getAllcategories().listen((categories)=> add(UpdateCategories(categories))

    );
  }

  Stream<CategoryState> _mapUpdateCategoriesToState(UpdateCategories event) async* {
    yield CategoryLoaded(categories: event.categories);
  }


}
void _onUpdateCategories(event ,Emitter<CategoryState> emit){
  emit(CategoryLoaded(categories: event.categories));

}



/*
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository _categoryRepository;
  StreamSubscription? _categorySubscription;

  CategoryBloc({required CategoryRepository categoryRepository})
    : _categoryRepository = categoryRepository,
      super(CategoryLoading()){
    on<LoadCategories>(_onLoadCategories);
    on<UpdateCategories>(_onUpdateCategories);

  }
  void _onLoadCategories(event ,Emitter<CategoryState> emit){
    _categorySubscription?.cancel();
    _categorySubscription = _categoryRepository.getAllcategories().listen((categories)=> add(UpdateCategories(categories))

    );
  }

  Stream<CategoryState> _mapUpdateCategoriesToState(UpdateCategories event) async* {
    yield CategoryLoaded(categories: event.categories);
  }


  }
  void _onUpdateCategories(event ,Emitter<CategoryState> emit){
  emit(CategoryLoaded(categories: event.categories));

  }
*/
