import 'package:hive/hive.dart';

part '../database/book_models.g.dart';

@HiveType(typeId: 0)
class BookModels extends HiveObject {
  @HiveField(0)
  String? name;

  @HiveField(1)
  String? author;

  @HiveField(2)
  String? description;

  @HiveField(3)
  String? imgUrl;

  @HiveField(4)
  double? price;

  BookModels(this.name, this.author, this.description, this.imgUrl, this.price);
}
