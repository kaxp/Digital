import 'package:flutter/material.dart';
import 'package:flutter_base_template_1/components/molecules/list_items/event_list_cell.dart';
import 'package:flutter_base_template_1/config/themes/assets/app_colors.dart';
import 'package:flutter_base_template_1/constants/spacing_constants.dart';
import 'package:flutter_base_template_1/modules/detail/detail_module.dart';
import 'package:flutter_base_template_1/modules/home/models/events_response.dart';
import 'package:flutter_base_template_1/utils/helpers.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchResultListView extends StatelessWidget {
  const SearchResultListView({
    super.key,
    required this.events,
  });

  final List<Event> events;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: events.length,
      itemBuilder: (context, index) {
        final bannerImage = events[index].performers[0].image;
        final city = events[index].venue.city;
        final state = events[index].venue.state;
        final title = events[index].title;
        final dateTime = events[index].datetimeLocal;

        return GestureDetector(
          onTap: () {
            Modular.to.pushNamed(
              DetailRoute.moduleRoute,
              arguments: events[index],
            );
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kSpacingXSmall,
              vertical: kSpacingXSmall,
            ),
            child: Container(
              color: AppColors.backgroundColor,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(kSpacingXSmall),
                    child: EventListCell(
                      imageUrl: bannerImage,
                      city: '$city, $state',
                      title: title,
                      dateAndTime: DateFormatter.formattedFullDateAndTimeWithComma(dateTime),
                    ),
                  ),
                  Visibility(
                    visible: events[index].isFavourite,
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
            ),
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
