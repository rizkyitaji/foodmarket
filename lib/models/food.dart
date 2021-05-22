part of 'models.dart';

enum FoodType { new_food, popular, recommended }

class Food extends Equatable {
  final int id;
  final String name;
  final String picturePath;
  final String description;
  final String ingredients;
  final int price;
  final double rate;
  final List<FoodType> types;

  Food({
    this.id,
    this.name,
    this.picturePath,
    this.description,
    this.ingredients,
    this.price,
    this.rate,
    this.types = const [],
  });

  factory Food.fromJson(Map<String, dynamic> data) => Food(
      id: data['id'],
      name: data['name'],
      picturePath: data['picturePath'],
      description: data['description'],
      ingredients: data['ingredients'],
      price: data['price'],
      rate: (data['rate'] as num).toDouble(),
      types: data['types'].toString().split(',').map((e) {
        switch (e) {
          case 'recommended':
            return FoodType.recommended;
            break;
          case 'popular':
            return FoodType.popular;
            break;
          default:
            return FoodType.new_food;
        }
      }).toList());

  @override
  List<Object> get props =>
      [id, name, picturePath, description, ingredients, price, rate];
}

List<Food> mockFoods = [
  Food(
    id: 1,
    name: "Nasi Goreng",
    picturePath:
        "https://www.resepistimewa.com/wp-content/uploads/nasi-goreng-jawa.jpg",
    description: "Makanan asli Indonesia",
    ingredients: "Nasi, Telur, Sambal, Acar, Kerupuk",
    price: 15000,
    rate: 5.0,
    types: [FoodType.new_food, FoodType.popular, FoodType.recommended],
  ),
  Food(
    id: 2,
    name: "Nasi Uduk",
    picturePath:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWqKXXuZ1G0DO4SfVGNUdOe7MW6F1bDYH11g&usqp=CAU",
    description: "Makanan asli Indonesia",
    ingredients: "Nasi, Telur, Gorengan, Orek Tempe, Kerupuk, Sambal",
    price: 8000,
    rate: 4.5,
    types: [FoodType.new_food, FoodType.popular, FoodType.recommended],
  ),
  Food(
    id: 3,
    name: "Nasi Kebuli",
    picturePath:
        "https://d265bwk65zoq6.cloudfront.net/images/full/47b46070e4ac2def781876f457f0180853366bec_1694x1180.jpg",
    description: "Makanan asli Indonesia",
    ingredients: "Nasi, Daging Kambing, Jahe, Rempah-Rempah",
    price: 20000,
    rate: 4.0,
    types: [FoodType.new_food],
  ),
  Food(
    id: 4,
    name: "Nasi Kuning",
    picturePath:
        "https://www.resepistimewa.com/wp-content/uploads/nasi-kuning.jpg",
    description: "Makanan asli Indonesia",
    ingredients: "Nasi, Kunyit, Telur, Orek Tempe, Kerupuk, Sambal",
    price: 12000,
    rate: 4.5,
    types: [FoodType.recommended],
  ),
  Food(
    id: 5,
    name: "Nasi Kucing",
    picturePath:
        "https://www.pegipegi.com/travel/wp-content/uploads/2019/08/shutterstock_1134726989-768x511.jpg",
    description: "Makanan asli Indonesia",
    ingredients: "Nasi, Teri, Sambal",
    price: 3000,
    rate: 3.5,
    types: [FoodType.popular],
  ),
];
