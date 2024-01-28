
import 'package:coffee_challenge/core/helper/assets_path.dart';

List<String> _images = [
  AssetsPath.coffeeOne,
  AssetsPath.coffeeTwo,
  AssetsPath.coffeeThree,
  AssetsPath.coffeeFour,
  AssetsPath.coffeeFive,
  AssetsPath.coffeeSix,
  AssetsPath.coffeeSeven,
  AssetsPath.coffeeEight,
];

List<String> _coffeeName = [
  'Espresso',
  'Latte',
  'Cappuccino',
  'Americano',
  'Macchiato',
];

List<String> _subTitles = [
  'Strong & Concentrated',
  'Diluted Espresso',
  'Espresso with Milk',
  'Equal Parts Milk',
  'Strong Flavor',
  'Chocolate & Espresso',
  'Coffee-to-Milk',
  'over Ice Cream',
  'Less Acidic',
  'Chilled Brew',
  'Ground & Water',
  'Grounds with Press',
  'Quick & Smooth Brew',
  'Precision in Brewing',
];

String descriptionConst =
    'A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo. A cappuccino is an approximately 150 ml (5 oz) beverage, with 25 ml of espresso coffee and 85ml of fresh milk the fo.';

class CoffeeItem {
  CoffeeItem({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.rating,
    required this.image,
    required this.price,
  });

  factory CoffeeItem.fromJson(Map<String, dynamic> json) {
    return CoffeeItem(
      id: int.parse(json['id'].toString()),
      title: json['title'].toString(),
      subTitle: json['subTitle'].toString(),
      description: json['description'].toString(),
      rating: json['rating'].toString(),
      image: json['image'].toString(),
      price: json['price'].toString(),
    );
  }
  // factory CoffeeItem.random() {
  //   final random = Random();
  //   final title = _coffeeName[random.nextInt(_coffeeName.length)];
  //   final subTitle = _subTitles[random.nextInt(_subTitles.length)];
  //   final price = ((random.nextDouble() * 10) + 3).toStringAsFixed(2);
  //   final image = _images[random.nextInt(_images.length)];
  //   final rating = (random.nextDouble() * 5).toStringAsFixed(1);

  //   return CoffeeItem(
  //     title: title,
  //     subTitle: subTitle,
  //     description: descriptionConst,
  //     rating: rating,
  //     image: image,
  //     price: '\$$price',
  //   );
  // }
  final int id;
  final String title;
  final String subTitle;
  final String rating;
  final String description;
  final String image;
  final String price;

  // Convert CoffeeItem to a JSON representation
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subTitle': subTitle,
      'description': description,
      'rating': rating,
      'image': image,
      'price': price,
    };
  }
}

class CoffeeShop {
  // static List<CoffeeItem> generateDummyItems(int count) {
  //   return List.generate(count, (_) => CoffeeItem.random());
  // }

  static List<CoffeeItem> get coffeeItems {
    final coffeeItems = <CoffeeItem>[
      CoffeeItem(
        id: 1,
        title: 'Espresso',
        subTitle: 'Strong & Concentrated',
        description: descriptionConst,
        rating: '4.2',
        image: AssetsPath.coffeeOne,
        price: '3.99',
      ),
      CoffeeItem(
        id: 2,
        title: 'Americano',
        subTitle: 'Diluted Espresso',
        description: descriptionConst,
        rating: '4.2',
        image: AssetsPath.coffeeTwo,
        price: '4.49',
      ),
      CoffeeItem(
        id: 3,
        title: 'Latte',
        subTitle: 'Espresso with Milk',
        description: descriptionConst,
        rating: '4.2',
        image: AssetsPath.coffeeThree,
        price: '5.99',
      ),
      CoffeeItem(
        id: 4,
        title: 'Cappuccino',
        subTitle: 'Equal Parts Milk',
        description: descriptionConst,
        rating: '4.2',
        image: AssetsPath.coffeeFour,
        price: '5.49',
      ),
      CoffeeItem(
        id: 5,
        title: 'Macchiato',
        subTitle: 'Strong Flavor',
        description: descriptionConst,
        rating: '4.2',
        image: AssetsPath.coffeeFive,
        price: '4.99',
      ),
      CoffeeItem(
        id: 6,
        title: 'Mocha',
        subTitle: 'Chocolate & Espresso',
        description: descriptionConst,
        rating: '4.2',
        image: AssetsPath.coffeeSix,
        price: '6.49',
      ),
      CoffeeItem(
        id: 7,
        title: 'Flat White',
        subTitle: 'Coffee-to-Milk',
        description: descriptionConst,
        rating: '4.2',
        image: AssetsPath.coffeeSeven,
        price: '6.99',
      ),
      CoffeeItem(
        id: 8,
        title: 'Affogato',
        subTitle: 'over Ice Cream',
        description: descriptionConst,
        rating: '4.2',
        image: AssetsPath.coffeeEight,
        price: '7.99',
      ),
      CoffeeItem(
        id: 9,
        title: 'Cold Brew',
        subTitle: 'Less Acidic',
        description: descriptionConst,
        rating: '4.2',
        image: AssetsPath.coffeeOne,
        price: '4.99',
      ),
      CoffeeItem(
        id: 10,
        title: 'Iced Coffee',
        subTitle: 'Chilled Brew',
        description: descriptionConst,
        rating: '4.2',
        image: AssetsPath.coffeeTwo,
        price: '3.99',
      ),
      CoffeeItem(
        id: 11,
        title: 'Turkish Coffee',
        subTitle: 'Ground & Water',
        description: descriptionConst,
        rating: '4.2',
        image: AssetsPath.coffeeThree,
        price: '4.99',
      ),
      CoffeeItem(
        id: 12,
        title: 'French Press',
        subTitle: 'Grounds with Press',
        description: descriptionConst,
        rating: '4.2',
        image: AssetsPath.coffeeFour,
        price: '7.49',
      ),
      CoffeeItem(
        id: 13,
        title: 'AeroPress',
        subTitle: 'Quick & Smooth Brew',
        description: descriptionConst,
        rating: '4.2',
        image: AssetsPath.coffeeFive,
        price: '6.99',
      ),
      CoffeeItem(
        id: 14,
        title: 'Pour-Over Coffee',
        subTitle: 'Precision in Brewing',
        description: descriptionConst,
        rating: '4.2',
        image: AssetsPath.coffeeSix,
        price: '5.99',
      ),
    ];

    return coffeeItems;
  }
}
