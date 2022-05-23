import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/auth_repository/auth_repository.dart';
import 'package:flutter_gomariza_capilar_app/styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../blocs/image_pick_bloc/image_pick_bloc.dart';
import '../blocs/register_bloc/register_bloc.dart';
import '../models/auth/register/register_dto.dart';
import '../resources/repositories/auth_repository/auth_repository_impl.dart';
import '../utils/constants/constants.dart';
import '../utils/preferences/preferences_utils.dart';
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
        resizeToAvoidBottomInset: true,
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
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topLeft,
            child: const BackButton(
              color: CustomStyles.primaryColor,
            ),
          ),
          Image.asset(
            'assets/images/logo_con_texto.png',
            width: 175,
          ),
          Container(
            margin: const EdgeInsets.only(top: 5.0, bottom: 25.0),
            child: SizedBox(
              width: 300,
              child: Text(
                'Regístrate para poder gestionar tus citas y datos con nosotros fácilmente, además de acceder a promociones exclusivas',
                style: CustomStyles.subTitleText,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            height: 700,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: CustomStyles.formBoxColor),
            padding: const EdgeInsets.symmetric(
                horizontal: CustomStyles.contentPadding),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    BlocConsumer<ImagePickBlocBloc, ImagePickBlocState>(
                      listenWhen: (context, state) {
                        return state is ImageSelectedSuccessState;
                      },
                      listener: (context, state) {},
                      buildWhen: (context, state) {
                        return state is ImagePickBlocInitial ||
                            state is ImageSelectedSuccessState;
                      },
                      builder: (context, state) {
                        if (state is ImageSelectedSuccessState) {
                          PreferenceUtils.setString(Constants.AVATAR_IMAGE_PATH,
                              state.pickedFile.path);
                          return Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.file(
                                  File(state.pickedFile.path),
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          );
                        }
                        return Center(
                          child: Stack(children: [
                            InkWell(
                              onTap: () {
                                BlocProvider.of<ImagePickBlocBloc>(context).add(
                                    const SelectImageEvent(
                                        ImageSource.gallery));
                              },
                              child: Image.asset(
                                'assets/images/mock-avatar.png',
                                width: 150,
                              ),
                            ),
                          ]),
                        );
                      },
                    ),
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
                      obscureText: true,
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
                      obscureText: true,
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
                        return (value == null || value.isEmpty)
                            ? 'Las contraseñas no coinciden'
                            : null;
                      },
                    ),
                    TextFormField(
                        controller: birthdateController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding:
                                const EdgeInsets.all(CustomStyles.inputPadding),
                            hintText: 'Fecha de nacimiento',
                            suffixIcon: const Icon(
                              Icons.calendar_month,
                              color: CustomStyles.primaryColor,
                            ),
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black, width: 10.0),
                                borderRadius: BorderRadius.circular(25.0))),
                        onTap: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime(DateTime.now().year - 18),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now());
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy').format(pickedDate);
                            setState(() {
                              birthdateController.text = formattedDate;
                            });
                          }
                        }),
                    GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          final registerDto = RegisterDto(
                              nombre: nameController.text,
                              apellidos: lastNameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              password2: password2Controller.text,
                              fechaNacimiento: birthdateController.text);
                          BlocProvider.of<RegisterBloc>(context).add(
                              DoRegisterEvent(
                                  registerDto,
                                  PreferenceUtils.getString(
                                      Constants.AVATAR_IMAGE_PATH)!));
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
                            'Registrarse'.toUpperCase(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
