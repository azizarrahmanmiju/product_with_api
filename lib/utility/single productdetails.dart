



class singleProductdetails {
  singleProductdetails({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.thumbnail,
    required this.category,
     required this.review
  });

  int id;
  String title;
  double  price;
  String description;
  String thumbnail;
   String category ;
   List<Review> review;


   factory singleProductdetails.fromJson(Map<String,dynamic> json){
     

     var  reviewfromjson = json['reviews'] as List;
     List<Review> reviewslist = reviewfromjson.map((e) => Review.fromJson(e)).toList();


    return singleProductdetails(id: json['id'] , 
    title: json['title'], 
    price: json['price'], 
    description: json['description'],  
    thumbnail: json['thumbnail'], 
    category: json['category'],
    review: reviewslist
    );
   
   }
}


class Review {
  int rating;
  String comment;
  String date;
  String reviewerName;
  String  reviewerEmail;

  Review({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
    required this.reviewerEmail
  });

  factory  Review.fromJson(Map<String,dynamic> json){
    return Review(rating: json['rating'], 
    comment: json['comment'], 
    date: json['date'], 
    reviewerName: json['reviewerName'], 
    reviewerEmail: json['reviewerEmail']);
  }
  
}


