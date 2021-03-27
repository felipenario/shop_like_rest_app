import 'package:shop_like_app_rest/models/user.dart';

class Advert {
  int id;
  String title;
  String description;
  double price;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  Advert({this.id, this.title, this.description, this.price, this.createdAt, this.updatedAt, this.user});

  Advert.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['titulo'];
    description = json['descricao'];
    price = (json['preco']).toDouble();
    createdAt = DateTime.parse(json['createdAt']);
    updatedAt = DateTime.parse(json['updatedAt']);
    user = User.fromJson(json['usuario']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['titulo'] = this.title;
    data['descricao'] = this.description;
    data['preco'] = this.price;
    return data;
  }
}