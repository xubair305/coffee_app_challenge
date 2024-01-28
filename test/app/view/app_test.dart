import 'package:coffee_challenge/app/app.dart';
import 'package:coffee_challenge/presentation/dashboard/view/dashboard_page.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(DashboardPage), findsOneWidget);
    });
  });
}
