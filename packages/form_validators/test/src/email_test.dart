// ignore_for_file: prefer_const_constructors
import 'package:form_validators/form_validators.dart';
import 'package:test/test.dart';

void main() {
  const emailString = 'test@email.com';
  group('Email', () {
    group('constructors', () {
      test('pure creates correct instance', () {
        final email = Email.pure();
        expect(email.value, '');
        expect(email.pure, true);
      });

      test('dirty creates correct instance', () {
        final email = Email.dirty(emailString);
        expect(email.value, emailString);
        expect(email.pure, false);
      });
    });

    group('validator', () {
      test('returns empty error when email is empty', () {
        expect(
          Email.dirty().error,
          EmailValidationError.empty,
        );
      });

      test('returns invalid error when email is malformed', () {
        expect(
          Email.dirty('test').error,
          EmailValidationError.invalid,
        );
      });

      test('is valid when email is valid', () {
        expect(
          Email.dirty(emailString).error,
          isNull,
        );
      });
    });
  });
}
