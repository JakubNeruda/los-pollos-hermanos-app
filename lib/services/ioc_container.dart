import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/coupon.dart';
import 'package:los_pollos_hermanos/models/category.dart';
import 'package:los_pollos_hermanos/util/mock_data.dart';
import 'package:los_pollos_hermanos/models/food_order.dart';
import 'package:los_pollos_hermanos/models/product.dart';
import 'package:los_pollos_hermanos/models/registered_user.dart';
import 'package:los_pollos_hermanos/models/restaurant.dart';
import 'package:los_pollos_hermanos/services/generic_service.dart';
import 'package:los_pollos_hermanos/services/logged_user_service.dart';

class IoCContainer {
  static void setup() {
    GetIt.I.registerSingleton(GenericService<Category>(
      (data) => data.toJson(),
      (json) => Category.fromJson(json),
      "categories",
    ));
    GetIt.I.registerSingleton(
      GenericService<Coupon>(
        (data) => data.toJson(),
        (json) => Coupon.fromJson(json),
        "coupons",
      ),
    );
    GetIt.I.registerSingleton(
      GenericService<FoodOrder>(
        (data) => data.toJson(),
        (json) => FoodOrder.fromJson(json),
        "orders",
      ),
    );
    GetIt.I.registerSingleton(
      GenericService<Product>(
        (data) => data.toJson(),
        (json) => Product.fromJson(json),
        "products",
      ),
    );
    GetIt.I.registerSingleton(
      GenericService<Restaurant>(
        (data) => data.toJson(),
        (json) => Restaurant.fromJson(json),
        "restaurants",
      ),
    );
    GetIt.I.registerSingleton(
      GenericService<RegisteredUser>(
        (data) => data.toJson(),
        (json) => RegisteredUser.fromJson(json),
        "users",
      ),
    );
    GetIt.I.registerSingleton(LoggedUserService());
  }

  static void addProducts() {
    for (Product p in MockData().products) {
      GetIt.I.get<GenericService<Product>>().create(p);
    }
  }

  static void addCategories() {
    for (Category c in MockData().categories) {
      GetIt.I.get<GenericService<Category>>().create(c);
    }
  }
}
