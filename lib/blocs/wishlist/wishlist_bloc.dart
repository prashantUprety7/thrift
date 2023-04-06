import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:thriftly/model/productModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thriftly/model/wishlist_model.dart';
part 'wishlist_event.dart';
part 'wishlist_state.dart';
class WishListBloc extends Bloc<WishlistEvent, WishlistState> {
  WishListBloc() : super(WishListLoading()) {
    on<LoadWishList>(_onLoadWishList);
    on<AddProductToWishList>(_onAddProductToWishList);
    on<RemoveProductFromWishList>(_onRemoveProductToWishList);
  }
  void _onLoadWishList(event, Emitter<WishlistState> emit) async {
    emit(WishListLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const WishListLoaded());
    } catch (_) {
      emit(WishListError());
    }
  }

  void _onAddProductToWishList(event, Emitter<WishlistState> emit) {
    final state = this.state;
    if (state is WishListLoaded) {
      try {
        emit(
          WishListLoaded(
              wishlist: Wishlist(
                  products: List.from(state.wishlist.products)
                    ..add(event.product))),
        );
      } on Exception {
        emit(WishListError());
      }
    }
  }

  void _onRemoveProductToWishList(event, Emitter<WishlistState> emit) {
    final state = this.state;
    if (state is WishListLoaded) {
      try {
        emit(WishListLoaded(
            wishlist: Wishlist(
                products: List.from(state.wishlist.products)
                  ..remove(event.product))));
      } on Exception {
        emit(WishListError());
      }
    }
  }
  bool isInWishlist(Product product, WishlistState state) {
    if (state is WishListLoaded) {
      return state.wishlist.products.contains(product);
    }
    return false;
  }
}
/*

  
*/
