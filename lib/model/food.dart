class Food {
  final String foodName;
  final String foodCategory;
  final double calories;
  final String nationality;
  final String description;
  final String img;
  Food(this.foodName, this.foodCategory, this.calories, this.nationality,
      this.description, this.img);
  Food.fromJson(Map<String, dynamic> json)
      : this.foodName = json['foodName'],
        this.foodCategory = json['foodCategory'],
        this.calories = json['calories'],
        this.nationality = json['nationality'],
        this.description = json['description'],
        this.img = json['img'];
  Map<String, dynamic> toJson() => {
        'foodName': foodName,
        'foodCategory': foodCategory,
        'calories': calories,
        'nationality': nationality,
        'description': description,
        'img': img,
      };
}
