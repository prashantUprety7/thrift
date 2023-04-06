part of 'product_bloc.dart';
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded({required this.products});

  @override
  List<Object> get props => [products];
}

class ProductError extends ProductState {
  final String errorMessage;

  ProductError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
/*
abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded({this.products = const<Product>[]});

  @override
  List<Object> get props => [products];
}

 */