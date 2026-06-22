import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../shared/models/product.dart';
import '../../core/services/local_storage_service.dart';

// Events
abstract class WishlistEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadWishlist extends WishlistEvent {}

class ToggleWishlist extends WishlistEvent {
  final Product product;
  ToggleWishlist(this.product);
  @override
  List<Object?> get props => [product];
}

// State
class WishlistState extends Equatable {
  final List<Product> items;
  const WishlistState({this.items = const []});

  @override
  List<Object?> get props => [items];
}

// Bloc
class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(const WishlistState()) {
    on<LoadWishlist>((event, emit) {
      final wishlistJson = LocalStorageService.getString('wishlist_items');
      if (wishlistJson != null) {
        final List<dynamic> decoded = json.decode(wishlistJson);
        final items = decoded.map((item) => Product.fromJson(item)).toList();
        emit(WishlistState(items: items));
      }
    });

    on<ToggleWishlist>((event, emit) {
      final updatedItems = List<Product>.from(state.items);
      final index = updatedItems.indexWhere((i) => i.id == event.product.id);

      if (index >= 0) {
        updatedItems.removeAt(index);
      } else {
        updatedItems.add(event.product.copyWith(isFavorite: true));
      }
      emit(WishlistState(items: updatedItems));
      _saveToPrefs(updatedItems);
    });
  }

  void _saveToPrefs(List<Product> items) {
    final wishlistJson = json.encode(items.map((i) => i.toJson()).toList());
    LocalStorageService.setString('wishlist_items', wishlistJson);
  }
}
