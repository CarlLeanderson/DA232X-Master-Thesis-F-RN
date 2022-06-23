import 'package:flutter/material.dart';
import 'package:master_store_f/screens/Ads/view_ad_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(Key? key, this.imageUrl, this.title, this.price, this.date,
      this.description, this.ownerId, this.id, this.email)
      : super(key: key);

  final String imageUrl;
  final String title;
  final int price;
  final String date;
  final String description;
  final String ownerId;
  final String id;
  final String email;

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width / 100);
    return (Container(
      width: width * 80,
      margin: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewAdScreen(
                  title: title,
                  imageUrl: imageUrl,
                  date: date,
                  price: price,
                  description: description,
                  ownerId: ownerId,
                  id: id,
                  email: email),
            ),
          )
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "open-sans-bold",
                      ),
                    ),
                    Text(
                      price.toString() + "kr",
                      style: const TextStyle(
                          fontFamily: "open-sans",
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        date,
                        style: const TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
