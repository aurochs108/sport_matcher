import 'package:flutter_test/flutter_test.dart';
import 'package:sport_matcher/data/profile/config/activities_config.dart';

void main() {
  group('ActivitiesConfig', () {
    for (final activity in ActivitiesConfig.values) {
      test('should return correct displayName for ${activity.name}', () {
        switch (activity) {
          case ActivitiesConfig.bike:
            expect(activity.displayName, 'Bike');
          case ActivitiesConfig.climbing:
            expect(activity.displayName, 'Climbing');
          case ActivitiesConfig.football:
            expect(activity.displayName, 'Football');
          case ActivitiesConfig.hockey:
            expect(activity.displayName, 'Hockey');
          case ActivitiesConfig.pingPong:
            expect(activity.displayName, 'Ping Pong');
          case ActivitiesConfig.running:
            expect(activity.displayName, 'Running');
          case ActivitiesConfig.tennis:
            expect(activity.displayName, 'Tennis');
          case ActivitiesConfig.voleyball:
            expect(activity.displayName, 'Voleyball');
        }
      });
    }
  });
}
