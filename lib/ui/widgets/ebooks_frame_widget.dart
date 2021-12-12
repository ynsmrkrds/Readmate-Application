import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:readmate_app/core/models/ebook.dart';
import 'package:readmate_app/core/providers/account_provider.dart';
import 'package:readmate_app/core/providers/bookshelf_provider.dart';
import 'package:readmate_app/ui/widgets/cover_image_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum MenuItems {
  remove,
  add,
  details,
}

class EbooksFrameWidget extends StatelessWidget {
  const EbooksFrameWidget({
    Key? key,
    this.scrollController,
    required this.ebooks,
    required this.menuItems,
  }) : super(key: key);

  final ScrollController? scrollController;
  final List<Ebook> ebooks;
  final List<MenuItems> menuItems;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      padding: EdgeInsets.all(18.0.w),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: ebooks.length,
      itemBuilder: (context, index) {
        final ebook = ebooks[index];

        return FocusedMenuHolder(
          blurSize: 4,
          blurBackgroundColor: Colors.black,
          menuWidth: 225.w,
          menuItems: getMenuItems(context, ebook),
          onPressed: () => Navigator.pushNamed(context, "/reading", arguments: ebook),
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
          items.add(buildAddToBookshelfButton(ebook));
          break;
        case MenuItems.details:
          items.add(buildGoToDetailsButton(context, ebook));
          break;
        case MenuItems.remove:
          items.add(buildRemoveEbookButton(ebook));
          break;
      }
    }

    return items;
  }

  FocusedMenuItem buildGoToDetailsButton(BuildContext context, Ebook ebook) {
    return FocusedMenuItem(
      title: const Text("Details"),
      trailingIcon: const Icon(Icons.info),
      onPressed: () => Navigator.pushNamed(context, "/details", arguments: ebook),
    );
  }

  FocusedMenuItem buildAddToBookshelfButton(Ebook ebook) {
    return FocusedMenuItem(
      title: const Text("Add to Bookshelf"),
      trailingIcon: const Icon(Icons.add_box),
      onPressed: () => bookshelfProvider.addEbook(accountProvider.user!.uid, ebook),
    );
  }

  FocusedMenuItem buildRemoveEbookButton(Ebook ebook) {
    return FocusedMenuItem(
      title: buildRemoveEbookTitle(),
      trailingIcon: removeEbookButtonIcon,
      backgroundColor: Colors.red,
      onPressed: () => bookshelfProvider.removeEbook(accountProvider.user!.uid, ebook.id),
    );
  }

  Text buildRemoveEbookTitle() {
    return const Text(
      "Remove E-book",
      style: TextStyle(color: Colors.white),
    );
  }

  Icon get removeEbookButtonIcon => const Icon(Icons.delete, color: Colors.white);

  Card buildEbookFrame(Ebook ebook) {
    return Card(
      elevation: 7,
      child: Padding(
        padding: EdgeInsets.all(8.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child: buildCoverImage(ebook)),
            Flexible(child: buildEbookTitleText(ebook)),
          ],
        ),
      ),
    );
  }

  CoverImageWidget buildCoverImage(Ebook ebook) {
    return CoverImageWidget(
      url: ebook.coverLink,
      height: 100.w,
    );
  }

  Text buildEbookTitleText(Ebook ebook) {
    return Text(ebook.title);
  }
}
