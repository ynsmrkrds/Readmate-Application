import 'package:flutter/material.dart';
import 'package:readmate_app/ui/widgets/searching_text_field_widget.dart';

class SearchingBarWidget extends StatefulWidget {
  const SearchingBarWidget({
    Key? key,
    required this.onSubmitted,
    required this.onBarClosed,
    required this.title,
  }) : super(key: key);

  final Widget title;
  final Function(String value) onSubmitted;
  final Function() onBarClosed;

  @override
  State<SearchingBarWidget> createState() => _SearchingBarWidgetState();
}

class _SearchingBarWidgetState extends State<SearchingBarWidget> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isSearching ? buildSearchTextField() : widget.title,
        buildOpenCloseSearchingBarButton(),
      ],
    );
  }

  Flexible buildSearchTextField() {
    return Flexible(
      child: SearchingTextFieldWidget(
        onSubmitted: (value) {
          widget.onSubmitted(value);
        },
      ),
    );
  }

  IconButton buildOpenCloseSearchingBarButton() {
    return IconButton(
      icon: isSearching ? const Icon(Icons.close) : const Icon(Icons.search),
      onPressed: () {
        widget.onBarClosed();
        setState(() {
          isSearching = isSearching == false ? true : false;
        });
      },
    );
  }
}
