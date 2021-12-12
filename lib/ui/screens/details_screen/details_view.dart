import 'package:flutter/material.dart';
import 'package:readmate_app/core/models/ebook.dart';
import 'package:readmate_app/ui/screens/details_screen/details_viewmodel.dart';
import 'package:readmate_app/ui/widgets/cover_image_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsView extends StatelessWidget {
  DetailsView({Key? key}) : super(key: key);

  final DetailsViewModel _viewModel = DetailsViewModel();

  @override
  Widget build(BuildContext context) {
    _viewModel.ebook = ModalRoute.of(context)!.settings.arguments as Ebook;

    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 48.0.h),
        child: buildBody(context),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text("Details"),
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

  Row buildGeneralInformationPart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(child: buildEbookCoverImage()),
        Flexible(child: buildEbookTitleText()),
      ],
    );
  }

  Container buildEbookCoverImage() {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.black38)),
      child: CoverImageWidget(
        url: _viewModel.ebook.coverLink,
        height: 150.h,
      ),
    );
  }

  Text buildEbookTitleText() {
    return Text(
      _viewModel.ebook.title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0.sp),
    );
  }

  Padding buildAuthorsInformationPart() {
    return Padding(
      padding: EdgeInsets.only(top: 36.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitleText("Author(s) of Book"),
          for (var author in _viewModel.ebook.authors)
            Padding(
              padding: EdgeInsets.only(top: 18.0.h, left: 18.0.w),
              child: Text(
                "• ${author.name}   ${author.birthYear ?? "????"} - ${author.deathYear ?? "????"}",
                style: TextStyle(fontSize: 16.0.sp),
              ),
            ),
        ],
      ),
    );
  }

  Padding buildSubjectsInformationPart() {
    return Padding(
      padding: EdgeInsets.only(top: 36.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitleText("Subjects"),
          for (var subject in _viewModel.ebook.subjects)
            Padding(
              padding: EdgeInsets.only(left: 18.0.w, top: 18.0.h),
              child: Text(
                "• $subject",
                style: TextStyle(fontSize: 16.0.sp),
              ),
            ),
        ],
      ),
    );
  }

  Padding buildLanguagesInformationPart() {
    return Padding(
      padding: EdgeInsets.only(top: 36.0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildTitleText("Languages"),
          for (var language in _viewModel.ebook.languages)
            Padding(
              padding: EdgeInsets.only(left: 18.0.w, top: 18.0.h),
              child: Text(
                "• ${language.toUpperCase()}",
                style: TextStyle(fontSize: 16.0.sp),
              ),
            ),
        ],
      ),
    );
  }

  Text buildTitleText(String title) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0.sp),
    );
  }
}
