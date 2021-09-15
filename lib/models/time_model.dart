class Time {
  int? id;
  int? restaurantId;
  String? day;
  String? date;
  String? time;
  String? availableSeat;
  String? status;

  Time({
    this.id,
    this.restaurantId,
    this.day,
    this.date,
    this.time,
    this.availableSeat,
    this.status,
  });

  Time.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    restaurantId = json['restaurant_id'];
    day = json['day'];
    date = json['date'];
    time = json['time'];
    availableSeat = json['available_seat'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurant_id': restaurantId,
      'day': day,
      'date': date,
      'time': time,
      'available_seat': availableSeat,
      'status': status,
    };
  }
}
