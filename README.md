# Shopping Cart App

A Flutter application that demonstrates a shopping cart interface with product listing and cart management functionality.

## Features

- Display a list of products with their prices and discounts
- Add products to cart
- View cart items with quantity management
- Calculate total price with discounts
- Infinite scrolling pagination
- Pull-to-refresh functionality
- Modern and responsive UI

## Technical Details

- Built with Flutter
- Uses Riverpod for state management
- Implements clean architecture principles
- Follows Material Design guidelines
- Uses the DummyJSON API for product data

## Project Structure

```
lib/
├── core/
│   ├── models/
│   │   ├── product.dart
│   │   └── cart_item.dart
│   ├── services/
│   │   └── product_service.dart
│   └── widgets/
│       ├── product_card.dart
│       └── cart_item_widget.dart
├── features/
│   ├── products/
│   │   ├── providers/
│   │   │   └── product_provider.dart
│   │   └── screens/
│   │       └── products_screen.dart
│   └── cart/
│       ├── providers/
│       │   └── cart_provider.dart
│       └── screens/
│           └── cart_screen.dart
└── main.dart
```

## Getting Started

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Dependencies

- flutter_riverpod: ^2.4.9
- http: ^1.1.0
- cached_network_image: ^3.3.0
- google_fonts: ^6.1.0
- flutter_svg: ^2.0.9
- intl: ^0.19.0

## API Reference

This app uses the [DummyJSON](https://dummyjson.com/) API for product data.

## Contributing

Feel free to submit issues and enhancement requests!
