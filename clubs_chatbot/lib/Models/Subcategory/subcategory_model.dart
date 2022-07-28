class SubcategoryModel {
  String id;
  String code;
  String name;
  String imageUrl;
  String iconImageUrl;

  SubcategoryModel({
    this.id,
    this.code,
    this.name,
    this.imageUrl,
    this.iconImageUrl,
  });

  Map<String, dynamic> toAppDatabase() {
    return {
      "id": id,
      "code": code,
      "name": name,
      "imageUrl": imageUrl,
      "iconImageUrl": iconImageUrl,
    };
  }

  Map<String, dynamic> toFirebase() {
    return {
      "id": id,
      "code": code,
      "name": name,
      "imageUrl": imageUrl,
      "iconImageUrl": iconImageUrl,
    };
  }

  factory SubcategoryModel.fromFirebase({Map<String, dynamic> map}) {
    return SubcategoryModel(
      id: map["id"],
      code: map["code"],
      name: map["name"],
      imageUrl: map["imageUrl"],
      iconImageUrl: map["iconImageUrl"],
    );
  }
  factory SubcategoryModel.fromAppDatabase({Map<String, dynamic> map}) {
    return SubcategoryModel(
      id: map["id"],
      code: map["code"],
      name: map["name"],
      imageUrl: map["imageUrl"],
      iconImageUrl: map["iconImageUrl"],
    );
  }
}
