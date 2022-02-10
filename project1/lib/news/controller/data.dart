import 'package:project1/news/models/category_model.dart';
// tao mang cac Category voi thong tin tuong ung
List<CategoryModel> getCategories(){

  List<CategoryModel> category = <CategoryModel>[];
  CategoryModel categoryModel = CategoryModel();

  //1
  categoryModel = CategoryModel();
  categoryModel.categoryName = "Business";
  categoryModel.imageUrl = "image/business.jfif";
  category.add(categoryModel);

  //2
  categoryModel = CategoryModel();
  categoryModel.categoryName = "Entertainment";
  categoryModel.imageUrl = "image/entertain.jfif";
  category.add(categoryModel);

  //3
  categoryModel = CategoryModel();
  categoryModel.categoryName = "General";
  categoryModel.imageUrl = "image/general.jfif";
  category.add(categoryModel);

  //4
  categoryModel = CategoryModel();
  categoryModel.categoryName = "Health";
  categoryModel.imageUrl = "image/health.jpg";
  category.add(categoryModel);

  //5
  categoryModel = CategoryModel();
  categoryModel.categoryName = "Science";
  categoryModel.imageUrl = "image/science.jpg";
  category.add(categoryModel);

  //6
  categoryModel = CategoryModel();
  categoryModel.categoryName = "Sports";
  categoryModel.imageUrl = "image/sport.jfif";
  category.add(categoryModel);

  //7
  categoryModel = CategoryModel();
  categoryModel.categoryName = "Technology";
  categoryModel.imageUrl = "image/tech.jfif";
  category.add(categoryModel);

  return category;
}