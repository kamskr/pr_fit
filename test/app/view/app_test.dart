import 'package:authentication_client/authentication_client.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:prfit/app/app.dart';
import 'package:prfit/home/home.dart';
import 'package:prfit/welcome/welcome.dart';

import '../../helpers/helpers.dart';

// ignore: must_be_immutable
class MockUser extends Mock implements User {}

class MockAuthenticationClient extends Mock implements AuthenticationClient {}

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

void main() {
  group('App', () {
    late AuthenticationClient authenticationClient;
    setUp(() {
      authenticationClient = MockAuthenticationClient();

      when(() => authenticationClient.user).thenAnswer(
        (_) => Stream.value(User.empty),
      );
    });

    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(
        App(
          authenticationClient: authenticationClient,
        ),
      );
      await tester.pump();
      expect(find.byType(AppView), findsOneWidget);
    });
  });

  group('AppView', () {
    late AppBloc appBloc;
    const id = 'mock-id';
    const email = 'mock-email';

    setUp(() {
      appBloc = MockAppBloc();
    });

    testWidgets('navigates to WelcomeScreen when unauthenticated',
        (tester) async {
      when(() => appBloc.state).thenReturn(
        const AppState.unauthenticated(),
      );
      await tester.pumpApp(
        const AppView(),
        appBloc: appBloc,
      );
      await tester.pumpAndSettle();
      expect(find.byType(WelcomePage), findsOneWidget);
    });

    testWidgets('navigates to HomePage when authenticated', (tester) async {
      const user = User(email: email, id: id);
      when(() => appBloc.state).thenReturn(
        const AppState.authenticated(user),
      );
      await tester.pumpApp(
        const AppView(),
        appBloc: appBloc,
      );
      await tester.pumpAndSettle();
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
