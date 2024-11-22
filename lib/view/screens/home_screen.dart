import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redoq_assignment/bloc/home/card_bloc.dart';
import 'package:redoq_assignment/model/data/card_model.dart';
import 'package:redoq_assignment/view/screens/add_edit_card_screen.dart';

import 'package:redoq_assignment/view/widget/card_details_widget.dart';
import 'package:redoq_assignment/view/widget/collapsable_section_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cardBloc = BlocProvider.of<CardBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Details"),
      ),
      body:
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
        child: BlocBuilder<CardBloc, CardState>(
          builder: (context, state) {
            if (state is CardInitial){
              return const Center(
                child: Text("No cards added yet"),
              );
            } else if (state is CardListLoaded) {
              return ListView.builder(
                itemCount: state.cards.length,
                itemBuilder: (context, index) {
                  final card = state.cards[index];
                  return Padding(
                    padding: EdgeInsets.only(bottom: index < state.cards.length -1 ? 8.0 : 64),
                    child: cardWidget(context, cardBloc, card),
                  );
                },
              );
            }
            return const Center(child: CircularProgressIndicator());
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the Add/Edit Card Screen
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddEditCardScreen(
                onSubmit: (name, age) {
                  // Handle the submitted card details
                  // Add the card to the list or perform other actions as needed
                  cardBloc.add(AddCardEvent(name: name, age: age));
                },
              ),
            ),
          );
        },

        child: const Icon(Icons.add),
      ),
    );
  }

  Widget cardWidget(BuildContext context, CardBloc cardBloc, CardModel card) {
    return CollapsableSectionWidget(
      content: CardDetailsWidget(name: card.name, age: card.age,
        onEditClicked: () {
          // Navigate to the Add/Edit Card Screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditCardScreen(
                onSubmit: (name, age) {
                  // Handle the submitted card details
                  // Add the card to the list or perform other actions as needed
                  cardBloc.add(EditCardEvent(cardId: card.id, name: name, age: age));
                },
              ),
            ),
          );
        },
      ),
      onAddClicked: (){
        // Navigate to the Add/Edit Card Screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddEditCardScreen(
              onSubmit: (name, age) {
                // Handle the submitted card details
                // Add the card to the list or perform other actions as needed
                cardBloc.add(AddNestedCardEvent(name: name, age: age, parentId: card.id));
              },
            ),
          ),
        );
      },
      contentWidgetList: List.generate(card.childCards.length,
              (index)=> Padding(
                padding: EdgeInsets.only(bottom: index < card.childCards.length -1 ? 8.0 : 0),
                child: cardWidget(context, cardBloc, card.childCards[index]),
              )
      ),
    );
  }
}
