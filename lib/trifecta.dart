import 'package:cross/cross_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trifecta/bloc/Authentication/SignInBloc/sign_in_bloc.dart';
import 'package:trifecta/bloc/Authentication/TrifectaAuthenticationBloc/trifecta_authentication_bloc.dart';
import 'package:trifecta/bloc/Cross/TaskListBloc/tasklist_bloc.dart';
import 'package:trifecta/presentation/color_scheme/trifecta_dark.dart';
import 'package:trifecta/presentation/screens/authenticated/authenticated_screen.dart';
import 'package:trifecta/presentation/screens/authentication/authentication_screen.dart';
import 'package:trifecta_authentication/trifecta_authentication_repository.dart';

class Trifecta extends StatelessWidget {
  const Trifecta({
    super.key,
    required this.trifectaAuthenticationRepository,
    required this.crossTaskListRepository,
    required this.crossTaskRepository,
  });

  final TrifectaAuthenticationRepository trifectaAuthenticationRepository;
  final CrossTaskListRepository crossTaskListRepository;
  final CrossTaskRepository crossTaskRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => TrifectaAuthenticationBloc(
            trifectaAuthenticationRepository: trifectaAuthenticationRepository,
          ),
        ),
        RepositoryProvider(
          create: (context) => TaskListBloc(
            crossTaskListRepository: crossTaskListRepository,
          ),
        ),
        RepositoryProvider(
          create: (context) => crossTaskListRepository,
        ),
        RepositoryProvider(
          create: (context) => crossTaskRepository,
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
