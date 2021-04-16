import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:shimmer/shimmer.dart';

class LoaderPage extends StatelessWidget {
  final Widget child;
  final bool busy;
  const LoaderPage({Key key, @required this.child, @required this.busy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: child,
          ),
          busy
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.75),
                  child: SpinKitRipple(
                    size: 180,
                    itemBuilder: (BuildContext context, int index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(90),
                          color: kPrimaryColor.withOpacity(0.8),
                        ),
                      );
                    },
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}

class LoaderPageBlank extends StatelessWidget {
  final Widget child;
  final bool busy;
  const LoaderPageBlank({Key key, @required this.child, @required this.busy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: child,
          ),
          busy
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.5),
                )
              : SizedBox()
        ],
      ),
    );
  }
}

class LoaderPageWithTextIndicator extends StatelessWidget {
  final Widget child;
  final String textIndicator;
  final bool busy;
  const LoaderPageWithTextIndicator(
      {Key key,
      @required this.child,
      @required this.busy,
      @required this.textIndicator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: child,
          ),
          busy
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.75),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Shimmer.fromColors(
                          baseColor: kTextColor.withOpacity(0.6),
                          highlightColor: kPrimaryColor,
                          child: Text(
                            '$textIndicator',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}

class LoaderPageRipple extends StatelessWidget {
  final Widget child;
  final bool busy;
  const LoaderPageRipple({Key key, @required this.child, @required this.busy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            child: child,
          ),
          busy
              ? Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.75),
                  child: SpinKitRipple(
                    color: kPrimaryColor,
                    size: 180,
                    borderWidth: 10,
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
