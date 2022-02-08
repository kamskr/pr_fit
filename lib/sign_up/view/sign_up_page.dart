import 'package:app_ui/app_ui.dart';
import 'package:authentication_client/authentication_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:prfit/l10n/l10n.dart';
import 'package:prfit/sign_up/sign_up.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static Route route() =>
      MaterialPageRoute<void>(builder: (_) => const SignUpPage());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(context.read<AuthenticationClient>()),
      child: const SignUpView(),
    );
  }
}

class SignUpView extends StatelessWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SignUpBlocListener(
      child: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient3,
        ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(
                color: AppColors.white, //change your color here
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _SignUpTitle(),
                    _UsernameInput(),
                    _EmailInput(),
                    _PasswordInput(),
                    _LegalNote(),
                    _SignUpButton(),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}

class _SignUpBlocListener extends StatelessWidget {
  const _SignUpBlocListener({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          Navigator.pop(context);
        }
      },
      child: child,
    );
  }
}

class _SignUpTitle extends StatelessWidget {
  const _SignUpTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      child: Text(
        l10n.signUpPageTitle,
        style: AppTypography.headline3.copyWith(color: AppColors.white),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  const _UsernameInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final username = context.select((SignUpBloc bloc) => bloc.state.username);

    return Padding(
      padding: const EdgeInsets.only(
        right: AppSpacing.xlg,
      ),
      child: AppTextField(
        labelText: l10n.signUpPageUsernameLabel,
        errorText:
            username.invalid ? l10n.signUpPageUsernameErrorMessage : null,
        onChanged: (newValue) {
          context.read<SignUpBloc>().add(SignUpUsernameChanged(newValue));
        },
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final email = context.select((SignUpBloc bloc) => bloc.state.email);

    return Padding(
      padding: const EdgeInsets.only(
        right: AppSpacing.xlg,
      ),
      child: AppTextField(
        labelText: l10n.signUpPageEmailLabel,
        inputType: AppTextFieldType.email,
        errorText: email.invalid ? l10n.signUpPageEmailErrorMessage : null,
        onChanged: (newValue) {
          context.read<SignUpBloc>().add(SignUpEmailChanged(newValue));
        },
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final password = context.select((SignUpBloc bloc) => bloc.state.password);

    return Padding(
      padding: const EdgeInsets.only(
        right: AppSpacing.xlg,
      ),
      child: AppTextField(
        labelText: l10n.signUpPagePasswordLabel,
        inputType: AppTextFieldType.password,
        errorText:
            password.invalid ? l10n.signUpPagePasswordErrorMessage : null,
        onChanged: (newValue) {
          context.read<SignUpBloc>().add(SignUpPasswordChanged(newValue));
        },
      ),
    );
  }
}

class _LegalNote extends StatelessWidget {
  const _LegalNote({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Text(
        l10n.signUpPageLegal,
        style: AppTypography.overline.copyWith(
          color: AppColors.white.withOpacity(0.8),
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxlg),
      child: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          return AppButton.gradient(
            onPressed: () {
              context.read<SignUpBloc>().add(SignUpCredentialsSubmitted());
            },
            isLoading: state.status == FormzStatus.submissionInProgress,
            child: Text(l10n.signUpPageSignUpButton),
          );
        },
      ),
    );
  }
}
