import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:thriftly/product_Api/productmodel.dart';
import 'package:thriftly/product_Api/productrepo.dart';

import '../../repositories/product/product_repository.dart';


part 'product_state.dart';
part 'product_event.dart';

abstract class ProductEvent {}

class LoadProductsApi extends ProductEvent {}

abstract class ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductApi> products;

  ProductLoaded({required this.products});
}

class ProductError extends ProductState {
  final String errorMessage;

  ProductError({required this.errorMessage});
}

class ProductBlocApi extends Bloc<ProductEvent, ProductState> {
  final ProductRepositoryApi productRepositoryapi;

  ProductBlocApi({required this.productRepositoryapi}) : super(ProductLoading());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is LoadProductsApi) {
      emit(ProductLoading());
      try {
        final products = await productRepositoryapi.getAllProducts().toList().then((list) => list.expand((i) => i).toList());
        emit(ProductLoaded(products: products));
      } catch (e) {
        emit(ProductError(errorMessage: e.toString()));
      }
    }
  }
}

/*

class ProductApiBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository _productRepository;
  StreamSubscription? _productSubscription;

  ProductApiBloc({required ProductRepository productRepository})
      : _productRepository = productRepository,
        super(ProductLoading());

  @override
  Stream<ProductState> mapEventToState(ProductEvent event) async* {
    if (event is LoadProductsAll) {
      yield* _mapLoadProductsToState();
    } else if (event is UpdateProducts) {
      yield ProductLoaded(products: event.products);
    }
  }

  Stream<ProductState> _mapLoadProductsToState() async* {
    try {
      final products = await _productRepository.getAllProducts();
      yield ProductLoaded(products: products);
    } catch (e) {
      yield ProductError(errorMessage: "Failed to load products");
    }
  }

  @override
  Future<void> close() {
    _productSubscription?.cancel();
    return super.close();
  }
}

 */