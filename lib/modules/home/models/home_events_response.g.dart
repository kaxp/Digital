// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_events_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeEventsResponse _$HomeEventsResponseFromJson(Map<String, dynamic> json) =>
    HomeEventsResponse(
      title: json['title'] as String,
      url: json['url'] as String,
      venue: Venue.fromJson(json['venue'] as Map<String, dynamic>),
      shortTitle: json['short_title'] as String,
      id: json['id'] as int,
    );

Map<String, dynamic> _$HomeEventsResponseToJson(HomeEventsResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'url': instance.url,
      'venue': instance.venue,
      'short_title': instance.shortTitle,
      'id': instance.id,
    };

Venue _$VenueFromJson(Map<String, dynamic> json) => Venue(
      city: json['city'] as String,
      name: json['name'] as String,
      country: json['country'] as String,
      state: json['state'] as String,
      id: json['id'] as int,
    );

Map<String, dynamic> _$VenueToJson(Venue instance) => <String, dynamic>{
      'city': instance.city,
      'name': instance.name,
      'country': instance.country,
      'state': instance.state,
      'id': instance.id,
    };
