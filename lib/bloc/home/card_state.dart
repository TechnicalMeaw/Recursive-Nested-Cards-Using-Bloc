part of 'card_bloc.dart';

@immutable
abstract class CardState {}

class CardInitial extends CardState {}

class CardListLoaded extends CardState {
  final List<CardModel> cards;

  CardListLoaded({required this.cards});
}