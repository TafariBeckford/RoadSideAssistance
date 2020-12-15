class Item {
  String price;
  int quantity;

  Map <String, dynamic> toJson() => {
    'price': price,
    'quantity': quantity,
  };
}