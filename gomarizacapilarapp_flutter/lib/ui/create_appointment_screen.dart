import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gomariza_capilar_app/blocs/appointment_create_bloc/appointment_create_bloc.dart';
import 'package:flutter_gomariza_capilar_app/blocs/check_calendar_bloc/check_calendar_bloc.dart';
import 'package:flutter_gomariza_capilar_app/blocs/service_list_bloc/service_list_bloc.dart';
import 'package:flutter_gomariza_capilar_app/models/appointment/appointment_dto.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/appointment_repository/appointment_repository.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/appointment_repository/appointment_repository_impl.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/calendar_repository/calendar_repository.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/calendar_repository/calendar_repository_impl.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/service_repository/service_repository.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/service_repository/service_repository_impl.dart';
import 'package:flutter_gomariza_capilar_app/styles.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../models/service/service_list_response.dart';

class CreateAppointmentScreen extends StatefulWidget {
  const CreateAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<CreateAppointmentScreen> createState() =>
      _CreateAppointmentScreenState();
}

class _CreateAppointmentScreenState extends State<CreateAppointmentScreen> {
  late CalendarRepository calendarRepository;
  late AppointmentRepository appointmentRepository;
  late ServiceRepository serviceRepository;

  final _formKey = GlobalKey<FormState>();

  Object dropDownValue = '';
  String dropDownValue2 = '';
  DateTime dateSelected = DateTime.now();

  List<String> hoursList = [
    '8:00',
    '9:00',
    '10:00',
    '11:00',
    '12:00',
    '13:00',
    '14:00',
    '15:00',
    '16:00',
    '17:00'
  ];

  @override
  void initState() {
    super.initState();
    calendarRepository = CalendarRepositoryImpl();
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
            return CheckCalendarBloc(calendarRepository);
          }),
          BlocProvider(create: (context) {
            return AppointmentCreateBloc(appointmentRepository);
          }),
          BlocProvider(create: (context) {
            return ServiceListBloc(serviceRepository)
              ..add(const GetServiceListEvent());
          })
        ],
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: _createBody(context),
        ));
  }

  Widget _createBody(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).padding,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(CustomStyles.bodyPadding),
          child: BlocConsumer<ServiceListBloc, ServiceListState>(
            listenWhen: (context, state) {
              return state is ServiceListSuccessState ||
                  state is ServiceListErrorState;
            },
            listener: (context, state) {
              if (state is ServiceListSuccessState) {
                return;
              }
            },
            buildWhen: (context, state) {
              return state is ServiceListSuccessState ||
                  state is ServiceListLoadingState;
            },
            builder: (context, state) {
              if (state is ServiceListInitialState ||
                  state is ServiceListLoadingState) {
                return Center(
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: HeartbeatProgressIndicator(
                            child: Image.asset(
                                'assets/images/logo_sin_texto.png'))));
              } else if (state is ServiceListSuccessState) {
                return _buildScreen(context, state.serviceListResponse);
              }
              return const Text('Ha ocurrido un error inesperado');
            },
          ),
        ),
      ),
    );
  }

  Widget _buildScreen(
      BuildContext context, List<ServiceListResponse> serviceList) {
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
          Container(
            height: 700,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: CustomStyles.formBoxColor),
            padding: const EdgeInsets.symmetric(
                horizontal: CustomStyles.contentPadding),
            child: Column(
              children: [
                Text(
                  'Nueva cita',
                  style: CustomStyles.descriptionTitleText,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DropdownButtonFormField(
                            value: dropDownValue,
                            hint: const Text('Seleccione un servicio'),
                            items: serviceList.map((service) {
                              return DropdownMenuItem(
                                  value: service.id,
                                  child: Text(service.nombre));
                            }).toList(),
                            onChanged: (service) {
                              setState(() {
                                dropDownValue = service!;
                              });
                            }),
                        BlocConsumer<CheckCalendarBloc, CheckCalendarState>(
                          listenWhen: (context, state) {
                            return state is CheckCalendarSuccessState;
                          },
                          listener: (context, state) {},
                          buildWhen: (context, state) {
                            return state is CheckCalendarInitialState ||
                                state is CheckCalendarSuccessState;
                          },
                          builder: (context, state) {
                            if (state is CheckCalendarSuccessState) {
                              return SfDateRangePicker(
                                view: DateRangePickerView.month,
                                selectionMode:
                                    DateRangePickerSelectionMode.single,
                                enablePastDates: false,
                                onSelectionChanged:
                                    (DateRangePickerSelectionChangedArgs args) {
                                  dateSelected = args.value;
                                },
                              );
                            } else {
                              return const Text(
                                  'Ha ocurrido un error inesperado');
                            }
                          },
                        ),
                        DropdownButtonFormField(
                            value: dropDownValue2,
                            hint: const Text('Seleccione una hora'),
                            items: hoursList.map((hour) {
                              return DropdownMenuItem(
                                  value: hour, child: Text(hour));
                            }).toList(),
                            onChanged: (hour) {
                              setState(() {
                                dropDownValue2 = hour.toString();
                              });
                            }),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              final appointmentDto = AppointmentDto(
                                  servicioId: dropDownValue.toString(),
                                  fechaCita: dateSelected.toString() +
                                      dropDownValue2 +
                                      ":00");
                              BlocProvider.of<AppointmentCreateBloc>(context)
                                  .add(
                                      DoCreateAppointmentEvent(appointmentDto));
                              Navigator.pop(context);
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
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
