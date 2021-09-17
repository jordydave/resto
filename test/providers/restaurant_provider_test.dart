// import 'dart:convert';

// import 'package:flutter_test/flutter_test.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:submission_2_restaurant_dicoding/models/restaurant_model.dart';
// import 'package:submission_2_restaurant_dicoding/services/restaurant_service.dart';
// import 'restaurant_provider_test.mocks.dart';

// @GenerateMocks(
//   [http.Client],
// )
// void main() {
//   var query = '';
//   group('fetch restaurant data', () {
//     test('returns a list restaurant if the http call completes successfully',
//         () async {
//       final client = MockClient();

//       when(client.get(Uri.parse('http://app.foodmarket.my.id/api/restaurant')))
//           .thenAnswer((_) async =>
//               http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

//       expect(await RestaurantService.getRestaurants(query, client),
//           isA<List<Restaurant>>());
//     });
//   });
// }

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:submission_2_restaurant_dicoding/models/restaurant_model.dart';
import 'package:submission_2_restaurant_dicoding/services/restaurant_service.dart';
import 'restaurant_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('fetchAlbum', () {
    test('returns a list restaurant if the http call completes successfully',
        () async {
      final client = MockClient();
      var query = '';
      when(client.get(Uri.parse('http://app.foodmarket.my.id/api/restaurant')))
          .thenAnswer((_) async => http.Response(
              '"data": [{"id":4, "name": "Dapur Kukis"}, "description": "Homemade With Love",}]',
              200));

      expect(await RestaurantService.getRestaurants(query, client),
          isA<List<Restaurant>>());
    });
  });
}
