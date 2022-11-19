import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart'
    show Cart; // interested in a specific part in this class
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
      ),
      body: Column(children: [
        Card(
          margin: EdgeInsets.all(15),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: TextStyle(fontSize: 20),
                ),
                Spacer(),
                Chip(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  label: Text(
                    "\$${cart.totalAmount.toStringAsFixed(2)}",
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
                order_btn(cart: cart)
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, i) {
            return CartItem(
              id: cart.itmes.values.toList()[i].id,
              title: cart.itmes.values.toList()[i].title,
              quantity: cart.itmes.values.toList()[i].quantity,
              price: cart.itmes.values.toList()[i].price,
              productId: cart.itmes.keys.toList()[i],
            );
          },
          itemCount: cart.itemCount,
        ))
      ]),
    );
  }
}

class order_btn extends StatefulWidget {
  const order_btn({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<order_btn> createState() => _order_btnState();
}

class _order_btnState extends State<order_btn> {
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (widget.cart.totalAmount <= 0 || isLoading)
            ? null
            : () async {
                setState(() {
                  isLoading = true;
                });
                await Provider.of<Orders>(context, listen: false).addOrder(
                  widget.cart.itmes.values.toList(),
                  widget.cart.totalAmount,
                );
                setState(() {
                  isLoading = false;
                });
                widget.cart.clear();
              },
        child: isLoading
            ? CircularProgressIndicator()
            : Text(
                "Order Now",
              ));
  }
}
