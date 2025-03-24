import 'package:json_annotation/json_annotation.dart';

part 'recipe.g.dart';

@JsonSerializable()
class Recipe {
  final String? name;
  @JsonKey(name: 'totalTime')
  final String? cookingTime;
  final List<String>? ingredients;
  final List<String>? instructions;

  Recipe({
     this.name,
     this.cookingTime,
     this.ingredients,
     this.instructions,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Recipe) return false;
    return name == other.name && cookingTime == other.cookingTime;
  }

  @override
  int get hashCode => name.hashCode ^ cookingTime.hashCode;

  factory Recipe.fromJson(
    final Map<String, dynamic> json,
  ) =>
      _$RecipeFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeToJson(this);
}
