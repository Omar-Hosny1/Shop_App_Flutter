import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    @required this.id,
    @required this.title,
    @required this.quantity,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _itmes = {};

  Map<String, CartItem> get itmes {
    return {..._itmes};
  }

  int get itemCount {
    return _itmes.length;
  }

  double get totalAmount {
    double total = 0;
    _itmes.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_itmes.containsKey(productId)) {
      _itmes.update(
        productId,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity + 1,
          price: existingCartItem.price,
        ),
      );
    } else {
      _itmes.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _itmes.remove(productId);
    notifyListeners();
  }

  void clear() {
    _itmes = {};
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_itmes.containsKey(id)) return;
    if (_itmes[id].quantity > 1) {
      _itmes.update(id, (existingCartItem) {
        return CartItem(
            id: existingCartItem.id,
            title: existingCartItem.title,
            quantity: existingCartItem.quantity - 1,
            price: existingCartItem.price);
      });
    } else {
      _itmes.remove(id);
    }
    notifyListeners();
  }
}
