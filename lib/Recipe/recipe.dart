// class RecipeList {
//   final String title;
//   final List<String> mainImage;
//   final List<String> ingredName;
//   final List<String> ingredAmount;
//   final List<String> recipeStep;
//   final List<String> recipeImage;
//   final int views;
//   final String writer;
//
//   RecipeList ({
//     required this.title,
//     required this.mainImage,
//     required this.ingredName,
//     required this.ingredAmount,
//     required this.recipeStep,
//     required this.recipeImage,
//     required this.views,
//     required this.writer
//   });
//
//   factory RecipeList.fromJson(Map<String, dynamic> parsedJson) {
//     var mainImageFromJson = parsedJson["main_image"];
//     List<String> mainImageList = new List<String>.from(mainImageFromJson);
//
//     var ingredNameFromJson = parsedJson["ingred_name"];
//     List<String> ingredNameList = new List<String>.from(ingredNameFromJson);
//
//     var ingredAmountFromJson = parsedJson["ingred_amount"];
//     List<String> ingredAmountList = new List<String>.from(ingredAmountFromJson);
//
//     var recipeStepFromJson = parsedJson["recipe_step"];
//     List<String> recipeStepList = new List<String>.from(recipeStepFromJson);
//
//     var recipeImageFromJson = parsedJson["recipe_image"];
//     List<String> recipeImageList = new List<String>.from(recipeImageFromJson);
//
//     return new RecipeList(
//         title: parsedJson["title"],
//         mainImage: mainImageList,
//         ingredName: ingredNameList,
//         ingredAmount: ingredAmountList,
//         recipeStep: recipeStepList,
//         recipeImage: recipeImageList,
//         views: parsedJson['views'],
//         writer: parsedJson['writer']
//     );
//   }
// }
//
// void addRecipeToList(String title, ){
//
// }