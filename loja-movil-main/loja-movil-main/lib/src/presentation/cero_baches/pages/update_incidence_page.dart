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
import 'package:loja_movil/src/libraries/go_router_extension.dart';
import 'package:loja_movil/src/presentation/common/loading_view.dart';
import 'package:loja_movil/src/domain/response/incidence_type_response.dart';
import 'package:loja_movil/src/presentation/cero_baches/pages/home_page.dart';
import 'package:loja_movil/src/presentation/cero_baches/state/cero_baches_state.dart';
import 'package:loja_movil/src/presentation/cero_baches/widgets/admin_menu.widget.dart';

class UpdateIncidencePage extends StatefulWidget {
  final Object? incidenceId;

  const UpdateIncidencePage({super.key, required this.incidenceId});

  static const routeName = '/update_incidence';
  static const String name = 'update-incidence-page';

  @override
  State<UpdateIncidencePage> createState() => _UpdateIncidencePage();
}

class _UpdateIncidencePage extends State<UpdateIncidencePage> {
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
  double width = 0.0;
  double height = 0.0;
  double imageSizeMB = 0.0;

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

  Future<void> _getFromDevice() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image != null) {
      await resizeAndSetImage(File(image.path));
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
      _getImageSize();
    } catch (e) {
      debugPrint("Error compressing image: $e");
    }
  }

  Future<void> _getImageSize() async {
    if (imageFile != null) {
      final decodedImage =
          await decodeImageFromList(imageFile!.readAsBytesSync());
      setState(() {
        width = decodedImage.width.toDouble();
        height = decodedImage.height.toDouble();
        imageSizeMB = imgbytes.lengthInBytes / (1024 * 1024);
      });
    }
  }

  resetImage() {
    setState(() {
      imageFile = null;
      imgbytes = Uint8List.fromList([]);
      imageSizeMB = 0.0;
      width = 0;
      height = 0;
    });
  }

  bool _disabledButton() {
    return description != '' && selectedValue != null;
  }

  showFullModal(BuildContext context, CeroBachesStateBLoC provider) {
    showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
        title: const Icon(
          Icons.done_outline,
          color: Colors.green,
          size: 70.0,
        ),
        content: const Text(
          'Incidencia reasignada con éxito',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: TextButton.styleFrom(
              fixedSize: Size(MediaQuery.of(context).size.width * 1, 45),
              backgroundColor: kPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            onPressed: () {
              GoRouter.of(context)
                  .popUntilPath(context, CeroBachesHomePage.routeName);
            },
            child: const Text(
              'Aceptar',
              style: TextStyle(color: Colors.white),
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
      isLoading: provider.loadingDepartments || provider.loadingAssign,
      backgroundColor: const Color(0XFFF4F6F9),
      appBar: AppBar(
        title: const Text(
          'Reasignar incidencia',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: const Color(0XFFF4F6F9),
        elevation: 0,
        centerTitle: true,
        actions: [
          AdminMenu(provider: provider),
        ],
      ),
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Evidencia',
                  style: TextStyle(
                      color: kBlackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Directionality(
                        textDirection: TextDirection.ltr,
                        child: OutlinedButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          onPressed: () async {
                            _getFromCamera();
                          },
                          child: const Text(
                            'Capturar imagen',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: OutlinedButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: () async {
                          _getFromDevice();
                        },
                        child: const Text(
                          'Subir archivo',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                imageFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: SizedBox(
                          height: screenHeight * 0.4,
                          child: Image.file(
                            imageFile!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : const Text(''),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Comentario',
                  style: TextStyle(
                      color: kBlackColor,
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
                    hintText: 'Ingresar texto',
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
                const Text(
                  'Reasignar a',
                  style: TextStyle(
                      color: kBlackColor,
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
                        items: provider.incidenceTypes?.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item.name),
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
                ElevatedButton(
                  style: TextButton.styleFrom(
                    fixedSize: Size(MediaQuery.of(context).size.width * 1, 45),
                    backgroundColor:
                        !_disabledButton() ? kGrayDisabledColor : kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: !_disabledButton()
                      ? null
                      : () async {
                        if (imageSizeMB > 2.5) {
                            showTopSnackBar(
                              Overlay.of(context),
                              const CustomSnackBar.error(
                                message:
                                    'La imagen supera el tamaño de 2.5 MB. Por favor subir una imagen con un tamaño inferior',
                              ),
                            );
                            return;
                          }
                          Map<String, dynamic> request = {
                            'file': imageFile,
                            'comment': description,
                            'incidenceId': widget.incidenceId as int,
                            'incidenceTypeId': selectedValue?.id,
                          };
                          bool result =
                              await provider.reassignIncidence(request);
                          if (result) {
                            // ignore: use_build_context_synchronously
                            showFullModal(context, provider);
                          } else {
                            showTopSnackBar(
                              // ignore: use_build_context_synchronously
                              Overlay.of(context),
                              const CustomSnackBar.error(
                                message:
                                    'Error al reasignar la incidencia, intente nuevamente',
                              ),
                            );
                          }
                        },
                  child: const Text(
                    'Reasignar',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            )),
      ),
    );
  }
}
