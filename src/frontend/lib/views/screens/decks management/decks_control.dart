import 'package:FatCat/models/deck_provider.dart';
import 'package:FatCat/views/screens/decks%20management/available_decks/available_deck_screen.dart';
import 'package:FatCat/views/screens/decks%20management/deck_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DecksControl extends StatelessWidget {
  const DecksControl({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller1 = TextEditingController();
    final TextEditingController controller2 = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Decks"),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      scrollable: true,
                      title: const Center(child: Text('New Deck')),
                      content: SizedBox(
                        height: 150,
                        width: 300,
                        child: Column(
                          children: [
                            TextField(
                              controller: controller1,
                              decoration: const InputDecoration(
                                hintText: 'Enter your deck name',
                              ),
                            ),
                            TextField(
                              maxLines: null,
                              controller: controller2,
                              decoration: const InputDecoration(
                                hintText: 'Enter description',
                              ),
                            ),
                          ],
                        ),
                      ),
                      actionsAlignment: MainAxisAlignment.spaceAround,
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Color.fromRGBO(253, 253, 253, 1),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            String deckName = controller1.text;
                            String deckDescription = controller2.text;
                            Map<String, dynamic> deck = {
                              'deckName': deckName,
                              'deckDescription': deckDescription,
                            };
                            Provider.of<DeckProvider>(context, listen: false)
                                .addDeck(deck);
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Create',
                            style: TextStyle(
                              color: Color.fromRGBO(253, 253, 253, 1),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
                controller1.clear();
                controller2.clear();
              },
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AvailableDeckScreen();
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.menu),
                ),
                const Text(
                  "Recommended Decks",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const DeckItemWidget(
                      name: 'English', description: 'Spanish');
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return AvailableDeckScreen();
                        },
                      ),
                    );
                  },
                  icon: const Icon(Icons.menu),
                ),
                const Text(
                  "Available Decks",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return const DeckItemWidget(
                      name: 'Vietnamese', description: 'Spanish');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
