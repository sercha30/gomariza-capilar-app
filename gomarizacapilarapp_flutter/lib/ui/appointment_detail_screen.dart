import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gomariza_capilar_app/blocs/appointment_delete_bloc.dart/appointment_delete_bloc.dart';
import 'package:flutter_gomariza_capilar_app/blocs/appointment_detail_bloc/appointment_detail_bloc.dart';
import 'package:flutter_gomariza_capilar_app/models/appointment/appointment_detail_response.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/appointment_repository/appointment_repository.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/appointment_repository/appointment_repository_impl.dart';
import 'package:flutter_gomariza_capilar_app/styles.dart';
import 'package:flutter_gomariza_capilar_app/ui/appointments_screen.dart';
import 'package:flutter_gomariza_capilar_app/utils/preferences/preferences_utils.dart';
import 'package:intl/intl.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/utf_8_decoder/utf_8_decoder.dart';

class AppointmentDetailScreen extends StatefulWidget {
  const AppointmentDetailScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentDetailScreen> createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  late AppointmentRepository appointmentRepository;

  @override
  void initState() {
    super.initState();
    appointmentRepository = AppointmentRepositoryImpl();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final idAppointment = ModalRoute.of(context)!.settings.arguments as String;
    PreferenceUtils.setString('idAppointment', idAppointment);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return AppointmentDetailBloc(appointmentRepository)
            ..add(GetAppointmentDetailEvent(idAppointment));
        }),
      ],
      child: Scaffold(
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
        child: BlocConsumer<AppointmentDetailBloc, AppointmentDetailState>(
          listenWhen: (context, state) {
            return state is AppointmentDetailSuccessState ||
                state is AppointmentDetailErrorState;
          },
          listener: (context, state) {
            if (state is AppointmentDetailSuccessState) {
              return;
            }
          },
          buildWhen: (context, state) {
            return state is AppointmentDetailSuccessState ||
                state is AppointmentDetailLoadingState;
          },
          builder: (context, state) {
            if (state is AppointmentDetailInitState ||
                state is AppointmentDetailLoadingState) {
              return Center(
                  child: SizedBox(
                      width: 100,
                      height: 100,
                      child: HeartbeatProgressIndicator(
                          child: Image.asset(
                              'assets/images/logo_sin_texto.png'))));
            } else if (state is AppointmentDetailSuccessState) {
              return _buildScreen(context, state.appointmentDetailResponse);
            }
            return const Text('Ha ocurrido un error inesperado');
          },
        ),
      )),
    );
  }

  Widget _buildScreen(
      BuildContext context, AppointmentDetailResponse appointment) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topLeft,
            child: const CloseButton(
              color: CustomStyles.primaryColor,
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 630.0,
                width: 350.0,
                decoration: BoxDecoration(
                    color: CustomStyles.formBoxColor,
                    borderRadius: BorderRadius.circular(25.0)),
              ),
              Container(
                height: 600.0,
                width: 325.0,
                decoration: BoxDecoration(
                    color: CustomStyles.primaryColorSemiTransparent,
                    borderRadius: BorderRadius.circular(25.0)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.event_available,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(
                                Utf8Decoder.utf8Decode(
                                    appointment.nombreServicio),
                                style: CustomStyles.detailText),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.schedule,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              children: [
                                Text(
                                    _dateTimeFormatter(DateTime.parse(
                                            appointment.de[0].toString() +
                                                "-" +
                                                "0" +
                                                appointment.de[1].toString() +
                                                "-" +
                                                appointment.de[2].toString()))
                                        .toString(),
                                    style: CustomStyles.detailText),
                                Text(
                                    appointment.de[3].toString() +
                                        ":" +
                                        appointment.de[4].toString() +
                                        " - " +
                                        appointment.a[3].toString() +
                                        ":" +
                                        appointment.a[4].toString() +
                                        "0",
                                    style: CustomStyles.detailText)
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          Container(
                              margin: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Dr. " + appointment.apellidosProfesional,
                                style: CustomStyles.detailText,
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.pin_drop,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 10.0),
                              child: Text(
                                "Localización",
                                style: CustomStyles.detailText,
                              )),
                          InkWell(
                            onTap: () {
                              openMap(appointment.lat, appointment.lng);
                            },
                            child: Image.asset(
                              'assets/images/google_maps_icon.png',
                              width: 60.0,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 150.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 15),
                                  decoration: BoxDecoration(
                                      color: CustomStyles.editButtonColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    'Modificar cita'.toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text('Advertencia'),
                                          content: const Text(
                                              'Va a proceder a cancelar su cita. ¿Está seguro/a?'),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Cancelar')),
                                            ElevatedButton(

                                                /*Navigator.of(context)
                                                    .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      BlocConsumer<
                                                          AppointmentDeleteBloc,
                                                          AppointmentDeleteState>(
                                                    listenWhen:
                                                        (context, state) {
                                                      return state
                                                              is AppointmentDeleteSuccessState ||
                                                          state
                                                              is AppointmentDeleteErrorState;
                                                    },
                                                    listener:
                                                        (context, state) {
                                                      if (state
                                                          is AppointmentDeleteSuccessState) {
                                                        return;
                                                      }
                                                    },
                                                    buildWhen:
                                                        (context, state) {
                                                      return state
                                                              is AppointmentDeleteSuccessState ||
                                                          state
                                                              is AppointmentDeleteLoadingState;
                                                    },
                                                    builder:
                                                        (context, state) {
                                                      if (state
                                                              is AppointmentDeleteInitialState ||
                                                          state
                                                              is AppointmentDeleteLoadingState) {
                                                        return Center(
                                                            child: Stack(
                                                          children: [
                                                            Container(
                                                              width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width,
                                                              height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height,
                                                              color: CustomStyles
                                                                  .blackSemiTransparent,
                                                            ),
                                                            SizedBox(
                                                                width: 100,
                                                                height: 100,
                                                                child: HeartbeatProgressIndicator(
                                                                    child: Image.asset(
                                                                        'assets/images/logo_sin_texto.png')))
                                                          ],
                                                        ));
                                                      } else if (state
                                                          is AppointmentDeleteSuccessState) {
                                                        if (state
                                                            .appointmentDeleteResponse) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const AppointmentsScreen()));
                                                        }
                                                      }
                                                      return const Text(
                                                          'Ha ocurrido un error inesperado');
                                                    },
                                                  ),
                                                )),*/
                                                onPressed: () {},
                                                child: const Text('OK'))
                                          ],
                                        ));
                              },
                              child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 15),
                                  decoration: BoxDecoration(
                                      color: CustomStyles.deleteButtonColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    'Cancelar cita'.toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  )),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  String _dateTimeFormatter(DateTime dateTime) {
    return DateFormat('EEEE, d MMM', 'es_ES').format(dateTime);
  }

  static Future<void> openMap(String lat, String lng) async {
    double latitude = double.parse(lat);
    double longitude = double.parse(lng);

    String googleUrl =
        "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl));
    } else {
      throw 'No es posible abrir la localización';
    }
  }
}
