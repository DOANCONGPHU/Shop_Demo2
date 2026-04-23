
class ProductReview {
  final int? productId;
  final bool isReviewed;           
  final int rating;            
  final String comment;           
  final List<String> images;      

  const ProductReview({
     this.productId,
    required this.isReviewed,
    required this.rating,
    required this.comment,
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'isReviewed': isReviewed ? 1 : 0,
      'rating': rating,
      'comment': comment,
      'images': images,
    };
  }

  factory ProductReview.fromMap(Map<String, dynamic> map) {
    return ProductReview(
      productId: map['productId'],
      isReviewed: map['isReviewed'] == 1,
      rating: map['rating'],  
      comment: map['comment'],
      images: List<String>.from(map['images']),
    );
  }
}



