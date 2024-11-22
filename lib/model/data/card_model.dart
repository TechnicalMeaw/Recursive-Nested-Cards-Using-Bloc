class CardModel {
  String id;
  String name;
  int age;
  String parentId;
  List<CardModel> childCards;

  CardModel({
    required this.id,
    required this.name,
    required this.age,
    required this.parentId,
    required this.childCards,
  });
}
