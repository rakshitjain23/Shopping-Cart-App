import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/cart_item.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  return CartNotifier();
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  CartNotifier() : super([]);

  void addItem(CartItem item) {
    final existingIndex =
        state.indexWhere((cartItem) => cartItem.product.id == item.product.id);

    if (existingIndex >= 0) {
      final updatedItem = state[existingIndex].copyWith(
        quantity: state[existingIndex].quantity + item.quantity,
      );
      state = [
        ...state.sublist(0, existingIndex),
        updatedItem,
        ...state.sublist(existingIndex + 1),
      ];
    } else {
      state = [...state, item];
    }
  }

  void removeItem(int productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void updateQuantity(int productId, int quantity) {
    final existingIndex =
        state.indexWhere((cartItem) => cartItem.product.id == productId);

    if (existingIndex >= 0) {
      final updatedItem = state[existingIndex].copyWith(quantity: quantity);
      state = [
        ...state.sublist(0, existingIndex),
        updatedItem,
        ...state.sublist(existingIndex + 1),
      ];
    }
  }

  void clearCart() {
    state = [];
  }

  double get totalPrice {
    return state.fold(0, (sum, item) => sum + item.totalPrice);
  }
}
