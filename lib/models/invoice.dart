class Invoice {
  String customer;
  String address;
  String name;
  List<LineItem> items;
  String phone; 
  Invoice({
    required this.customer,
    required this.address,
    required this.items,
    required this.name,
    required this.phone,
  });
  List<LineItem> get_items(){
    return this.items;
  }
  set_items(List<LineItem> items){
    this.items=items;
  }
  double totalCost() {
    return items.fold(0, (previousValue, element) => previousValue + element.cost);
  }
}

class LineItem {
  final String description;
  final double cost;

  LineItem(this.description, this.cost);
}
