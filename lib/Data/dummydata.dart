class Restaurant {
  const Restaurant(
      {required this.id,
      required this.title,
      required this.menu,
      required this.distance,
      required this.url,
      required this.type});

  final String id;
  final String title;
  final List<Item> menu;
  final int distance;
  final String url;
  final String type;
}

class Item {
  final String name;
  final double price;
  final String imageurl;
  final int num;
  const Item({required this.num,required this.imageurl, required this.name, required this.price});
}

// class ShopCart{
//   final String name ;
//   final double price;
//   final String imageurl;
//
// }

const dummyRestaurant = [
  Restaurant(
      distance: 1,
      id: "#1",
      title: 'Pizza Hut',
      menu: [
        Item(num: 0,
            imageurl:
            "https://www.modernfoods.co.in/wp-content/uploads/2018/06/360pizza.png",
            name: "Margherita Pizza",
            price: 10.99),
        Item(
            num: 1,
            imageurl:
            "https://images.unsplash.com/photo-1628840042765-356cda07504e?auto=format&fit=crop&q=80&w=1780&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
            name: "Pepperoni Pizza",
            price: 12.99),
        Item(
            num: 2,
            imageurl:
            "https://blog.dineout-cdn.co.in/blog/wp-content/uploads/2020/02/Hawaiian-Pizza.jpg",
            name: "Hawaiian Pizza",
            price: 13.99),

      ],
      url:
          "https://wallpapers.com/images/featured-full/pizza-hut-gqkamsjea7s76iqm.jpg",
      type: "Low"),
  Restaurant(
      id: "#2",
      title: "Japenese Food",
      menu: [],
      distance: 2,
      url: "https://images2.alphacoders.com/132/1325913.png",
      type: "High")
];
