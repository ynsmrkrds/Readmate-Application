import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:readmate_app/enums/menu_items.dart';
import 'package:readmate_app/models/ebook.dart';
import 'package:readmate_app/ui/widgets/cover_image_widget.dart';

class EbooksFrameWidget extends StatelessWidget {
  const EbooksFrameWidget({
    Key? key,
    this.scrollController,
    required this.ebooks,
    required this.onPressed,
    required this.menuItems,
  }) : super(key: key);

  final ScrollController? scrollController;
  final List<Ebook> ebooks;
  final Function() onPressed;
  final List<MenuItems> menuItems;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      padding: const EdgeInsets.all(18.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: ebooks.length,
      itemBuilder: (context, index) {
        final ebook = ebooks[index];

        return FocusedMenuHolder(
          blurSize: 4,
          blurBackgroundColor: Colors.black,
          menuWidth: MediaQuery.of(context).size.width * 0.5,
          menuItems: getMenuItems(context, ebook),
          onPressed: () {
            onPressed();
          },
          child: buildEbookFrame(ebook),
        );
      },
    );
  }

  List<FocusedMenuItem> getMenuItems(BuildContext context, Ebook ebook) {
    var items = <FocusedMenuItem>[];

    for (var menuItem in menuItems) {
      switch (menuItem) {
        case MenuItems.add:
          items.add(buildAddToBookshelfButton());
          break;
        case MenuItems.details:
          items.add(buildGoToDetailsButton(context, ebook));
          break;
        case MenuItems.remove:
          items.add(buildRemoveEBookButton());
          break;
      }
    }

    return items;
  }

  FocusedMenuItem buildGoToDetailsButton(BuildContext context, Ebook ebook) {
    return FocusedMenuItem(
      title: const Text("Details"),
      trailingIcon: const Icon(Icons.info),
      onPressed: () {
        Navigator.pushNamed(context, "/details", arguments: ebook);
      },
    );
  }

  FocusedMenuItem buildAddToBookshelfButton() {
    return FocusedMenuItem(
      title: const Text("Add to Bookshelf"),
      trailingIcon: const Icon(Icons.add_box),
      onPressed: () {},
    );
  }

  FocusedMenuItem buildRemoveEBookButton() {
    return FocusedMenuItem(
      title: const Text(
        "Remove E-book",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      trailingIcon: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
      backgroundColor: Colors.red,
      onPressed: () {},
    );
  }

  Card buildEbookFrame(Ebook ebook) {
    return Card(
      elevation: 7,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: CoverImageWidget(
                url: ebook.coverLink,
                height: 100,
              ),
            ),
            Flexible(
              child: buildEbookTitleText(ebook),
            ),
          ],
        ),
      ),
    );
  }

  Text buildEbookTitleText(Ebook ebook) => Text(ebook.title);
}
