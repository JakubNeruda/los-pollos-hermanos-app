import 'package:flutter/material.dart';

import '../models/category.dart';
import '../models/coupon.dart';
import '../models/opening_hours.dart';
import '../models/product.dart';
import '../models/restaurant.dart';
import '../models/time_interval.dart';

const boxURL =
    "https://firebasestorage.googleapis.com/v0/b/los-pollos-hermanos-4a508.appspot.com/o/box.jpg?alt=media&token=95394d33-823b-4fbe-b94b-7899d71d970e";
const boxesURL =
    'https://firebasestorage.googleapis.com/v0/b/los-pollos-hermanos-4a508.appspot.com/o/boxes.jpg?alt=media&token=0eb5a402-40c6-4c54-8e76-4ae9ac42f6f5';
const burgerURL =
    "https://firebasestorage.googleapis.com/v0/b/los-pollos-hermanos-4a508.appspot.com/o/burger.jpg?alt=media&token=daa0190c-b9d2-447d-b2e6-0e79e50fd38b";
const chickenURL =
    "https://firebasestorage.googleapis.com/v0/b/los-pollos-hermanos-4a508.appspot.com/o/chicken.jpg?alt=media&token=94ebe2f9-b6c4-4d0e-a040-f71bd82e1620";
const coffeeURL =
    "https://firebasestorage.googleapis.com/v0/b/los-pollos-hermanos-4a508.appspot.com/o/coffee.jpg?alt=media&token=dfd3abda-d90d-4f9c-a202-131804875a49";
const colaURL =
    "https://firebasestorage.googleapis.com/v0/b/los-pollos-hermanos-4a508.appspot.com/o/cola.jpg?alt=media&token=fca9ec0d-e249-42cb-938c-7de435de62d4";
const curlyFriesURL =
    "https://firebasestorage.googleapis.com/v0/b/los-pollos-hermanos-4a508.appspot.com/o/curly_fries.jpg?alt=media&token=038d4cd5-cf48-4b2e-a6df-bbe9f2d361f8";
const iceCreamURL =
    "https://firebasestorage.googleapis.com/v0/b/los-pollos-hermanos-4a508.appspot.com/o/ice_cream.jpg?alt=media&token=6e6d514e-be0c-4573-8e32-e617297e1a0e";
const iceTeaURL =
    "https://firebasestorage.googleapis.com/v0/b/los-pollos-hermanos-4a508.appspot.com/o/icetea.jpg?alt=media&token=6054664b-21ec-49a0-8e68-d107d0362520";
const nachosURL =
    "https://firebasestorage.googleapis.com/v0/b/los-pollos-hermanos-4a508.appspot.com/o/nachos.jpg?alt=media&token=53325c5b-611f-4f5e-94ce-7c072e6c5345";
const tacosURL =
    "https://firebasestorage.googleapis.com/v0/b/los-pollos-hermanos-4a508.appspot.com/o/tacos.jpg?alt=media&token=acdb0754-d06b-4511-bd77-b9ce3d939186";
const wrapURL =
    "https://firebasestorage.googleapis.com/v0/b/los-pollos-hermanos-4a508.appspot.com/o/wrap.jpg?alt=media&token=efce5894-3cca-4804-889e-30d6d7a08924";

const intervalAllDay = TimeInterval(
    start: TimeOfDay(hour: 0, minute: 0), end: TimeOfDay(hour: 23, minute: 59));

const openingHoursUsual = OpeningHours(
  monday: TimeInterval(
      start: TimeOfDay(hour: 6, minute: 0),
      end: TimeOfDay(hour: 22, minute: 0)),
  tuesday: TimeInterval(
      start: TimeOfDay(hour: 6, minute: 0),
      end: TimeOfDay(hour: 22, minute: 0)),
  wednesday: TimeInterval(
      start: TimeOfDay(hour: 6, minute: 0),
      end: TimeOfDay(hour: 22, minute: 0)),
  thursday: TimeInterval(
      start: TimeOfDay(hour: 6, minute: 0),
      end: TimeOfDay(hour: 22, minute: 0)),
  friday: TimeInterval(
      start: TimeOfDay(hour: 6, minute: 0),
      end: TimeOfDay(hour: 22, minute: 0)),
  saturday: TimeInterval(
      start: TimeOfDay(hour: 8, minute: 0),
      end: TimeOfDay(hour: 22, minute: 0)),
  sunday: TimeInterval(
      start: TimeOfDay(hour: 8, minute: 0),
      end: TimeOfDay(hour: 20, minute: 0)),
);
const openingHoursNonStop = OpeningHours(
  monday: intervalAllDay,
  tuesday: intervalAllDay,
  wednesday: intervalAllDay,
  thursday: intervalAllDay,
  friday: intervalAllDay,
  saturday: intervalAllDay,
  sunday: intervalAllDay,
);

