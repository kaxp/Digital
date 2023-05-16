import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/components/atoms/typography/header2.dart';
import 'package:flutter_base_template_1/generated/l10n.dart';

class HomeEmptyView extends StatelessWidget {
  const HomeEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.sentiment_very_dissatisfied_rounded,
          ),
          Header2(
            textAlign: TextAlign.center,
            title: S.current.noResultFound,
          ),
        ],
      ),
    );
  }
}
