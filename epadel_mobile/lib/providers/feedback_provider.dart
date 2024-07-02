import 'package:epadel_mobile/models/models.dart';
import 'package:epadel_mobile/providers/base_provider.dart';

class FeedbackProvider extends BaseProvider<Feedback> {
  FeedbackProvider() : super("Feedback");

  @override
  Feedback fromJson(data) {
    return Feedback.fromJson(data);
  }
}
