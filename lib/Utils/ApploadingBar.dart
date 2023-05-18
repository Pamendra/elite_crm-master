import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'color_constants.dart';


class LoadingBar extends StatelessWidget {
  const LoadingBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.deppp, width: 2),
          borderRadius: const BorderRadius.all(
            Radius.circular(8),
          ),
          color: ColorConstants.DarkBlueColor,
          shape: BoxShape.rectangle,
        ),
        child:  CircularProgressIndicator(
          color: ColorConstants.deppp,
        )
    );
  }
}

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return !kIsWeb && Platform.isIOS
        ? const CupertinoActivityIndicator()
        : const CircularProgressIndicator();
  }
}
