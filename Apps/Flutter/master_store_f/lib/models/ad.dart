class Ad {
  String? date;
  String? description;
  String? email;
  String? id;
  String? imageUrl;
  String? ownerId;
  int? price;
  String? title;

  Ad(
      {this.date,
      this.description,
      this.email,
      this.id,
      this.imageUrl,
      this.ownerId,
      this.price,
      this.title});

  Ad.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    description = json['description'];
    email = json['email'];
    id = json['id'];
    imageUrl = json['imageURL'];
    ownerId = json['ownerId'];
    price = json['price'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['description'] = description;
    data['email'] = email;
    data['id'] = id;
    data['imageURL'] = imageUrl;
    data['ownerId'] = ownerId;
    data['price'] = price;
    data['title'] = title;
    return data;
  }
}
