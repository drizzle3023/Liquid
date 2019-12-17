
class MainCategory {
  String categoryId;
  int id;
  String name;


  MainCategory({
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

  factory MainCategory.fromJson(Map<dynamic, dynamic> doc) {
    MainCategory mainCategory = new MainCategory(
      categoryId: doc['categoryId'] == null ? '' : doc['categoryId'],
      id: doc['id'],
      name: doc['name'],
    );
    return mainCategory;
  }

}