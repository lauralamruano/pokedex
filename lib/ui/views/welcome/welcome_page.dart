import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import 'package:pokedex/core/error/validations.dart';
import 'package:pokedex/core/platform/shared_prefs.dart';
import 'package:pokedex/di/injector.dart';
import 'package:pokedex/l10n/l10n.dart';
import 'package:pokedex/ui/bloc/welcome/welcome_bloc.dart';
import 'package:pokedex/ui/views/pokemon_list/pokemon_list_page.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeBloc(
        Injector.instance!.getDependency(),
      ),
      child: const _WelcomeView(),
    );
  }
}

class _WelcomeView extends StatefulWidget {
  const _WelcomeView({super.key});

  @override
  State<_WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<_WelcomeView> {
  String? savedName;

  final _nameFocusNode = FocusNode();

  void navigateToListPage(){
    Navigator.pushAndRemoveUntil(context, PokemonListPage.route(), (route) => false);
  }

 Future <void> _loadSavedName() async {
   final sharedPrefrs = SharedPreferencesManagerImpl();
   final name = await sharedPrefrs.getUserName();
   await Future<void>.delayed(const Duration(milliseconds: 1500), () {
     setState(() {
       savedName = name;
     });
     if (name != '') {
       navigateToListPage();
     }
   });
 }
  @override
  void initState() {
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        context.read<WelcomeBloc>().add(WelcomeNameUnfocused());
      }
    });
    _loadSavedName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 32,
          ),
          child: Column(
            children: [
              Image.asset(
                'assets/images/pokeball-96.png',
                width: 96,
                height: 96,
              ),
              const SizedBox(
                width: double.infinity,
                height: 36,
              ),
              Text(
                l10n.hi,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                l10n.welcome,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 54,
              ),
              if (savedName == '')
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.background,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.enterYourName,
                        style: Theme.of(context).textTheme.titleMedium,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 16),
                      BlocBuilder<WelcomeBloc, WelcomeState>(
                        builder: (context, state) {
                          return TextFormField(
                            focusNode: _nameFocusNode,
                            decoration: InputDecoration(
                              labelText: l10n.name,
                              errorText: !state.name.isPure &&
                                      state.name.isNotValid
                                  ? state.name.error == ValidationErrors.empty
                                      ? l10n.nameEmptyError
                                      : l10n.nameInvalidError
                                  : null,
                            ),
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (value) {},
                            onChanged: (value) {
                              context
                                  .read<WelcomeBloc>()
                                  .add(WelcomeNameChanged(name: value));
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 36),
                      SizedBox(
                        width: double.infinity,
                        child: BlocConsumer<WelcomeBloc, WelcomeState>(
                          listener: (context, state) {
                            if (state.formStatus ==
                                FormzSubmissionStatus.success) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                PokemonListPage.route(),
                                (route) => false,
                              );
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state.formStatus ==
                                      FormzSubmissionStatus.inProgress
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();
                                      context
                                          .read<WelcomeBloc>()
                                          .add(WelcomeFormSubmitted());
                                    },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(l10n.next),
                                  if (state.formStatus ==
                                      FormzSubmissionStatus.inProgress)
                                    Container(
                                      margin: const EdgeInsets.only(left: 16),
                                      height: 16,
                                      width: 16,
                                      child: const CircularProgressIndicator(
                                          strokeWidth: 2),
                                    )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              else
                const SizedBox(
                  width: 32,
                  height: 32,
                  child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                )
            ],
          ),
        ),
      ),
    );
  }
}
