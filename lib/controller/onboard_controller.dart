import 'package:komunoto/function/function_get.dart';

class OnboardController {
  List<dynamic> onboardData = [];

  Future<void> fetchOnboardData() async {
    try {
      onboardData = await getData();
      
    } catch (e) {
      print('Failed to fetch onboard data: $e');
    }
  }
}