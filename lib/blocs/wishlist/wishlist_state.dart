part of 'wishlist_bloc.dart';

abstract class WishlistState extends Equatable {
  const WishlistState();

  @override
  List<Object> get props => [];
}

class WishListLoading extends WishlistState {}

class WishListLoaded extends WishlistState {
  final Wishlist  wishlist;
  const WishListLoaded({this.wishlist = const Wishlist()});
  @override
  List<Object> get props => [wishlist];
}

class WishListError extends WishlistState {}
