import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gomariza_capilar_app/blocs/appointment_list_calendar_bloc/appointment_list_calendar_bloc.dart';
import 'package:flutter_gomariza_capilar_app/models/appointment/appointment_calendar_list_response.dart';
import 'package:flutter_gomariza_capilar_app/models/appointment/appointment_data_source.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/appointment_repository/appointment_repository.dart';
import 'package:flutter_gomariza_capilar_app/styles.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../resources/repositories/appointment_repository/appointment_repository_impl.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
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
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) {
            return AppointmentListCalendarBloc(appointmentRepository)
              ..add(const GetAllAppointmentsCalendarEvent());
          }),
        ],
        child: Scaffold(
          body: _createBody(context),
        ));
  }

  Widget _createBody(BuildContext context) {
    return Container(
      margin: MediaQuery.of(context).padding,
      child: BlocConsumer<AppointmentListCalendarBloc,
          AppointmentListCalendarState>(
        listenWhen: (context, state) {
          return state is AppointmentListCalendarSuccessState ||
              state is AppointmentListCalendarErrorState;
        },
        listener: (context, state) {
          if (state is AppointmentListCalendarSuccessState) {
            return;
          }
        },
        buildWhen: (context, state) {
          return state is AppointmentListCalendarSuccessState ||
              state is AppointmentListCalendarLoadingState;
        },
        builder: (context, state) {
          if (state is AppointmentListCalendarInitialState ||
              state is AppointmentListCalendarInitialState) {
            return Center(
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: HeartbeatProgressIndicator(
                        child:
                            Image.asset('assets/images/logo_sin_texto.png'))));
          } else if (state is AppointmentListCalendarSuccessState) {
            return _buildScreen(context, state.appointmentListCalendarResponse);
          }
          return const Text('Ha ocurrido un error inesperado');
        },
      ),
    );
  }

  Widget _buildScreen(BuildContext context,
      List<AppointmentCalendarListResponse> appointmentCalendarListResponse) {
    return Stack(children: [
      SfCalendar(
        view: CalendarView.schedule,
        dataSource: _getCalendarDataSource(appointmentCalendarListResponse),
        scheduleViewSettings: ScheduleViewSettings(
            appointmentTextStyle: CustomStyles.appointmentText,
            appointmentItemHeight: 60.0,
            monthHeaderSettings: const MonthHeaderSettings(
                height: 100.0,
                backgroundColor: CustomStyles.primaryColorSemiTransparent)),
        showDatePickerButton: true,
        allowedViews: const [CalendarView.month, CalendarView.schedule],
        firstDayOfWeek: 1,
        onTap: (CalendarTapDetails details) {
          dynamic appointment = details.appointments;
          Navigator.pushNamed(context, '/appointmentDetail',
              arguments: appointment[0].id);
        },
      ),
      IconButton(
        onPressed: () {
          Navigator.pushNamed(context, '/newAppointment');
        },
        icon: const Icon(Icons.add),
        color: Colors.white,
      ),
    ]);
  }

  AppointmentDataSource _getCalendarDataSource(
      List<AppointmentCalendarListResponse> appointmentResponse) {
    List<Appointment> appointments = <Appointment>[];
    for (var appointment in appointmentResponse) {
      appointments.add(Appointment(
          startTime: DateTime.parse(appointment.de[0].toString() +
              "-" +
              "0" +
              appointment.de[1].toString() +
              "-" +
              appointment.de[2].toString() +
              " " +
              appointment.de[3].toString() +
              ":" +
              (appointment.de[4].toString() == "0"
                  ? appointment.de[4].toString() + "0"
                  : appointment.de[4].toString()) +
              ":00"),
          endTime: DateTime.parse(appointment.a[0].toString() +
              "-" +
              "0" +
              appointment.a[1].toString() +
              "-" +
              appointment.a[2].toString() +
              " " +
              appointment.a[3].toString() +
              ":" +
              (appointment.a[4].toString() == "0"
                  ? appointment.a[4].toString() + "0"
                  : appointment.a[4].toString()) +
              ":00"),
          subject: appointment.nombreServicio,
          color: Colors.blue,
          startTimeZone: '',
          endTimeZone: '',
          id: appointment.id));
    }

    return AppointmentDataSource(appointments);
  }
}
