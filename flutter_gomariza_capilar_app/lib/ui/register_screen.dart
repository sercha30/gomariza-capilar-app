import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/auth_repository/auth_repository.dart';
import 'package:flutter_gomariza_capilar_app/styles.dart';

import '../blocs/image_pick_bloc/image_pick_bloc.dart';
import '../blocs/register_bloc/register_bloc.dart';
import '../resources/repositories/auth_repository/auth_repository_impl.dart';
import 'login_screen.dart';

typedef OnPickImageCallback = void Function(
    double? maxWidth, double? maxHeight, int? quality);

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late AuthRepository authRepository;

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController birthdateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    authRepository = AuthRepositoryImpl();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return RegisterBloc(authRepository);
        }),
        BlocProvider(create: (context) {
          return ImagePickBlocBloc();
        })
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _createBody(context),
      ),
    );
  }

  Widget _createBody(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).padding,
      child: Center(
        child: Padding(
            padding: const EdgeInsets.all(CustomStyles.bodyPadding),
            child: BlocConsumer<RegisterBloc, RegisterState>(
              listenWhen: (context, state) {
                return state is RegisterSuccessState ||
                    state is RegisterErrorState;
              },
              listener: (context, state) {
                if (state is RegisterSuccessState) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                } else if (state is RegisterErrorState) {
                  _showSnackbar(context, state.message);
                }
              },
              buildWhen: (context, state) {
                return state is RegisterInitialState ||
                    state is RegisterLoadingState;
              },
              builder: (context, state) {
                if (state is RegisterInitialState) {
                  return _buildForm(context);
                } else if (state is RegisterLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return _buildForm(context);
                }
              },
            )),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/logo_con_texto.png',
            width: 175,
          ),
          SizedBox(
            width: 260,
            child: Text(
              'Regístrate para poder gestionar tus citas y datos con nosotros fácilmente, además de acceder a promociones exclusivas',
              style: CustomStyles.subTitleText,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: CustomStyles.formBoxColor),
            padding: const EdgeInsets.symmetric(
                horizontal: CustomStyles.contentPadding, vertical: 50.0),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.all(CustomStyles.inputPadding),
                          hintText: 'Nombre',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 10.0),
                              borderRadius: BorderRadius.circular(25.0))),
                      onSaved: (String? value) {},
                      validator: (String? value) {
                        return (value == null || value.isEmpty)
                            ? 'Debe introducir su nombre'
                            : null;
                      },
                    ),
                    TextFormField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.all(CustomStyles.inputPadding),
                          hintText: 'Apellidos',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 10.0),
                              borderRadius: BorderRadius.circular(25.0))),
                      onSaved: (String? value) {},
                      validator: (String? value) {
                        return (value == null || value.isEmpty)
                            ? 'Debe introducir sus apellidos'
                            : null;
                      },
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.all(CustomStyles.inputPadding),
                          hintText: 'Email',
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
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.all(CustomStyles.inputPadding),
                          hintText: 'Contraseña',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 10.0),
                              borderRadius: BorderRadius.circular(25.0))),
                      onSaved: (String? value) {},
                      validator: (String? value) {
                        return (value == null || value.isEmpty)
                            ? 'Debe introducir una contraseña'
                            : null;
                      },
                    ),
                    TextFormField(
                      controller: password2Controller,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.all(CustomStyles.inputPadding),
                          hintText: 'Repita su contraseña',
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 10.0),
                              borderRadius: BorderRadius.circular(25.0))),
                      onSaved: (String? value) {},
                      validator: (String? value) {
                        return (value == null ||
                                value.isEmpty ||
                                value != passwordController.text)
                            ? 'Las contraseñas no coinciden'
                            : null;
                      },
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
