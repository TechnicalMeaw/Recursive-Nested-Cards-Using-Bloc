part of 'card_bloc.dart';

@immutable
abstract class CardEvent {}

class AddCardEvent extends CardEvent {
  final String name;
  final int age;

  AddCardEvent({required this.name, required this.age});
}

class EditCardEvent extends CardEvent {
  final String cardId;
  final String name;
  final int age;

  EditCardEvent({required this.cardId, required this.name, required this.age});
}

class AddNestedCardEvent extends CardEvent {
  final String parentId;
  final String name;
  final int age;

  AddNestedCardEvent({required this.parentId, required this.name, required this.age});
}