final class MockData {
  final couponChicken = Coupon(
    id: "1", //TODO: remove id
    name: "Chicken wings, 6 pieces",
    description:
        "Bucket containing 6 spicy chicken wings and our signature sauce.",
    price: 99,
    imageURL: chickenURL,
    expiration: DateTime(2024, 12, 31),
    applicableHours: const TimeInterval(
        start: TimeOfDay(hour: 11, minute: 0),
        end: TimeOfDay(hour: 23, minute: 59)),
    productIDs: List.empty(),
  );
  final couponBurger = Coupon(
    id: "2", //TODO: remove id
    name: "CheeseBurger",
    description: "1/4 pound burger with cheddar, fresh tomatoes and lettuce.",
    price: 69,
    imageURL: burgerURL,
    expiration: null,
    applicableHours: null,
    productIDs: List.empty(),
  );
  final couponMenu = Coupon(
    name: "Box with curly fries",
    description: "Curly fries with spicy sauce and either a burger or a wrap.",
    price: 89,
    imageURL: boxURL,
    expiration: DateTime(2024, 1, 31),
    applicableHours: const TimeInterval(
        start: TimeOfDay(hour: 11, minute: 0),
        end: TimeOfDay(hour: 20, minute: 00)),
    productIDs: List.empty(),
  );
  final couponCoffee = Coupon(
    name: "Large Coffee",
    description: "Black, Cappuccino or Latte, 0.3L.",
    price: 39,
    imageURL: coffeeURL,
    expiration: DateTime(2024, 12, 31),
    applicableHours: const TimeInterval(
        start: TimeOfDay(hour: 6, minute: 0),
        end: TimeOfDay(hour: 12, minute: 00)),
    productIDs: List.empty(),
  );
  final couponExpired = Coupon(
    name: "**EXPIRED** Large Coffee",
    description: "Black, Cappuccino or Latte, 0.3L.",
    price: 39,
    imageURL: coffeeURL,
    expiration: DateTime(2023, 12, 31),
    applicableHours: const TimeInterval(
        start: TimeOfDay(hour: 6, minute: 0),
        end: TimeOfDay(hour: 12, minute: 00)),
    productIDs: List.empty(),
  );

  final restaurantBrno = const Restaurant(
    name: "LPH Brno, Náměstí Svobody",
    description: "Náměstí Svobody 321, Brno-střed, 60200",
    email: "customer@lph.com",
    telephone: "+420 111 111 111",
    openingHours: openingHoursUsual,
  );

  final restaurantPrague = const Restaurant(
    name: "LPH Praha, Staroměstské náměstí",
    description: "Staroměstské náměstí, 12, Praha 1, 11000",
    email: "customer@lph.com",
    telephone: "+420 123 456 789",
    openingHours: openingHoursNonStop,
  );

  final List<Category> categories = [
    const Category(name: "Chicken", imageURL: chickenURL, productIDs: [
      "5UA43L3ILaokAIxJhzOx",
      "8AbZqNoHkoppton0xxs1",
      "8bzNNrFGJC6cI5vnYWt5",
      "9uIsbQ1Nb1jSFDC2kQSo",
      "kbpLemLl9VqWzmje32Si",
      "r7CuDU1KWmGDFAtYqwag",
    ]),
    const Category(name: "Side Dishes", imageURL: curlyFriesURL, productIDs: [
      "8FzqxwGwR5U8PejtMFI3",
      "vrIlgMWEd4claohamCxp",
    ]),
    const Category(name: "Boxes", imageURL: boxesURL, productIDs: [
      "5UA43L3ILaokAIxJhzOx",
      "r7CuDU1KWmGDFAtYqwag",
    ]),
    const Category(name: "Desserts", imageURL: iceCreamURL, productIDs: [
      "TGAcAD6lzGANEjuujcmB",
    ]),
    const Category(name: "Burgers", imageURL: burgerURL, productIDs: [
      "kdbyAfD5cnc4vxSkky3R",
    ]),
    const Category(name: "Tacos", imageURL: tacosURL, productIDs: [
      "KnaKR1ca1uUijBIybX9t",
      "rkPUV2C3pOXPIvJGDLa4",
    ]),
    const Category(name: "Wraps", imageURL: wrapURL, productIDs: [
      "8AbZqNoHkoppton0xxs1",
      "zz6Si9Kgmki35atp3CBj",
    ]),
    const Category(name: "Beverages", imageURL: colaURL, productIDs: [
      "ASSuMBI0akMIKHk7cYLm",
      "B6fxw05ZXZT2A0cixvkI",
      "SRd7LisKxFfl1LO6g4D4",
      "oNl2AR8JeRGSK9Sq3v2G",
      "sUKp7tSulzIXERF4qoWz",
    ]),
  ];

