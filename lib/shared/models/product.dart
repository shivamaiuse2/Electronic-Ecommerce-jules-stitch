class Product {
  final String id;
  final String name;
  final String category;
  final String description;
  final double price;
  final double originalPrice;
  final double discount;
  final String image;
  final double rating;
  final int reviewsCount;
  final List<String> specifications;
  final bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.price,
    required this.originalPrice,
    required this.discount,
    required this.image,
    required this.rating,
    required this.reviewsCount,
    required this.specifications,
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'description': description,
      'price': price,
      'originalPrice': originalPrice,
      'discount': discount,
      'image': image,
      'rating': rating,
      'reviewsCount': reviewsCount,
      'specifications': specifications,
      'isFavorite': isFavorite,
    };
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      description: json['description'],
      price: json['price'].toDouble(),
      originalPrice: json['originalPrice'].toDouble(),
      discount: json['discount'].toDouble(),
      image: json['image'],
      rating: json['rating'].toDouble(),
      reviewsCount: json['reviewsCount'],
      specifications: List<String>.from(json['specifications']),
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Product copyWith({
    String? id,
    String? name,
    String? category,
    String? description,
    double? price,
    double? originalPrice,
    double? discount,
    String? image,
    double? rating,
    int? reviewsCount,
    List<String>? specifications,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      description: description ?? this.description,
      price: price ?? this.price,
      originalPrice: originalPrice ?? this.originalPrice,
      discount: discount ?? this.discount,
      image: image ?? this.image,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      specifications: specifications ?? this.specifications,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
