// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:image/image.dart' as img;
import 'package:go_router/go_router.dart';
import 'package:loja_movil/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:loja_movil/src/libraries/go_router_extension.dart';
import 'package:loja_movil/src/presentation/common/loading_view.dart';
import 'package:loja_movil/src/domain/response/incidence_type_response.dart';
import 'package:loja_movil/src/presentation/cero_baches/pages/home_page.dart';
import 'package:loja_movil/src/presentation/cero_baches/state/cero_baches_state.dart';

class NewReportPage extends StatefulWidget {
  const NewReportPage({super.key});

  static const routeName = '/new-report';
  static const String name = 'new-report-page';

  @override
  State<NewReportPage> createState() => _NewReportPage();
}

class _NewReportPage extends State<NewReportPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<CeroBachesStateBLoC>(context, listen: false)
            .fetchDataUpdateIncidence());
  }

  File? imageFile;
  Uint8List imgbytes = Uint8List.fromList([]);
  String description = '';
  IncidenceType? selectedValue;

  final _picker = ImagePicker();

  Future<void> _getFromCamera() async {
    XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      await resizeAndSetImage(File(pickedFile.path));
    }
  }

  Future<void> resizeAndSetImage(File file) async {
    try {
      List<int> bytes = await file.readAsBytes();
      img.Image? image = img.decodeImage(Uint8List.fromList(bytes));
      img.Image resizedImage = img.copyResize(image!, width: 750);

      List<int> compressedBytes = img.encodeJpg(resizedImage, quality: 70);

      setState(() {
        imageFile = file;
        imgbytes = Uint8List.fromList(compressedBytes);
      });
    } catch (e) {
      debugPrint("Error compressing image: $e");
    }
  }

  resetImage() {
    setState(() {
      imageFile = null;
      imgbytes = Uint8List.fromList([]);
    });
  }

  bool _disabledButton() {
    return description != '' && selectedValue != null;
  }

  showFullModal(BuildContext context) {
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Icon(
          Icons.done,
          color: Colors.green,
          size: 70.0,
        ),
        content: Text(
          AppLocalizations.of(context)!.incidencesSuccessMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: kGrayColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              context.pop();
              resetImage();
            },
            child: Text(
              AppLocalizations.of(context)!.incidencesKeepReporting,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          ElevatedButton(
            style: TextButton.styleFrom(
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              GoRouter.of(context)
                  .popUntilPath(context, CeroBachesHomePage.routeName);
            },
            child: Text(
              AppLocalizations.of(context)!.incidencesBackToHome,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CeroBachesStateBLoC>(context);

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return LoadingView(
      backgroundColor: const Color(0XFFF4F6F9),
      isLoading: provider.loadingNewIncidence,
      appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.incidencesTitle,
            style: const TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          elevation: 0,
          backgroundColor: const Color(0XFFF4F6F9),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Image.asset(
                'assets/images/escudo.png',
                height: 40.0,
              ),
            ),
          ],
          leading: IconButton(
            onPressed: imageFile != null
                ? () => resetImage()
                : () => GoRouter.of(context)
                    .popUntilPath(context, CeroBachesHomePage.routeName),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: kBlackColor,
            ),
          )),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          child: imageFile == null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      AppLocalizations.of(context)!.incidencesDirections,
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Image.asset(
                      height: screenHeight * 0.6,
                      'assets/images/camera.jpg',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Directionality(
                            textDirection: TextDirection.ltr,
                            child: ElevatedButton.icon(
                              style: TextButton.styleFrom(
                                fixedSize: Size(
                                    MediaQuery.of(context).size.width * 0.5,
                                    45),
                                backgroundColor: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              icon: Icon(
                                provider.loadingPosition
                                    ? Icons.hourglass_empty
                                    : Icons.camera_alt_outlined,
                                color: Colors.white,
                              ),
                              onPressed: provider.loadingPosition
                                  ? null
                                  : () async {
                                      await provider.determinePosition();
                                      String locationMessage =
                                          provider.locationMessage;
                                      if (locationMessage != '') {
                                        showTopSnackBar(
                                          Overlay.of(context),
                                          CustomSnackBar.info(
                                            message: locationMessage,
                                          ),
                                        );
                                      }
                                      if (provider.latitude != null &&
                                          provider.longitude != null) {
                                        _getFromCamera();
                                      }
                                    },
                              label: Text(
                                provider.loadingPosition
                                    ? AppLocalizations.of(context)!
                                        .incidencesAccessing
                                    : AppLocalizations.of(context)!
                                        .incidencesImageCapture,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Card(
                        margin: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 0,
                        child: Container(
                            color: const Color.fromARGB(255, 205, 219, 247),
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 20,
                            ),
                            child: Center(
                              child: Text(
                                AppLocalizations.of(context)!
                                    .incidencesSendReportDirections,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                    color: Color.fromARGB(255, 5, 1, 49)),
                              ),
                            ))),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      AppLocalizations.of(context)!.incidencesReportImage,
                      style: const TextStyle(
                          color: kBlueColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: SizedBox(
                        height: screenHeight * 0.4,
                        child: Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      AppLocalizations.of(context)!.incidencesReportType,
                      style: const TextStyle(
                          color: kBlueColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: screenWidth,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: DropdownButton(
                            value: selectedValue,
                            underline: Container(),
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: provider.incidenceTypes?.map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(type.name),
                              );
                            }).toList(),
                            onChanged: (IncidenceType? value) {
                              setState(() {
                                selectedValue = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      AppLocalizations.of(context)!.incidencesReportDescription,
                      style: const TextStyle(
                          color: kBlueColor,
                          fontSize: 15,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      keyboardType: TextInputType.text,
                      onChanged: (String text) {
                        setState(() {
                          description = text;
                        });
                      },
                      maxLines: 4,
                      decoration: const InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.all(10),
                        fillColor: Color.fromARGB(255, 255, 255, 255),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: TextButton.styleFrom(
                              backgroundColor: kGrayColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {
                              resetImage();
                            },
                            child: Text(
                              AppLocalizations.of(context)!
                                  .incidencesReportCancel,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: TextButton.styleFrom(
                              backgroundColor: !_disabledButton()
                                  ? kGrayDisabledColor
                                  : kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: !_disabledButton()
                                ? null
                                : () async {
                                     Map<String, dynamic> request = {
                                      'file': imageFile,
                                      'longitude': provider.longitude,
                                      'latitude': provider.latitude,
                                      'description': description,
                                      'incidenceTypeId': selectedValue?.id
                                    };
                                    final result =
                                        await provider.createIncidence(request);

                                    if (result) {
                                      showFullModal(context);
                                    } else {
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        CustomSnackBar.error(
                                          message: AppLocalizations.of(context)!
                                              .incidencesReportErrorMessage,
                                        ),
                                      );
                                    }
                                  },
                            child: Text(
                              AppLocalizations.of(context)!
                                  .incidencesReportSend,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
