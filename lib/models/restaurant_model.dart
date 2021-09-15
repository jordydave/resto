import 'package:submission_2_restaurant_dicoding/models/food_model.dart';
import 'package:submission_2_restaurant_dicoding/models/time_model.dart';

class Restaurant {
  int? id;
  String? name;
  String? description;
  int? capacity;
  String? address;
  String? phoneNumber;
  String? city;
  String? picturePath;
  late List<Food> foods;
  late List<Time> times;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.capacity,
    this.address,
    this.phoneNumber,
    this.city,
    this.picturePath,
    required this.foods,
    required this.times,
  });

  Restaurant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    capacity = json['capacity'];
    address = json['address'];
    phoneNumber = json['phoneNumber'];
    picturePath = json['picturePath'];
    foods = json['food']
        .map<Food>(
          (food) => Food.fromJson(food),
        )
        .toList();
    times = json['time']
        .map<Time>(
          (time) => Time.fromJson(time),
        )
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'capacity': capacity,
      'address': address,
      'phoneNumber': phoneNumber,
      'picturePath': picturePath,
      'food': foods
          .map(
            (food) => food.toJson(),
          )
          .toList(),
      'time': times
          .map(
            (time) => time.toJson(),
          )
          .toList(),
    };
  }
}
