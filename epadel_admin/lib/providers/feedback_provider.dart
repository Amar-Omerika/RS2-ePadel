

import 'package:epadel_admin/models/feedback.dart';
import 'package:epadel_admin/providers/providers.dart';

class FeedbackProvider extends BaseProvider<Feedback> {
  FeedbackProvider() : super("Feedback");

  @override
  Feedback fromJson(data) {
    return Feedback.fromJson(data);
  }
}