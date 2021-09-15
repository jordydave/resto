class Food {
  int? id;
  int? restaurantId;
  String? name;
  String? description;
  String? ingredients;
  int? price;
  int? rate;
  String? types;
  int? capacity;
  String? time;
  String? picturePath;

  Food({
    this.id,
    this.restaurantId,
    this.name,
    this.description,
    this.ingredients,
    this.price,
    this.rate,
    this.types,
    this.capacity,
    this.time,
    this.picturePath,
  });

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    rate = json['rate'];
    types = json['types'];
    capacity = json['capacity'];
    time = json['time'];
    picturePath = json['picturePath'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurant_id': restaurantId,
      'name': name,
      'description': description,
      'price': price,
      'rate': rate,
      'types': types,
      'capacity': capacity,
      'time': time,
      'picturePath': picturePath,
    };
  }
}
