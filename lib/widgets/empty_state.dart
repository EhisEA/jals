import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyState extends StatelessWidget {
  final String image, title, description;
  const EmptyState({
    Key key,
    @required this.image,
    @required this.title,
    @required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Image.asset(image),
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Spacer(
          flex: 2,
        ),
      ],
    );
  }
}

class EmptyStateSvg extends StatelessWidget {
  final String svgImage, title, description;
  const EmptyStateSvg({
    Key key,
    @required this.svgImage,
    @required this.title,
    @required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset(
              svgImage,
            ),
            SizedBox(height: 20),
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 35.0, vertical: 10),
              child: Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
