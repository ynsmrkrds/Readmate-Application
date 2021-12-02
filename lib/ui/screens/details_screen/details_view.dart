import 'package:flutter/material.dart';
import 'package:readmate_app/ui/screens/details_screen/details_viewmodel.dart';
import 'package:readmate_app/ui/widgets/cover_image_widget.dart';

class DetailsView extends StatelessWidget {
  DetailsView({Key? key}) : super(key: key);

  final DetailsViewModel _viewModel = DetailsViewModel();

  @override
  Widget build(BuildContext context) {
    _viewModel.index = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        child: buildBody(context),
      ),
    );
  }

  Column buildBody(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildGeneralInformationPart(),
        buildAuthorsInformationPart(),
        buildSubjectsInformationPart(),
        buildLanguagesInformationPart(),
      ],
    );
  }

  Padding buildAuthorsInformationPart() {
    return Padding(
      padding: const EdgeInsets.only(top: 36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Author(s) of Book",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          for (var author in _viewModel.ebook.authors)
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 18.0),
              child: Text(
                "• ${author.name}   ${author.birthYear ?? "????"} - ${author.deathYear ?? "????"}",
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
        ],
      ),
    );
  }

  Padding buildSubjectsInformationPart() {
    return Padding(
      padding: const EdgeInsets.only(top: 36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Subjects",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          for (var subject in _viewModel.ebook.subjects)
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 18.0),
              child: Text(
                "• $subject",
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
        ],
      ),
    );
  }

  Padding buildLanguagesInformationPart() {
    return Padding(
      padding: const EdgeInsets.only(top: 36.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Languages",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          for (var language in _viewModel.ebook.languages)
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 18.0),
              child: Text(
                "• ${language.toUpperCase()}",
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
        ],
      ),
    );
  }

  Row buildGeneralInformationPart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: buildEbookCoverImage(),
        ),
        Flexible(
          child: Column(
            children: [
              buildEbookTitleText(),
              const SizedBox(height: 18.0),
              buildReadItButton(),
            ],
          ),
        ),
      ],
    );
  }

  Container buildEbookCoverImage() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black38)),
      child: CoverImageWidget(
        url: _viewModel.ebook.coverLink,
        height: 150,
      ),
    );
  }

  Text buildEbookTitleText() {
    return Text(
      _viewModel.ebook.title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
      textAlign: TextAlign.center,
    );
  }

  TextButton buildReadItButton() {
    return TextButton.icon(
      onPressed: () {},
      icon: const Icon(
        Icons.auto_stories,
        color: Colors.white,
      ),
      label: const Text(
        "Read it",
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double>(5.0),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
        overlayColor: MaterialStateProperty.all<Color>(Colors.white10),
      ),
    );
  }
}
