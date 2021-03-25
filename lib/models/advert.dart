class Advert {
  int id;
  String title;
  String description;
  int price;

  Advert({this.id, this.title, this.description, this.price});

  Advert.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['titulo'];
    description = json['descricao'];
    price = json['preco'];
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