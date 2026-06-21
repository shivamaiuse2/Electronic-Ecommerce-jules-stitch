import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../shared/models/cart_item.dart';
import '../../shared/models/product.dart';
import '../../core/services/local_storage_service.dart';

// Events
abstract class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final Product product;
  AddToCart(this.product);
  @override
  List<Object?> get props => [product];
}

class RemoveFromCart extends CartEvent {
  final String productId;
  RemoveFromCart(this.productId);
  @override
  List<Object?> get props => [productId];
}

class UpdateQuantity extends CartEvent {
  final String productId;
  final int quantity;
  UpdateQuantity(this.productId, this.quantity);
  @override
  List<Object?> get props => [productId, quantity];
}

class ClearCart extends CartEvent {}

// State
class CartState extends Equatable {
  final List<CartItem> items;
  const CartState({this.items = const []});

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  double get shipping => items.isEmpty ? 0 : 15.0;
  double get tax => subtotal * 0.08;
  double get total => subtotal + shipping + tax;

  @override
  List<Object?> get props => [items];
}

// Bloc
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<LoadCart>((event, emit) {
      final cartJson = LocalStorageService.getString('cart_items');
      if (cartJson != null) {
        final List<dynamic> decoded = json.decode(cartJson);
        final items = decoded.map((item) => CartItem.fromJson(item)).toList();
        emit(CartState(items: items));
      }
    });

    on<AddToCart>((event, emit) {
      final updatedItems = List<CartItem>.from(state.items);
      final index = updatedItems.indexWhere((i) => i.product.id == event.product.id);

      if (index >= 0) {
        updatedItems[index] = updatedItems[index].copyWith(quantity: updatedItems[index].quantity + 1);
      } else {
        updatedItems.add(CartItem(product: event.product, quantity: 1));
      }
      emit(CartState(items: updatedItems));
      _saveToPrefs(updatedItems);
    });

    on<RemoveFromCart>((event, emit) {
      final updatedItems = state.items.where((i) => i.product.id != event.productId).toList();
      emit(CartState(items: updatedItems));
      _saveToPrefs(updatedItems);
    });

    on<UpdateQuantity>((event, emit) {
      final updatedItems = state.items.map((i) {
        if (i.product.id == event.productId) {
          return i.copyWith(quantity: event.quantity);
        }
        return i;
      }).toList();
      emit(CartState(items: updatedItems));
      _saveToPrefs(updatedItems);
    });

    on<ClearCart>((event, emit) {
      emit(const CartState(items: []));
      LocalStorageService.remove('cart_items');
    });
  }

  void _saveToPrefs(List<CartItem> items) {
    final cartJson = json.encode(items.map((i) => i.toJson()).toList());
    LocalStorageService.setString('cart_items', cartJson);
  }
}
