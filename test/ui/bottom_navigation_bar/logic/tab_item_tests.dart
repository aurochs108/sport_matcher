import 'package:sport_matcher/ui/bottom_navigation_bar/logic/tab_item.dart';
import 'package:test/test.dart';

void main() {
  group("TabItem", () {
  
    // MARK: - tabIndex
  
    test('should return correct index for each TabItem', () {
      expect(TabItem.matcher.index, 0);
      expect(TabItem.profile.index, 1);
    });
  });
}