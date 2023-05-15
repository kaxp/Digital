// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "backToHome": MessageLookupByLibrary.simpleMessage("Back to Home"),
        "detailPage": MessageLookupByLibrary.simpleMessage("Detail Page"),
        "homePage": MessageLookupByLibrary.simpleMessage("Home Page"),
        "invalidClientIdError": MessageLookupByLibrary.simpleMessage(
            "Client Id is invalid, please check and try again"),
        "myFavouriteEvents":
            MessageLookupByLibrary.simpleMessage("My Favourite events"),
        "navigateToDetailPage":
            MessageLookupByLibrary.simpleMessage("Navigate to Detail Page"),
        "networkErrorMessage": MessageLookupByLibrary.simpleMessage(
            "Make sure you are connected to an internet connection and please try again."),
        "networkRequestCanceled":
            MessageLookupByLibrary.simpleMessage("Request cancelled"),
        "somethingWentWrong": MessageLookupByLibrary.simpleMessage(
            "Something went wrong while connecting to the server. Please try again"),
        "unknownError":
            MessageLookupByLibrary.simpleMessage("Sorry, something went wrong")
      };
}
