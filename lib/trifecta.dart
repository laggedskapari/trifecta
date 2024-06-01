import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/bloc/SignInBloc/sign_in_bloc.dart';
import 'package:trifecta/bloc/TrifectaAuthenticationBloc/trifecta_authentication_bloc.dart';
import 'package:trifecta/presentation/color_scheme/trifecta_dark.dart';
import 'package:trifecta/presentation/screens/authenticated/authenticated_screen.dart';
import 'package:trifecta/presentation/screens/authentication/authentication_screen.dart';
import 'package:trifecta_authentication/trifecta_authentication_repository.dart';

class Trifecta extends StatelessWidget {
  const Trifecta({
    super.key,
    required this.trifectaAuthenticationRepository,
  });

  final TrifectaAuthenticationRepository trifectaAuthenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => TrifectaAuthenticationBloc(
            trifectaAuthenticationRepository: trifectaAuthenticationRepository,
          ),
        ),
      ],
      child: MaterialApp(
        theme: trifectaDark,
        home: BlocBuilder<TrifectaAuthenticationBloc,
            TrifectaAuthenticationState>(
          builder: (context, state) {
            if (state.status == TrifectaAuthenticationStatus.authenticated) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider<SignInBloc>(
                    create: (context) => SignInBloc(
                      trifectaAuthenticationRepository: context
                          .read<TrifectaAuthenticationBloc>()
                          .trifectaAuthenticationRepository,
                    ),
                  ),
                ],
                child: const AuthenticatedScreen(),
              );
            }
            return const AuthenticationScreen();
          },
        ),
      ),
    );
  }
}
