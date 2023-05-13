import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_events_response.g.dart';

@JsonSerializable()
class HomeEventsResponse extends Equatable {
  const HomeEventsResponse({
    required this.title,
    required this.url,
    required this.venue,
    required this.shortTitle,
    required this.id,
  });

  final String title;
  final String url;
  final Venue venue;
  @JsonKey(name: 'short_title')
  final String shortTitle;
  final int id;

  factory HomeEventsResponse.fromJson(Map<String, dynamic> json) => _$HomeEventsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HomeEventsResponseToJson(this);

  List<Object?> get props => [title, url, venue, shortTitle, id];
}

@JsonSerializable()
class Venue extends Equatable {
  const Venue({
    required this.city,
    required this.name,
    required this.country,
    required this.state,
    required this.id,
  });

  final String city;
  final String name;
  final String country;
  final String state;
  final int id;

  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);

  Map<String, dynamic> toJson() => _$VenueToJson(this);

  List<Object?> get props => [city, name, country, state, id];
}
