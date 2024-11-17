import 'package:FatCat/constants/colors.dart';
import 'package:FatCat/models/card_model.dart';
import 'package:FatCat/models/card_provider.dart';
import 'package:FatCat/models/deck_model.dart';
import 'package:FatCat/viewmodels/card_screen_viewmodel.dart';
import 'package:FatCat/views/screens/create_or_update_deck_screen.dart';
import 'package:FatCat/views/screens/intermittent_study_screen.dart';
import 'package:FatCat/views/screens/multiplechoice_study_screen.dart';
import 'package:FatCat/views/screens/self_study_screen.dart';
import 'package:FatCat/views/widgets/action_bottom_sheet_widget.dart';
import 'package:FatCat/views/widgets/action_button_widget.dart';
import 'package:FatCat/views/widgets/card_item_widget.dart';
import 'package:FatCat/views/widgets/text_and_showall_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

class CardsScreen extends StatelessWidget {
  final DeckModel deck;
  final bool? isLocal;
  final VoidCallback? onDelete;
  const CardsScreen(
      {super.key, required this.deck, this.isLocal, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CardScreenViewModel(
        deck,
        isLocal: isLocal ?? false,
      ),
      child: Consumer<CardScreenViewModel>(
        builder: (context, viewModel, child) {
          List<CardModel> cardData = [];
          if (isLocal == true) {
            cardData = viewModel.cards;
          } else {
            cardData = viewModel.cards;
          }
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: const Text("Thẻ học",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold)),
              backgroundColor: Colors.white,
              centerTitle: true,
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: IconButton(
                    icon: const Icon(Icons.more_vert,
                        size: 28, color: Colors.black),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        builder: (context) => ActionBottomSheet(
                          actions: [
                            if (isLocal == false) ...[
                              ActionItem(
                                icon: CupertinoIcons.share,
                                title: 'Sao chép bộ thẻ',
                                isDestructive: false,
                                onTap: () {},
                              ),
                            ],
                            if (isLocal == true) ...[
                              ActionItem(
                                icon: CupertinoIcons.square_pencil,
                                title: 'Chỉnh sửa',
                                onTap: () {
                                  PersistentNavBarNavigator.pushNewScreen(
                                    context,
                                    screen: CreateOrUpdateDeckScreen(
                                      deckId: deck.id,
                                      initialDeck: deck,
                                      onDelete: () async {
                                        await viewModel.loadCards();
                                      },
                                      initialCards: cardData,
                                    ),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                              ),
                              ActionItem(
                                icon: Icons.share,
                                title: 'Chia sẻ với mọi người',
                                isDestructive: false,
                                onTap: () async {
                                  Fluttertoast.showToast(
                                    msg: 'Chia sẻ thành công',
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.white,
                                    textColor: Colors.black,
                                    fontSize: 16.0,
                                  );
                                },
                              ),
                              ActionItem(
                                icon: CupertinoIcons.delete,
                                title: 'Xóa',
                                isDestructive: true,
                                onTap: () async {
                                  if (await viewModel
                                      .deleteAllCardsForDeck(deck.id!)) {
                                    if (onDelete != null) {
                                      onDelete!();
                                    }
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                      msg: "Xóa thành công",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.white,
                                      textColor: Colors.black,
                                      fontSize: 16.0,
                                    );
                                  }
                                },
                              ),
                            ]
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deck.name,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tác giả: ${deck.user_name ?? 'Bạn'}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.brown,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${deck.deck_cards_count} Thuật ngữ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.brown,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(deck.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        )),
                    SizedBox(height: 20),
                    const Text(
                      'Chọn chế độ học',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    actionButtonWidget(
                        pathName: 'mode_red.png',
                        text: "Tự học",
                        onTap: () {
                          if (!cardData.isEmpty) {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: SelfStudyScreen(
                                cards: cardData,
                                question_language: deck.question_language,
                                answer_language: deck.answer_language,
                              ),
                              withNavBar: false,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    actionButtonWidget(
                        pathName: 'mode_blue.png',
                        text: "Học theo tiến trình",
                        onTap: () {
                          if (!cardData.isEmpty) {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: IntermittentStudyScreen(
                                cards: cardData,
                                question_language: deck.question_language,
                                answer_language: deck.answer_language,
                              ),
                              withNavBar: false,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    actionButtonWidget(
                        pathName: 'mode_green.png',
                        text: "Học chọn nhiều đáp án",
                        onTap: () {
                          if (!cardData.isEmpty) {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen:
                                  MultipleChoiceStudyScreen(cards: cardData),
                              withNavBar: false,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Tất cả thuật ngữ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CardItemWidget(
                          question: cardData[index].question,
                          answer: cardData[index].answer,
                          question_language: deck.question_language,
                          answer_language: deck.answer_language,
                        );
                      },
                      itemCount: cardData.length,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
