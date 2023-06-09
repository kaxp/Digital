import 'package:flutter_base_template_1/modules/home/models/events_response.dart';

EventsResponse buildEventsResponseFromTemplate({
  List<Event>? events,
  MetaData? meta,
}) {
  return EventsResponse(
    events: events!,
    meta: meta!,
  );
}

Event buildStoreEventFromTemplate({
  int id = 1,
  List<Performer>? performers,
  DateTime? datetimeLocal,
  String title = '',
  Venue? venue,
  bool isFavourite = false,
}) {
  return Event(
    id: id,
    title: title,
    performers: performers!,
    venue: venue!,
    isFavourite: isFavourite,
    datetimeLocal: datetimeLocal!,
  );
}

Performer buildPerformerFromTemplate({
  String image = '',
  int id = 0,
  Images? images,
}) {
  return Performer(
    id: id,
    image: image,
    images: images!,
  );
}

Images buildImagesFromTemplate({
  final String huge = '',
}) {
  return Images(
    huge: huge,
  );
}

Venue buildVenueFromTemplate({
  String? city = '',
  String? state = '',
}) {
  return Venue(
    city: city,
    state: state,
  );
}

MetaData buildMetaDataFromTemplate({
  int total = 0,
  int page = 0,
  int perPage = 0,
}) {
  return MetaData(
    page: page,
    perPage: perPage,
    total: total,
  );
}
