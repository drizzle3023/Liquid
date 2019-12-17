
class SubCategory {
  String categoryId;
  int id;
  String name;


  SubCategory({
    this.categoryId,
    this.id,
    this.name
  });

  Map<String, Object> toJson() {
    return {
      'categoryId': categoryId == null ? '' : categoryId,
      'id': id == null ? 0 : id,
      'name': name == null ? '' : name,
    };
  }

  factory SubCategory.fromJson(Map<dynamic, dynamic> doc) {
    SubCategory subCategory = new SubCategory(
      categoryId: doc['categoryId'] == null ? '' : doc['categoryId'],
      id: doc['id'],
      name: doc['name'],
    );
    return subCategory;
  }

}