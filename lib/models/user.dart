class User {
  int id;
  String name;
  String phone;
  String password;

  User({this.id, this.name, this.phone, this.password});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['nome'];
    phone = json['telefone'];
    password = json['senha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.name;
    data['telefone'] = this.phone;
    data['senha'] = this.password;
    return data;
  }

  Map<String, dynamic> loginToJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['telefone'] = this.phone;
    data['senha'] = this.password;
    return data;
  }

}