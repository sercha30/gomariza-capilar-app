import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gomariza_capilar_app/blocs/login_bloc/login_bloc.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/auth_repository/auth_repository.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/auth_repository/auth_repository_impl.dart';
import 'package:flutter_gomariza_capilar_app/styles.dart';
import 'package:flutter_gomariza_capilar_app/utils/constants/constants.dart';
import 'package:flutter_gomariza_capilar_app/utils/preferences/preferences_utils.dart';
import 'package:local_auth/local_auth.dart';

import '../models/auth/login/login_dto.dart';
import 'menu_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthRepository authRepository;

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  late LocalAuthentication _localAuthentication;
  bool _isBiometricAvailable = false;

  @override
  void initState() {
    super.initState();
    authRepository = AuthRepositoryImpl();
    _localAuthentication = LocalAuthentication();
    _localAuthentication.isDeviceSupported().then((a) => {
          _localAuthentication.canCheckBiometrics.then((b) {
            if (a && b) {
              setState(() {
                _isBiometricAvailable = true;
              });
            }
          })
        });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return LoginBloc(authRepository);
        },
        //onWillPop seteado a false permite que el usuario no pueda volver a la pantalla
        //de splash con el botón retroceder del móvil
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: _createBody(context),
          ),
        ));
  }

  Widget _createBody(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).padding,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(CustomStyles.bodyPadding),
          child: BlocConsumer<LoginBloc, LoginState>(
            listenWhen: (context, state) {
              return state is LoginSuccessState || state is LoginErrorState;
            },
            listener: (context, state) {
              if (state is LoginSuccessState) {
                PreferenceUtils.setString(
                    Constants.BEARER_TOKEN, state.loginResponse.token);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MenuScreen()));
              } else if (state is LoginErrorState) {
                _showSnackbar(context, state.message);
              }
            },
            buildWhen: (context, state) {
              return state is LoginInitialState || state is LoginLoadingState;
            },
            builder: (context, state) {
              if (state is LoginInitialState) {
                return _buildForm(context);
              } else if (state is LoginLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return _buildForm(context);
              }
            },
          ),
        ),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget _buildForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          'assets/images/logo_con_texto.png',
          width: 250,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: CustomStyles.formBoxColor),
          margin: const EdgeInsets.symmetric(
              horizontal: CustomStyles.contentMargin,
              vertical: CustomStyles.contentMargin + 25.0),
          padding: const EdgeInsets.symmetric(
              horizontal: CustomStyles.contentPadding, vertical: 50.0),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            const EdgeInsets.all(CustomStyles.inputPadding),
                        hintText: 'Introduzca su email',
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 10.0),
                            borderRadius: BorderRadius.circular(25.0))),
                    onSaved: (String? value) {},
                    validator: (String? value) {
                      return (value == null || !value.contains('@'))
                          ? 'El email introducido no es válido'
                          : null;
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20.0),
                    child: TextFormField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.all(CustomStyles.inputPadding),
                          suffixIcon: const Icon(
                            Icons.visibility,
                            color: CustomStyles.primaryColor,
                          ),
                          hintText: 'Introduzca su contraseña',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 10.0,
                              ),
                              borderRadius: BorderRadius.circular(20.0))),
                      onSaved: (String? value) {},
                      validator: (String? value) {
                        return (value == null || value.isEmpty)
                            ? 'Debe introducir la contraseña'
                            : null;
                      },
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 20.0, top: 10.0),
                    child: Text(
                      '¿Ha olvidado su contraseña?',
                      style: CustomStyles.linkText,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        final loginDto = LoginDto(
                            email: emailController.text,
                            password: passwordController.text);
                        BlocProvider.of<LoginBloc>(context)
                            .add(DoLoginEvent(loginDto));
                      }
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        decoration: BoxDecoration(
                            color: CustomStyles.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          'Entrar'.toUpperCase(),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        )),
                  )
                ],
              )),
        ),
        Container(
          padding:
              const EdgeInsets.symmetric(horizontal: CustomStyles.bodyPadding),
          child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              '¿Aún no tiene una cuenta?',
              style: CustomStyles.secondaryText,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10.0),
              child: InkWell(
                onTap: () => Navigator.pushNamed(context, '/register'),
                child: Text('Regístrese',
                    style: CustomStyles.linkText, textAlign: TextAlign.start),
              ),
            )
          ]),
        ),
        if (_isBiometricAvailable)
          Container(
            margin: const EdgeInsets.only(top: 25.0, bottom: 10.0),
            child: GestureDetector(
              onTap: () async {
                bool didAuthenticate = await _localAuthentication.authenticate(
                    localizedReason: "Iniciar sesión con huella",
                    options: const AuthenticationOptions(stickyAuth: true));
                if (didAuthenticate) {
                  final loginDto = LoginDto(
                      email: emailController.text,
                      password: passwordController.text);
                  BlocProvider.of<LoginBloc>(context)
                      .add(DoLoginEvent(loginDto));
                }
              },
              child: const Icon(
                Icons.fingerprint,
                color: CustomStyles.primaryColor,
                size: 100.0,
              ),
            ),
          ),
        if (_isBiometricAvailable)
          SizedBox(
            width: 190.0,
            child: Text(
              'Pulse aquí para acceder con su huella',
              style: CustomStyles.secondaryText,
              textAlign: TextAlign.center,
            ),
          )
      ]),
    );
  }
}
