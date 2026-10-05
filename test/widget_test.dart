import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shattably/components/components.dart';

void main() {
  testWidgets('Shared auth field validates empty input and accepts entered text',
      (tester) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);
    final key = GlobalKey<FormState>();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: Form(
        key: key,
        child: defaultFormField(
          controller: controller,
          type: TextInputType.emailAddress,
          validate: (value) => value == null || value.isEmpty ? 'Required' : null,
          label: 'Email',
          prefix: Icons.email,
        ),
      )),
    ));
    expect(key.currentState!.validate(), isFalse);
    await tester.pump();
    expect(find.text('Required'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'reader@example.invalid');
    expect(key.currentState!.validate(), isTrue);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();
    expect(tester.takeException(), isNull);
    expect(controller.text, 'reader@example.invalid');
  });

  testWidgets('Optional password visibility action does not crash when omitted',
      (tester) async {
    final controller = TextEditingController();
    addTearDown(controller.dispose);
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: defaultFormField(
      controller: controller,
      type: TextInputType.visiblePassword,
      validate: (_) => null,
      label: 'Password',
      prefix: Icons.lock,
      suffix: Icons.visibility,
      isPassword: true,
    ))));
    await tester.tap(find.byIcon(Icons.visibility));
    expect(tester.takeException(), isNull);
    expect(tester.widget<TextField>(find.byType(TextField)).obscureText, isTrue);
  });

}
