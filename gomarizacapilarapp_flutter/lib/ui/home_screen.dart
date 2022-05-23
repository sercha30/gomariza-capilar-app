import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gomariza_capilar_app/blocs/get_next_appointments_bloc/get_next_appointments_bloc.dart';
import 'package:flutter_gomariza_capilar_app/blocs/home_bloc/home_bloc.dart';
import 'package:flutter_gomariza_capilar_app/blocs/me_bloc/me_bloc.dart';
import 'package:flutter_gomariza_capilar_app/blocs/service_list_bloc/service_list_bloc.dart';
import 'package:flutter_gomariza_capilar_app/models/appointment/appointment_list_response.dart';
import 'package:flutter_gomariza_capilar_app/models/auth/me/me_response.dart';
import 'package:flutter_gomariza_capilar_app/models/service/service_list_response.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/appointment_repository/appointment_repository.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/appointment_repository/appointment_repository_impl.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/auth_repository/auth_repository.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/auth_repository/auth_repository_impl.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/service_repository/service_repository.dart';
import 'package:flutter_gomariza_capilar_app/styles.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:time_machine/time_machine.dart';
import 'package:time_machine/time_machine_text_patterns.dart';

import '../resources/repositories/service_repository/service_repository_impl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AuthRepository authRepository;
  late AppointmentRepository appointmentRepository;
  late ServiceRepository serviceRepository;

  @override
  void initState() {
    super.initState();
    authRepository = AuthRepositoryImpl();
    appointmentRepository = AppointmentRepositoryImpl();
    serviceRepository = ServiceRepositoryImpl();
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
            return MeBloc(authRepository)..add(const GetLoggedUserEvent());
          }),
          BlocProvider(create: (context) {
            return GetNextAppointmentsBloc(appointmentRepository)
              ..add(const GetNext2AppointmentsEvent());
          }),
          BlocProvider(create: (context) {
            return ServiceListBloc(serviceRepository)
              ..add(const GetServiceListEvent());
          }),
          BlocProvider(create: (context) {
            return HomeBloc(
                appointmentRepository, authRepository, serviceRepository)
              ..add(const LoadHomeScreenEvent());
          })
        ],
        child: Scaffold(
          body: _createBody(context),
        ));
  }

  Widget _createBody(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).padding,
      child: Center(
          child: Padding(
        padding: const EdgeInsets.all(CustomStyles.bodyPadding),
        child: BlocConsumer<HomeBloc, HomeState>(
          listenWhen: (context, state) {
            return state is HomeSuccessState || state is HomeErrorState;
          },
          listener: (context, state) {
            if (state is HomeSuccessState) {
              return;
            }
          },
          buildWhen: (context, state) {
            return state is HomeSuccessState || state is HomeLoadingState;
          },
          builder: (context, state) {
            if (state is HomeInitialState || state is HomeLoadingState) {
              return Center(
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: HeartbeatProgressIndicator(
                          child: Image.asset(
                              'assets/images/logo_sin_texto.png'))));
            } else if (state is HomeSuccessState) {
              return _buildScreen(context, state.meResponse,
                  state.appointmentListResponse, state.serviceListResponse);
            }
            return const Text('Ha ocurrido un error inesperado');
          },
        ),
      )),
    );
  }

  Widget _buildScreen(
      BuildContext context,
      MeResponse meResponse,
      List<AppointmentListResponse> appointmentListResponse,
      List<ServiceListResponse> serviceListResponse) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hola, ',
                    style: CustomStyles.welcomeText,
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    meResponse.nombre + ' ' + meResponse.apellidos,
                    style: CustomStyles.welcomeText,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  meResponse.foto,
                  width: 75,
                  height: 75,
                  fit: BoxFit.fill,
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 50.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      left: 20.0, bottom: 10.0, top: 50.0),
                  child: Text(
                    'Próximas citas',
                    style: CustomStyles.linkText,
                    textAlign: TextAlign.start,
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 215,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: CustomStyles.backgroundColor),
                    ),
                    appointmentListResponse.isNotEmpty
                        ? Container(
                            height: 215,
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                      color: CustomStyles
                                          .primaryColorSemiTransparent,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          appointmentListResponse[0]
                                              .fotoProfesional,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Dr. ' +
                                                appointmentListResponse[0]
                                                    .apellidosProfesional,
                                            style: CustomStyles
                                                .descriptionTitleText,
                                          ),
                                          Text(
                                            appointmentListResponse[0]
                                                .nombreServicio,
                                            style: CustomStyles.descriptionText,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0,
                                                horizontal: 10.0),
                                            decoration: BoxDecoration(
                                                color: CustomStyles
                                                    .primaryColorSemiTransparent,
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Icon(
                                                  Icons.event_available,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5.0),
                                                  child: Text(
                                                    _dateTimeFormatter(DateTime.parse(appointmentListResponse[
                                                                    0]
                                                                .fechaCita[0]
                                                                .toString() +
                                                            "-" +
                                                            "0" +
                                                            appointmentListResponse[
                                                                    0]
                                                                .fechaCita[1]
                                                                .toString() +
                                                            "-" +
                                                            appointmentListResponse[
                                                                    0]
                                                                .fechaCita[2]
                                                                .toString()))
                                                        .toString(),
                                                    style: CustomStyles
                                                        .descriptionText,
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5.0),
                                                  child: const Icon(
                                                    Icons.watch_later_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                                Text(
                                                  LocalTime(
                                                              appointmentListResponse[
                                                                      0]
                                                                  .fechaCita[3],
                                                              appointmentListResponse[
                                                                      0]
                                                                  .fechaCita[4],
                                                              0)
                                                          .toString('HH:mm') +
                                                      ' - ' +
                                                      LocalTime(
                                                              appointmentListResponse[
                                                                      0]
                                                                  .fechaCita[3],
                                                              appointmentListResponse[
                                                                      0]
                                                                  .fechaCita[4],
                                                              0)
                                                          .addHours(
                                                              appointmentListResponse[
                                                                      0]
                                                                  .duracion[0])
                                                          .addMinutes(
                                                              appointmentListResponse[
                                                                      0]
                                                                  .duracion[1])
                                                          .toString('HH:mm'),
                                                  style: CustomStyles
                                                      .descriptionText,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  height: 80.0,
                                  decoration: BoxDecoration(
                                      color: CustomStyles
                                          .primaryColorSemiTransparent,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          appointmentListResponse[1]
                                              .fotoProfesional,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Dr. ' +
                                                appointmentListResponse[1]
                                                    .apellidosProfesional,
                                            style: CustomStyles
                                                .descriptionTitleText,
                                          ),
                                          Text(
                                            appointmentListResponse[1]
                                                .nombreServicio,
                                            style: CustomStyles.descriptionText,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5.0,
                                                horizontal: 10.0),
                                            decoration: BoxDecoration(
                                                color: CustomStyles
                                                    .primaryColorSemiTransparent,
                                                borderRadius:
                                                    BorderRadius.circular(25)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                const Icon(
                                                  Icons.event_available,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 5.0),
                                                  child: Text(
                                                    _dateTimeFormatter(DateTime.parse(appointmentListResponse[
                                                                    1]
                                                                .fechaCita[0]
                                                                .toString() +
                                                            "-" +
                                                            "0" +
                                                            appointmentListResponse[
                                                                    1]
                                                                .fechaCita[1]
                                                                .toString() +
                                                            "-" +
                                                            appointmentListResponse[
                                                                    1]
                                                                .fechaCita[2]
                                                                .toString()))
                                                        .toString(),
                                                    style: CustomStyles
                                                        .descriptionText,
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 5.0),
                                                  child: const Icon(
                                                    Icons.watch_later_outlined,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                                Text(
                                                  LocalTime(
                                                              appointmentListResponse[
                                                                      1]
                                                                  .fechaCita[3],
                                                              appointmentListResponse[
                                                                      1]
                                                                  .fechaCita[4],
                                                              0)
                                                          .toString('HH:mm') +
                                                      ' - ' +
                                                      LocalTime(
                                                              appointmentListResponse[
                                                                      1]
                                                                  .fechaCita[3],
                                                              appointmentListResponse[
                                                                      1]
                                                                  .fechaCita[4],
                                                              0)
                                                          .addHours(
                                                              appointmentListResponse[
                                                                      1]
                                                                  .duracion[0])
                                                          .addMinutes(
                                                              appointmentListResponse[
                                                                      1]
                                                                  .duracion[1])
                                                          .toString('HH:mm'),
                                                  style: CustomStyles
                                                      .descriptionText,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : Column(
                            children: [
                              Image.asset(
                                'assets/images/no_appointments-image-png',
                                width: 100,
                              ),
                              Text(
                                '¡Vaya! Parece que no tiene citas próximas',
                                style: CustomStyles.welcomeText,
                              )
                            ],
                          )
                  ],
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Servicios',
                style: CustomStyles.linkText,
              ),
            ],
          )
        ],
      ),
    );
  }

  String _dateTimeFormatter(DateTime dateTime) {
    initializeDateFormatting();
    return DateFormat('EEEE, d MMM', 'es_ES').format(dateTime);
  }
}
