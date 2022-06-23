class Item {
  constructor(id, ownerId, title, imageUrl, description, price, date, email) {
    this.id = id;
    this.ownerId = ownerId;
    this.title = title;
    this.imageUrl = imageUrl;
    this.description = description;
    this.price = price;
    this.date = date;
    this.email = email;
  }
}

export default Item;
