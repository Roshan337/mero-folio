class AddModel {
  String? id;
  String? name;
  String? symbol;
  double? quantity;
  double? price;
  double? totalAmount;
  double? previousClosing;
  String? type;
  double? closingPrice;

  AddModel({
    this.id,
    this.name,
    this.symbol,
    this.quantity,
    this.price,
    this.totalAmount,
    this.previousClosing,
    this.type,
    this.closingPrice,
  });
  factory AddModel.fromMap(Map<String, dynamic> json) => AddModel(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        quantity: json["quantity"],
        price: json["price"],
        totalAmount: json["totalAmount"],
        previousClosing: json["previousClosing"],
        type: json["type"],
        closingPrice: json["closingPrice"],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        "name": name,
        "symbol": symbol,
        "quantity": quantity,
        "price": price,
        "totalAmount": totalAmount,
        "previousClosing": previousClosing,
        "type": type,
        "closingPrice": closingPrice,
      };
}
