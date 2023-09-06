import 'package:f_testing_template/main.dart';
import 'package:f_testing_template/ui/pages/authentication/login.dart';
import 'package:f_testing_template/ui/pages/authentication/signup.dart';
import 'package:f_testing_template/ui/pages/content/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  Future<Widget> createHomeScreen() async {
    WidgetsFlutterBinding.ensureInitialized();
    return const MyApp();
  }

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("Login sin creación de usuario", (WidgetTester tester) async {
    Widget w = await createHomeScreen();
    await tester.pumpWidget(w);
  });

  testWidgets("Login -> signup -> creación usuario -> login no exitoso",
      (WidgetTester tester) async {
    // LOGIN
    final loginKey = Key("LoginScreen");
    const email = "email@domain.tld";
    const password = "123456";

    await tester.pumpWidget(GetMaterialApp(
      home: LoginScreen(
        key: loginKey,
        email: "blank",
        password: "blank",
      ),
    ));

    expect(find.byType(LoginScreen), findsOneWidget);

    await tester.tap(find.byKey(const Key("ButtonLoginCreateAccount")));

    await tester.pumpAndSettle();

    // SINGUP
    expect(find.byType(SignUpPage), findsOneWidget);

    await tester.enterText(
        find.byKey(const Key("TextFormFieldSignUpEmail")), email);

    await tester.enterText(
        find.byKey(const Key("TextFormFieldSignUpPassword")), password);

    await tester.tap(find.byKey(const Key("ButtonSignUpSubmit")));

    await tester.pumpAndSettle();

    // LOGIN
    expect(find.byType(LoginScreen), findsOneWidget);

    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginEmail")), "bademail$email");

    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginPassword")), password);

    await tester.tap(find.byKey(const Key("ButtonLoginSubmit")));

    // Falló
    await tester.pumpAndSettle();
    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.text("User or passwor nok"), findsOneWidget);
  });

  testWidgets("Login -> signup -> creación usuario -> login exitoso -> logout",
      (WidgetTester tester) async {
    // LOGIN
    final loginKey = Key("LoginScreen");
    const email = "email@domain.tld";
    const password = "123456";

    await tester.pumpWidget(GetMaterialApp(
      home: LoginScreen(
        key: loginKey,
        email: "blank",
        password: "blank",
      ),
    ));

    expect(find.byType(LoginScreen), findsOneWidget);

    await tester.tap(find.byKey(const Key("ButtonLoginCreateAccount")));

    await tester.pumpAndSettle();

    // SINGUP
    expect(find.byType(SignUpPage), findsOneWidget);

    await tester.enterText(
        find.byKey(const Key("TextFormFieldSignUpEmail")), email);

    await tester.enterText(
        find.byKey(const Key("TextFormFieldSignUpPassword")), password);

    await tester.tap(find.byKey(const Key("ButtonSignUpSubmit")));

    await tester.pumpAndSettle();

    // LOGIN
    expect(find.byType(LoginScreen), findsOneWidget);

    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginEmail")), email);

    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginPassword")), password);

    await tester.tap(find.byKey(const Key("ButtonLoginSubmit")));

    await tester.pumpAndSettle();

    // HOME -> LOGOUT
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text("Hello $email"), findsOneWidget);

    await tester.tap(find.byKey(const Key("ButtonHomeLogOff")));

    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsNothing);
    expect(find.byType(LoginScreen), findsWidgets);
  });

  testWidgets(
      "Login -> signup -> creación usuario -> login éxitoso -> logout -> login exitoso",
      (WidgetTester tester) async {
    // LOGIN
    final loginKey = Key("LoginScreen");
    const email = "email@domain.tld";
    const password = "123456";

    await tester.pumpWidget(GetMaterialApp(
      home: LoginScreen(
        key: loginKey,
        email: "blank",
        password: "blank",
      ),
    ));

    expect(find.byType(LoginScreen), findsOneWidget);

    await tester.tap(find.byKey(const Key("ButtonLoginCreateAccount")));

    await tester.pumpAndSettle();

    // SINGUP
    expect(find.byType(SignUpPage), findsOneWidget);

    await tester.enterText(
        find.byKey(const Key("TextFormFieldSignUpEmail")), email);

    await tester.enterText(
        find.byKey(const Key("TextFormFieldSignUpPassword")), password);

    await tester.tap(find.byKey(const Key("ButtonSignUpSubmit")));

    await tester.pumpAndSettle();

    // LOGIN
    expect(find.byType(LoginScreen), findsOneWidget);

    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginEmail")), email);

    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginPassword")), password);

    await tester.tap(find.byKey(const Key("ButtonLoginSubmit")));

    await tester.pumpAndSettle();

    // HOME -> LOGOUT
    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text("Hello $email"), findsOneWidget);

    await tester.tap(find.byKey(const Key("ButtonHomeLogOff")));

    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsNothing);
    expect(find.byType(LoginScreen), findsWidgets);

    // LOGIN

    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginEmail")), email);

    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginPassword")), password);

    await tester.tap(find.byKey(const Key("ButtonLoginSubmit")));

    await tester.pumpAndSettle();

    // HOME -> LOGOUT
    expect(find.byType(HomePage), findsWidgets);
    expect(find.text("Hello $email"), findsWidgets);
  });

  testWidgets(
      "Login -> signup -> creación usuario -> login éxitoso -> logout -> login no exitoso",
      (WidgetTester tester) async {});
}
