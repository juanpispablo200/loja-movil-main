import 'package:flutter/material.dart';

const kFestivalEndPoint = '190.214.14.241';
const kKeycloakEndPoint = '181.113.129.14';

const kGatewayEndPoint = '181.113.129.17';
const kCeroBachesEndPoint = '181.113.129.17';
const kTourisCultureEndPoint = '181.113.129.17';

const kKeycloakPort = 9080;
const kGatewayPort = 8080;
const kCeroBachesPort = 8082;
const kTourisCulturePort = 8083;

const kUrlBackEnd = 'http://190.214.14.241/festival_web/';

const incidenceMicroservice = '/api/micro-incidences/';
const tourismCultureMicroservice = '/api/micro-tourismculture/';

// Data KEYCLOAK
const kRealm = 'municipio';

const kClientId = 'mun_loja';
const kClientSecret = 'mun_loja';

const kGrayColor = Color.fromARGB(255, 9, 15, 52);
const kGrayColorSubtitle = Color(0XFF6F6F6F);
const kGrayDisabledColor = Color.fromARGB(255, 200, 200, 200);
const kPurpleColor = Color(0XFF5E38BA);
const kRedColor = Color.fromARGB(255, 226, 27, 50);
const kOrangeColor = Color(0XFFFF6937);
const kGreenColor = Color(0XFF05944F);

const kPrimaryColor = Color(0XFF426CA4); //426CA4
const kSecondaryColor = Color(0XFF4DB0DC); //4DB0DC

const kColor1 = Color(0XFFD64B25);
const kColor2 = Color(0XFFF3A93D);
const kColor3 = Color(0XFFDA8030);
const kColor4 = Color(0XFFED662A);
const kBlackColor = Color(0XFF000000);
const kBlueColor = Color(0xFF405BBB);

const kFavPrimary = Color(0XFF004494);
const kFavSecondary = Color(0XFFF7BB16);

final DateTime fechaObjetivo =
    DateTime(2024, 11, 15); // Fecha de inicio del festival de artes vivas 2024