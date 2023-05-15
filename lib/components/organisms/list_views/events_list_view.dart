import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/components/molecules/list_items/event_list_cell.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_colors.dart';
import 'package:flutter_base_template_1/constants/spacing_constants.dart';

class EventsListView extends StatelessWidget {
  const EventsListView({super.key, this.isFavorite = false});

  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 7,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kSpacingXSmall,
            vertical: kSpacingXSmall,
          ),
          child: Stack(
            children: [
              const Padding(
                padding: EdgeInsets.all(kSpacingXSmall),
                child: EventListCell(
                  imageUrl: '',
                  city: 'Oakland, CA',
                  title: 'This is the event title',
                  dateAndTime: 'Mon, 13 May, 2023  07:05 PM',
                ),
              ),
              Visibility(
                visible: isFavorite,
                child: const Positioned(
                  top: 2,
                  left: 0,
                  child: Icon(
                    size: 16,
                    color: AppColors.redColor,
                    Icons.favorite,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Container(
          height: 0.5,
          color: AppColors.primaryColor,
        );
      },
    );
  }
}
