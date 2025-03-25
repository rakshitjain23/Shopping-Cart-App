import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/product.dart';
import '../../../core/services/product_service.dart';

final productServiceProvider = Provider<ProductService>((ref) {
  return ProductService();
});

final productsProvider =
    StateNotifierProvider<ProductsNotifier, AsyncValue<Map<String, dynamic>>>(
        (ref) {
  final productService = ref.watch(productServiceProvider);
  return ProductsNotifier(productService);
});

class ProductsNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final ProductService _productService;
  int _currentPage = 1;
  static const int _limit = 10;
  bool _isLoading = false;

  ProductsNotifier(this._productService) : super(const AsyncValue.loading()) {
    loadProducts();
  }

  Future<void> loadProducts({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      state = const AsyncValue.loading();
    }

    if (_isLoading) return;
    _isLoading = true;

    try {
      final result = await _productService.getProducts(
        page: _currentPage,
        limit: _limit,
      );

      if (result['products'] != null) {
        state = AsyncValue.data(result);
      } else {
        state = AsyncValue.error('Failed to load products', StackTrace.current);
      }
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    } finally {
      _isLoading = false;
    }
  }

  Future<void> loadNextPage() async {
    if (_isLoading || state.value == null) return;

    final currentProducts = state.value!['products'] as List<Product>;
    final total = state.value!['total'] as int;

    if (currentProducts.length >= total) return;

    _currentPage++;
    _isLoading = true;

    try {
      final result = await _productService.getProducts(
        page: _currentPage,
        limit: _limit,
      );

      if (result['products'] != null) {
        final newProducts = result['products'] as List<Product>;

        state = AsyncValue.data({
          'products': [...currentProducts, ...newProducts],
          'total': result['total'] as int,
        });
      }
    } catch (error, stackTrace) {
      // Revert page number on error
      _currentPage--;
      state = AsyncValue.error(error, stackTrace);
    } finally {
      _isLoading = false;
    }
  }
}
