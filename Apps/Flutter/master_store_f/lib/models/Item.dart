class Item {
  final String id;
  final String? ownerId;
  final String title;
  final String imageUrl;
  final String description;
  final int price;
  final String? date;
  final String? email;
  Item(this.id, this.ownerId, this.title, this.imageUrl, this.description,
      this.price, this.date, this.email);
}

class Cowboy {
  final String name;

  Cowboy(this.name);
}

List<Cowboy> demoContainerV = [Cowboy("name"), Cowboy("name"), Cowboy("name")];
