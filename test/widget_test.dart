// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:f_testing_template/ui/pages/authentication/login.dart';
import 'package:f_testing_template/ui/pages/authentication/signup.dart';
import 'package:f_testing_template/ui/pages/content/detail.dart';
import 'package:f_testing_template/ui/pages/content/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Widget login validación @ email', (WidgetTester tester) async {
    final loginKey = Key("LoginScreen");

    await tester.pumpWidget(GetMaterialApp(
      home: LoginScreen(
        key: loginKey,
        email: "blank",
        password: "blank",
      ),
    ));

    // Confirmar que este uno
    expect(find.byKey(loginKey), findsOneWidget);

    // Ingresar los textos
    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginEmail")), "Correo");

    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginPassword")), "12345");

    // Submit
    await tester.tap(find.byKey(const Key("ButtonLoginSubmit")));

    // Recontruir
    await tester.pumpAndSettle();

    expect(find.text("Enter valid email address"), findsOneWidget);
  });

  testWidgets('Widget login validación campo vacio email',
      (WidgetTester tester) async {
    final loginKey = Key("LoginScreen");

    await tester.pumpWidget(GetMaterialApp(
      home: LoginScreen(
        key: loginKey,
        email: "blank",
        password: "blank",
      ),
    ));

    // Confirmar que este uno
    expect(find.byKey(loginKey), findsOneWidget);

    // Ingresar los textos
    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginEmail")), "");

    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginPassword")), "12345");

    // Submit
    await tester.tap(find.byKey(const Key("ButtonLoginSubmit")));

    // Recontruir
    await tester.pumpAndSettle();

    expect(find.text("Enter email"), findsOneWidget);
  });

  testWidgets('Widget login validación número de caracteres password',
      (WidgetTester tester) async {
    final loginKey = Key("LoginScreen");

    await tester.pumpWidget(GetMaterialApp(
      home: LoginScreen(
        key: loginKey,
        email: "blank",
        password: "blank",
      ),
    ));

    // Confirmar que este uno
    expect(find.byKey(loginKey), findsOneWidget);

    // Ingresar los textos
    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginEmail")), "email@domain.com");

    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginPassword")), "1");

    // Submit
    await tester.tap(find.byKey(const Key("ButtonLoginSubmit")));

    // Recontruir
    await tester.pumpAndSettle();

    expect(find.text("Password should have at least 6 characters"),
        findsOneWidget);
  });

  testWidgets('Widget login validación campo vacio password',
      (WidgetTester tester) async {
    final loginKey = Key("LoginScreen");

    await tester.pumpWidget(GetMaterialApp(
      home: LoginScreen(
        key: loginKey,
        email: "blank",
        password: "blank",
      ),
    ));

    // Confirmar que este uno
    expect(find.byKey(loginKey), findsOneWidget);

    // Ingresar los textos
    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginEmail")), "email@domain.com");

    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginPassword")), "");

    // Submit
    await tester.tap(find.byKey(const Key("ButtonLoginSubmit")));

    // Recontruir
    await tester.pumpAndSettle();

    expect(find.text("Enter password"), findsOneWidget);
  });

  testWidgets('Widget login autenticación exitosa',
      (WidgetTester tester) async {
    final loginKey = Key("LoginScreen");
    const email = "email@domain.tld";
    const password = "123456789";

    await tester.pumpWidget(GetMaterialApp(
      home: LoginScreen(
        key: loginKey,
        email: email,
        password: password,
      ),
    ));

    // Confirmar que este uno
    expect(find.byKey(loginKey), findsOneWidget);

    // Ingresar los textos
    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginEmail")), email);

    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginPassword")), password);

    // Submit
    await tester.tap(find.byKey(const Key("ButtonLoginSubmit")));

    // Recontruir
    await tester.pumpAndSettle();

    expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('Widget login autenticación no exitosa',
      (WidgetTester tester) async {
    final loginKey = Key("LoginScreen");

    await tester.pumpWidget(GetMaterialApp(
      home: LoginScreen(
        key: loginKey,
        email: "blank",
        password: "blank",
      ),
    ));

    // Confirmar que este uno
    expect(find.byKey(loginKey), findsOneWidget);

    // Ingresar los textos
    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginEmail")), "email@domain.com");

    await tester.enterText(
        find.byKey(const Key("TextFormFieldLoginPassword")), "123456789");

    // Submit
    await tester.tap(find.byKey(const Key("ButtonLoginSubmit")));

    // Recontruir
    await tester.pumpAndSettle();
    expect(find.byKey(loginKey), findsOneWidget);
    expect(find.text("User or passwor nok"), findsOneWidget);
  });

  testWidgets('Widget signUp validación @ email', (WidgetTester tester) async {
    final singupKey = Key("SingupScreen");

    await tester.pumpWidget(GetMaterialApp(
      home: SignUpPage(
        key: singupKey,
      ),
    ));

    // Confirmar que este uno
    expect(find.byKey(singupKey), findsOneWidget);

    // Ingresar los textos
    await tester.enterText(
        find.byKey(const Key("TextFormFieldSignUpEmail")), "Correo");

    await tester.enterText(
        find.byKey(const Key("TextFormFieldSignUpPassword")), "12345");

    // Submit
    await tester.tap(find.byKey(const Key("ButtonSignUpSubmit")));

    // Recontruir
    await tester.pumpAndSettle();

    expect(find.text("Enter valid email address"), findsOneWidget);
  });

  testWidgets('Widget signUp validación campo vacio email',
      (WidgetTester tester) async {
    final singupKey = Key("SingupScreen");

    await tester.pumpWidget(GetMaterialApp(
      home: SignUpPage(
        key: singupKey,
      ),
    ));

    // Confirmar que este uno
    expect(find.byKey(singupKey), findsOneWidget);

    // Ingresar los textos
    await tester.enterText(
        find.byKey(const Key("TextFormFieldSignUpEmail")), "");

    await tester.enterText(
        find.byKey(const Key("TextFormFieldSignUpPassword")), "12345");

    // Submit
    await tester.tap(find.byKey(const Key("ButtonSignUpSubmit")));

    // Recontruir
    await tester.pumpAndSettle();

    expect(find.text("Enter email"), findsOneWidget);
  });

  testWidgets('Widget signUp validación número de caracteres password',
      (WidgetTester tester) async {
    final singupKey = Key("SingupScreen");

    await tester.pumpWidget(GetMaterialApp(
      home: SignUpPage(
        key: singupKey,
      ),
    ));

    // Confirmar que este uno
    expect(find.byKey(singupKey), findsOneWidget);

    // Ingresar los textos
    await tester.enterText(
        find.byKey(const Key("TextFormFieldSignUpEmail")), "email@domain.tld");

    await tester.enterText(
        find.byKey(const Key("TextFormFieldSignUpPassword")), "1");

    // Submit
    await tester.tap(find.byKey(const Key("ButtonSignUpSubmit")));

    // Recontruir
    await tester.pumpAndSettle();

    expect(find.text("Password should have at least 6 characters"),
        findsOneWidget);
  });

  testWidgets('Widget signUp validación campo vacio password',
      (WidgetTester tester) async {
    final singupKey = Key("SingupScreen");

    await tester.pumpWidget(GetMaterialApp(
      home: SignUpPage(
        key: singupKey,
      ),
    ));

    // Confirmar que este uno
    expect(find.byKey(singupKey), findsOneWidget);

    // Ingresar los textos
    await tester.enterText(
        find.byKey(const Key("TextFormFieldSignUpEmail")), "email@domain.tld");

    await tester.enterText(
        find.byKey(const Key("TextFormFieldSignUpPassword")), "");

    // Submit
    await tester.tap(find.byKey(const Key("ButtonSignUpSubmit")));

    // Recontruir
    await tester.pumpAndSettle();

    expect(find.text("Enter password"), findsOneWidget);
  });

  testWidgets('Widget home visualización correo', (WidgetTester tester) async {
    final homeKey = Key("HomeScreen");
    const email = "email@domain.tld";
    const password = "123456789";

    await tester.pumpWidget(GetMaterialApp(
        home: HomePage(
            key: homeKey, loggedEmail: email, loggedPassword: password)));

    expect(find.byKey(homeKey), findsOneWidget);
    expect(find.text("Hello $email"), findsOneWidget);
  });

  testWidgets('Widget home nevegación detalle', (WidgetTester tester) async {
    final homeKey = Key("HomeScreen");
    const email = "email@domain.tld";
    const password = "123456789";

    await tester.pumpWidget(GetMaterialApp(
        home: HomePage(
            key: homeKey, loggedEmail: email, loggedPassword: password)));

    expect(find.byKey(homeKey), findsOneWidget);

    await tester.tap(find.byKey(const Key("ButtonHomeDetail")));

    // Recontruir
    await tester.pumpAndSettle();
    expect(find.byType(DetailPage), findsOneWidget);
  });

  testWidgets('Widget home logout', (WidgetTester tester) async {
    final homeKey = Key("HomeScreen");
    const email = "email@domain.tld";
    const password = "123456789";

    await tester.pumpWidget(GetMaterialApp(
        home: HomePage(
            key: homeKey, loggedEmail: email, loggedPassword: password)));

    expect(find.byKey(homeKey), findsOneWidget);

    await tester.tap(find.byKey(const Key("ButtonHomeLogOff")));
    // Recontruir
    await tester.pumpAndSettle();

    expect(find.byKey(homeKey), findsNothing);
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
