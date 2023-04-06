import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thriftly/model/productModel.dart';

import '../../repositories/product/product_repository.dart';
part 'product_event.dart';
part 'product_state.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;

  ProductBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<UpdateProducts>(_onUpdateProducts);
  }

  void _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    try {
      final products = await _productRepository.getAllProducts();
      emit(ProductLoaded(products: products));
    } catch (e) {
      emit(ProductError(errorMessage: e.toString()));
    }
  }

  void _onUpdateProducts(
      UpdateProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoaded(products: event.products));
  }

  @override
  Future<void> close() {
    _productSubscription?.cancel();
    return super.close();
  }
}






/*
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;

  ProductBloc({required ProductRepository ProductRepository})
      : _productRepository = ProductRepository,
        super(ProductLoading()){
    on<LoadProducts>(_onLoadProducts);
    on<UpdateProducts>(_onUpdateProducts);

  }
  void _onLoadProducts(LoadProducts event ,Emitter<ProductState> emit){
    _productSubscription?.cancel();
    _productSubscription = _productRepository.getAllProducts().listen((products)=> add(UpdateProducts(products))

    );
  }
  Stream<ProductState> _mapUpdateProductsToState(UpdateProducts event) async* {
    yield ProductLoaded(products: event.products);
  }



}
void _onUpdateProducts(UpdateProducts event ,Emitter<ProductState> emit){
  emit(ProductLoaded(products: event.products));

}

*/