import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redoq_assignment/model/data/card_model.dart';
import 'package:uuid/uuid.dart'; // Import UUID

part 'card_event.dart';
part 'card_state.dart';

class CardBloc extends Bloc<CardEvent, CardState> {
  final List<CardModel> _cards = [];
  final Uuid _uuid = Uuid(); // Create an instance of Uuid

  CardBloc() : super(CardInitial()) {
    on<AddCardEvent>(_addCard);
    on<EditCardEvent>(_editCard);
    on<AddNestedCardEvent>(_addNestedCard);
  }

  // Add a top-level card
  Future<void> _addCard(AddCardEvent event, Emitter<CardState> emit) async {
    final card = CardModel(
      id: _generateUniqueCardId(), // Use UUID
      name: event.name,
      age: event.age,
      parentId: _generateUniqueCardId(), // Top-level cards have parentId = 0
      childCards: [],
    );
    _cards.add(card);
    emit(CardListLoaded(cards: _cards));
  }

  // Edit an existing card
  Future<void> _editCard(EditCardEvent event, Emitter<CardState> emit) async {
    final card = _findCardById(event.cardId, _cards);


    card?.name = event.name;
    card?.age = event.age;
    emit(CardListLoaded(cards: _cards));
  }

  // Add a nested card
  Future<void> _addNestedCard(AddNestedCardEvent event, Emitter<CardState> emit) async {
    final parentCard = _findCardById(event.parentId, _cards);

    // Create the nested card
    final nestedCard = CardModel(
      id: _generateUniqueCardId(), // Use UUID
      name: event.name,
      age: event.age,
      parentId: event.parentId,
      childCards: [],
    );

    parentCard?.childCards.add(nestedCard);
    emit(CardListLoaded(cards: _cards));
  }

  // Recursive function to find a card by ID in the hierarchy
  CardModel? _findCardById(String id, List<CardModel> cards) {
    for (var card in cards) {
      if (card.id == id) {
        return card;
      }
      // Recursively search in the child cards
      final foundCard = _findCardById(id, card.childCards);
      if (foundCard != null) {
        return foundCard;
      }
    }
    return null; // Card not found
  }


  // Generate a unique ID using UUID
  String _generateUniqueCardId() {
    return _uuid.v4(); // Generates a random UUID
  }
}
