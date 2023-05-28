import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:testing_app/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:testing_app/auth/sign_up/bloc/sign_up_bloc.dart';

import 'mock_auth_service.dart';

void main() {
  group('Login', () {
    late SignInBloc signInBloc;
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
      signInBloc = SignInBloc(mockAuthService);
    });

    blocTest<SignInBloc, SignInState>(
      'emits [SignInUpdated] when SignInTextChanged is added.',
      build: () => SignInBloc(mockAuthService),
      act: (bloc) => signInBloc
          .add(const SignInTextChanged(key: 'email', value: '123456')),
      expect: () => const <SignInState>[
        SignInUpdated(textFields: {
          'email': 'Неверный формат email',
        })
      ],
    );
    blocTest<SignInBloc, SignInState>(
      'emits [SignInUpdated] when SignInTextChanged is added.',
      build: () => SignInBloc(mockAuthService),
      act: (bloc) =>
          signInBloc.add(const SignInTextChanged(key: 'password', value: '12')),
      expect: () => const <SignInState>[
        SignInUpdated(textFields: {
          'password': 'Минимум символов - 4',
        })
      ],
    );

    blocTest<SignInBloc, SignInState>(
      'emits [SignInUpdated, SignInSuccessLogin] when SignInButtonPressed is added.',
      setUp: () {
        mockAuthService.getLoginResultsSuccess();
      },
      build: () => SignInBloc(mockAuthService),
      act: (bloc) => signInBloc.add(const SignInButtonPressed(textFields: {})),
      expect: () => const <SignInState>[
        SignInUpdated(textFields: {
          'email': '',
          'password': '',
        }),
        SignInSuccessLogin(textFields: {
          'email': '',
          'password': '',
        }),
      ],
    );

    blocTest<SignInBloc, SignInState>(
      'emits [SignInUpdated, SignInError] when SignInButtonPressed is added.',
      setUp: () {
        mockAuthService.getLoginResultsFailure();
      },
      build: () => SignInBloc(mockAuthService),
      act: (bloc) => signInBloc.add(const SignInButtonPressed(textFields: {})),
      expect: () => const <SignInState>[
        SignInUpdated(textFields: {
          'email': '',
          'password': '',
        }),
        SignInError(textFields: {
          'email': '',
          'password': '',
        }, message: 'empty token'),
      ],
    );

    tearDown(() {
      signInBloc.close();
    });
  });

  group('Registration', () {
    late SignUpBloc signUpBloc;
    late MockAuthService mockAuthService;

    setUp(() {
      mockAuthService = MockAuthService();
      signUpBloc = SignUpBloc(mockAuthService);
    });

    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpUpdated] when SignUpTextChanged is added.',
      build: () => SignUpBloc(mockAuthService),
      act: (bloc) =>
          signUpBloc.add(const SignUpTextChanged(key: 'fio', value: '1')),
      expect: () => const <SignUpState>[
        SignUpUpdated(textFields: {
          'fio': 'Минимум символов - 2',
        })
      ],
    );
    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpUpdated] when SignUpTextChanged is added.',
      build: () => SignUpBloc(mockAuthService),
      act: (bloc) => signUpBloc
          .add(const SignUpTextChanged(key: 'email', value: '123456')),
      expect: () => const <SignUpState>[
        SignUpUpdated(textFields: {
          'email': 'Неверный формат email',
        })
      ],
    );
    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpUpdated] when SignUpTextChanged is added.',
      build: () => SignUpBloc(mockAuthService),
      act: (bloc) =>
          signUpBloc.add(const SignUpTextChanged(key: 'password', value: '12')),
      expect: () => const <SignUpState>[
        SignUpUpdated(textFields: {
          'password': 'Минимум символов - 4',
        })
      ],
    );
    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpUpdated] when SignUpTextChanged is added.',
      build: () => SignUpBloc(mockAuthService),
      act: (bloc) =>
          signUpBloc.add(const SignUpTextChanged(key: 'repeatedPassword', value: '22')),
      expect: () => const <SignUpState>[
        SignUpUpdated(textFields: {
          'password': 'Пароли не совпадают',
        })
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpUpdated, SignUpSuccessLogin] when SignUpButtonPressed is added.',
      setUp: () {
        mockAuthService.getRegisterResultsSuccess();
      },
      build: () => SignUpBloc(mockAuthService),
      act: (bloc) => signUpBloc.add(const SignUpButtonPressed(textFields: {})),
      expect: () => const <SignUpState>[
        SignUpUpdated(textFields: {
          'fio': '',
          'email': '',
          'password': '',
          'repeatedPassword': '',
        }),
        SignUpSuccessedRegister(textFields: {
          'fio': '',
          'email': '',
          'password': '',
          'repeatedPassword': '',
        }),
      ],
    );

    blocTest<SignUpBloc, SignUpState>(
      'emits [SignUpUpdated, SignUpError] when SignUpButtonPressed is added.',
      setUp: () {
        mockAuthService.getRegisterResultsFailure();
      },
      build: () => SignUpBloc(mockAuthService),
      act: (bloc) => signUpBloc.add(const SignUpButtonPressed(textFields: {})),
      expect: () => const <SignUpState>[
        SignUpUpdated(textFields: {
          'fio': '',
          'email': '',
          'password': '',
          'repeatedPassword': '',
        }),
        SignUpError(textFields: {
          'fio': '',
          'email': '',
          'password': '',
          'repeatedPassword': '',
        }, message: 'empty token'),
      ],
    );

    tearDown(() {
      signUpBloc.close();
    });
  });
}
