import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gomariza_capilar_app/blocs/service_detail_bloc/service_detail_bloc.dart';
import 'package:flutter_gomariza_capilar_app/models/service/service_detail_response.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/service_repository/service_repository.dart';
import 'package:flutter_gomariza_capilar_app/resources/repositories/service_repository/service_repository_impl.dart';
import 'package:flutter_gomariza_capilar_app/styles.dart';
import 'package:flutter_gomariza_capilar_app/utils/utf_8_decoder/utf_8_decoder.dart';
import 'package:progress_indicators/progress_indicators.dart';

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({Key? key}) : super(key: key);

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  late ServiceRepository serviceRepository;

  @override
  void initState() {
    super.initState();
    serviceRepository = ServiceRepositoryImpl();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final idService = ModalRoute.of(context)!.settings.arguments as String;

    return BlocProvider(
      create: (context) {
        return ServiceDetailBloc(serviceRepository)
          ..add(GetServiceDetailEvent(idService));
      },
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
          child: BlocConsumer<ServiceDetailBloc, ServiceDetailState>(
            listenWhen: (context, state) {
              return state is ServiceDetailSuccessState ||
                  state is ServiceDetailErrorState;
            },
            listener: (context, state) {
              if (state is ServiceDetailSuccessState) {
                return;
              }
            },
            buildWhen: (context, state) {
              return state is ServiceDetailSuccessState ||
                  state is ServiceDetailLoadingState;
            },
            builder: (context, state) {
              if (state is ServiceDetailInitialState ||
                  state is ServiceDetailLoadingState) {
                return Center(
                    child: SizedBox(
                        width: 100,
                        height: 100,
                        child: HeartbeatProgressIndicator(
                            child: Image.asset(
                                'assets/images/logo_sin_texto.png'))));
              } else if (state is ServiceDetailSuccessState) {
                return _buildScreen(context, state.serviceDetailResponse);
              }
              return const Text('Ha ocurrido un error inesperado');
            },
          ),
        ),
      ),
    );
  }

  Widget _buildScreen(BuildContext context, ServiceDetailResponse service) {
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
                height: 700.0,
                width: 350.0,
                decoration: BoxDecoration(
                    color: CustomStyles.formBoxColor,
                    borderRadius: BorderRadius.circular(25.0)),
              ),
              Container(
                height: 670.0,
                width: 325.0,
                decoration: BoxDecoration(
                    color: CustomStyles.primaryColorSemiTransparent,
                    borderRadius: BorderRadius.circular(25.0)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        Utf8Decoder.utf8Decode(service.nombre),
                        style: CustomStyles.detailTitleText,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Image.network(
                            service.foto,
                            width: 300.0,
                          )),
                      Text(
                        Utf8Decoder.utf8Decode(service.descripcion),
                        style: CustomStyles.detailText,
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
                                'Dr. ' +
                                    Utf8Decoder.utf8Decode(
                                        service.nombreProfesional),
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
                            child: Text(
                                'Aprox. ' + service.duracion + '/sesión',
                                style: CustomStyles.detailText),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.payments,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10.0),
                            child: Text(Utf8Decoder.utf8Decode(service.precio),
                                style: CustomStyles.detailText),
                          )
                        ],
                      ),
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
}
