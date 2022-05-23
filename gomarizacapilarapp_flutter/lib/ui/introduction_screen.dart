import 'package:flutter/material.dart';
import 'package:flutter_gomariza_capilar_app/styles.dart';
import 'package:flutter_gomariza_capilar_app/utils/constants/constants.dart';
import 'package:flutter_gomariza_capilar_app/utils/preferences/preferences_utils.dart';
import 'package:introduction_screen/introduction_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        margin: const EdgeInsets.only(top: 75.0),
        child: Padding(
          padding: const EdgeInsets.all(CustomStyles.bodyPadding),
          child: IntroductionScreen(
            pages: [
              PageViewModel(
                  title: 'Gestione sus citas',
                  body:
                      'Podrá ver, modificar y solicitar nuevas citas de manera cómoda y rápida',
                  image: Center(
                    child: Image.network(
                        'https://img.freepik.com/vector-gratis/reserva-citas-calendario_52683-39365.jpg?t=st=1651231232~exp=1651231832~hmac=427ef589d50298d5794ee6d67be8d3cbc93abf79179977667d283e28f6908a15&w=826'),
                  )),
              PageViewModel(
                title: 'Siempre en contacto',
                body:
                    'Reciba y envíe mensajes a los profesionales para facilitar la comunicación rápida y eficaz',
                image: Center(
                  child: Image.network(
                      'https://img.freepik.com/vector-gratis/marketing-correo-electronico-chat-internet-soporte-24-horas_335657-3009.jpg?t=st=1651230598~exp=1651231198~hmac=a916d5c97ea54b653f94f75d4ef5da1cb3d94ee100f035547de5b40b42c5a8f5&w=1380'),
                ),
              ),
              PageViewModel(
                title: 'Servicios',
                body:
                    'Consulte e infórmese de los servicios disponibles siempre que quiera',
                image: Center(
                  child: Image.network(
                      'https://img.freepik.com/vector-gratis/ilustracion-consulta-videollamada-medica_88138-415.jpg?t=st=1651231750~exp=1651232350~hmac=cdfa2f9f2071c22284f78afbc4e7ec53314496cd93f999c8fde83d6b59d7dd41&w=996'),
                ),
              ),
              PageViewModel(
                title: 'Promociones',
                body:
                    'Manténgase al día de las ofertas y promociones disponibles',
                image: Center(
                  child: Image.network(
                      'https://img.freepik.com/vector-gratis/vendedor-sostiene-megafono-mano-anuncia-venta-promocional-invitar-clientes-comprar-anuncio-plantilla-promocion-minorista-anuncio-ilustracion-vector-super-venta_1150-55438.jpg?t=st=1651232120~exp=1651232720~hmac=68f7435b4ae15410052976a8d4b1714c3f406fdbcbc758db84679a1e3c207b9b&w=1380'),
                ),
              )
            ],
            onDone: () {
              Navigator.pushNamed(context, '/login');
              setState(() {
                PreferenceUtils.setBool(Constants.SHOW_INTRODUCTION, false);
              });
            },
            onSkip: () {
              Navigator.pushNamed(context, '/login');
              setState(() {
                PreferenceUtils.setBool(Constants.SHOW_INTRODUCTION, false);
              });
            },
            showSkipButton: true,
            skip: const Icon(Icons.skip_next),
            next: const Icon(Icons.forward),
            done: const Text("Done",
                style: TextStyle(fontWeight: FontWeight.w600)),
            dotsDecorator: DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size(20.0, 10.0),
                activeColor: CustomStyles.primaryColor,
                color: Colors.black26,
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0))),
          ),
        ),
      ),
    ));
  }
}
