import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/models/deck_model.dart';
import 'package:FatCat/models/deck_provider.dart';
import 'package:FatCat/services/DatabaseHelper.dart';
import 'package:FatCat/views/screens/available_deck_screen.dart';
import 'package:FatCat/views/screens/cards_screen.dart';
import 'package:FatCat/views/widgets/deck_home_item_widget.dart';
import 'package:FatCat/views/widgets/deck_item_widget.dart';
import 'package:FatCat/views/widgets/text_and_showall_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:FatCat/services/DatabaseHelper.dart';

class DecksControl extends StatelessWidget {
  const DecksControl({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller1 = TextEditingController();
    final TextEditingController controller2 = TextEditingController();
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text("Decks"),
        centerTitle: true,
        backgroundColor: AppColors.white,
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
                          onPressed: () async {
                            String deckName = controller1.text;
                            String deckDescription = controller2.text;
                            print("deckName: $deckName");
                            print("deckDescription: $deckDescription");
                            print("============");
                            int i = await insertDeck(DeckModel(
                              id: "1",
                              name: deckName,
                              description: deckDescription,
                              is_published: true,
                              deck_cards_count: "0",
                              createdAt: DateTime.now(),
                              updatedAt: DateTime.now(),
                            ));
                            print(i);
                            // Provider.of<DeckProvider>(context, listen: false)
                            //     .addDeck(deck);
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Create',
                            style: TextStyle(
                              color: Colors.black,
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
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            TextAndShowAllWidget(
              text: "Đề xuất",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return AvailableDeckScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return DeckHomeItemWidget(
                      name: 'English',
                      description: 'Spanish',
                      userCreate: 'duy',
                      onPressed: () async {
                        await Future.delayed(const Duration(milliseconds: 200));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const CardsScreen();
                            },
                          ),
                        );
                      });
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextAndShowAllWidget(
              text: "Tất cả",
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return AvailableDeckScreen();
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return DeckHomeItemWidget(
                    name: 'Vietnamese',
                    description: 'Spanish',
                    userCreate: 'duy',
                    onPressed: () {},
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
