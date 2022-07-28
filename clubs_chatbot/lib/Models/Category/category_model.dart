class CategoryModel {
  String id;
  String code;
  String name;
  String imageUrl;
  String iconImageUrl;
  List<dynamic> subCategoriesIds;

  CategoryModel({
    this.id,
    this.code,
    this.name,
    this.imageUrl,
    this.iconImageUrl,
    this.subCategoriesIds,
  });

  Map<String, dynamic> toAppDatabase() {
    return {
      "id": id,
      "code": code,
      "name": name,
      "imageUrl": imageUrl,
      "iconImageUrl": iconImageUrl,
      "subCategoriesIds":
          subCategoriesIds.length == 0 ? "" : subCategoriesIds.join(","),
    };
  }

  factory CategoryModel.fromAppDatabase({Map<String, dynamic> map}) {
    return CategoryModel(
      id: map["id"],
      code: map["code"],
      name: map["name"],
      imageUrl: map["imageUrl"],
      iconImageUrl: map["iconImageUrl"],
      subCategoriesIds: map["subCategoriesIds"].length == 0
          ? []
          : map["subCategoriesIds"].split(","),
    );
  }

  Map<String, dynamic> toFirebase() {
    return {
      "id": id,
      "code": code,
      "name": name,
      "imageUrl": imageUrl,
      "iconImageUrl": iconImageUrl,
      "subCategoriesIds": subCategoriesIds,
    };
  }

  factory CategoryModel.fromFirebase({Map<String, dynamic> map}) {
    return CategoryModel(
      id: map["id"],
      code: map["code"],
      name: map["name"],
      imageUrl: map["imageUrl"],
      iconImageUrl: map["iconImageUrl"],
      subCategoriesIds: map["subCategoriesIds"],
    );
  }
}