  final List<Product> products = [
    const Product(
        name: "Chicken Bucket 4pcs",
        description:
            "Bucket containing 4 spicy chicken wings and our signature sauce.",
        price: 89,
        imageURL: chickenURL,
        allergens: [
          "gluten",
        ]),
    const Product(
        name: "Chicken Bucket 6pcs",
        description:
            "Bucket containing 6 spicy chicken wings and our signature sauce.",
        price: 119,
        imageURL: chickenURL,
        allergens: [
          "gluten",
        ]),
    const Product(
        name: "Chicken Bucket 9pcs",
        description:
            "Bucket containing 9 spicy chicken wings and our signature sauce.",
        price: 159,
        imageURL: chickenURL,
        allergens: [
          "gluten",
        ]),
    const Product(
        name: "Cheeseburger Box",
        description: "Curly fries with spicy sauce and a cheeseburger.",
        price: 99,
        imageURL: boxURL,
        allergens: [
          "gluten",
          "milk",
        ]),
    const Product(
        name: "Tacos Box",
        description: "Curly fries with spicy sauce and tacos.",
        price: 99,
        imageURL: boxURL,
        allergens: [
          "gluten",
        ]),
    const Product(
        name: "Chicken Box",
        description: "Curly fries with spicy sauce and 3 chicken pieces.",
        price: 99,
        imageURL: boxURL,
        allergens: [
          "gluten",
        ]),
    const Product(
        name: "Wrap Box",
        description: "Curly fries with spicy sauce and chicken wrap.",
        price: 99,
        imageURL: boxURL,
        allergens: [
          "gluten",
        ]),
    const Product(
        name: "Cheeseburger",
        description:
            "1/4 pound burger with cheddar, fresh tomatoes and lettuce.",
        price: 79,
        imageURL: burgerURL,
        allergens: ["gluten", "milk", "sesame"]),
    const Product(
        name: "Curly Fries",
        description: "Curly fries with spicy sauce.",
        price: 49,
        imageURL: curlyFriesURL,
        allergens: [
          "gluten",
        ]),
    const Product(
        name: "Beef Tacos",
        description: "Tacos with ground beef and fresh salsa.",
        price: 79,
        imageURL: tacosURL,
        allergens: [
          "gluten",
        ]),
    const Product(
        name: "Nachos",
        description: "Corn tortillas with melted cheese on top.",
        price: 79,
        imageURL: nachosURL,
        allergens: [
          "milk",
        ]),
    const Product(
        name: "Chicken Wrap",
        description:
            "Chicken pieces, lettuce, tomato and mayo wrapped in tortilla.",
        price: 79,
        imageURL: wrapURL,
        allergens: [
          "gluten",
          "egg",
        ]),
    const Product(
        name: "Ice Cream",
        description: "Vanilla ice cream",
        price: 39,
        imageURL: iceCreamURL,
        allergens: [
          "gluten",
          "egg",
          "milk",
        ]),
    const Product(
        name: "Cola",
        description: "Ice cold cola, 0,5L",
        price: 39,
        imageURL: colaURL,
        allergens: []),
    const Product(
        name: "Diet Cola",
        description: "Ice cold diet cola, 0,5L",
        price: 39,
        imageURL: colaURL,
        allergens: []),
    const Product(
        name: "Dark Coffee",
        description: "Cup of dark coffee, 0,3L",
        price: 49,
        imageURL: coffeeURL,
        allergens: []),
    const Product(
        name: "Cappuccino",
        description: "Cup of cappuccino, 0,3L",
        price: 49,
        imageURL: coffeeURL,
        allergens: []),
    const Product(
        name: "Ice-Tea",
        description: "Lemon ice-tea, 0,4L",
        price: 49,
        imageURL: iceTeaURL,
        allergens: []),
  ];
}
