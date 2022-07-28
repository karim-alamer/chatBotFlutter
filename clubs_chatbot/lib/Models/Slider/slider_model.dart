class SliderModel {
  String id;

  String imageUrl;

  SliderModel({
    this.id,
    this.imageUrl,
  });

  Map<String, dynamic> toMapWithId() {
    return {
      "id": id,
      "imageUrl": imageUrl,
    };
  }

  factory SliderModel.fromFirebase({Map<String, dynamic> map}) {
    return SliderModel(
      id: map["id"],
      imageUrl: map["imageUrl"],
    );
  }
  factory SliderModel.fromAppDatabase({Map<String, dynamic> map}) {
    return SliderModel(
      id: map["id"],
      imageUrl: map["imageUrl"],
    );
  }
}
