import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_app/bloc/memory_bloc.dart';
import 'package:memory_app/bloc/memory_event.dart';
import 'package:memory_app/bloc/memory_state.dart';
import 'package:memory_app/pages/memories_list_screen.dart.dart';
import 'package:memory_app/theme/text_theme.dart';
import 'package:memory_app/widgets/custom_button.dart';
import 'package:memory_app/widgets/custom_dropdown_field.dart';
import 'package:memory_app/widgets/custom_textfield.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

class MemoryEntryPage extends StatefulWidget {
  const MemoryEntryPage({Key? key}) : super(key: key);

  @override
  _MemoryEntryPageState createState() => _MemoryEntryPageState();
}

class _MemoryEntryPageState extends State<MemoryEntryPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController memoryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool isChecked = false;
  String? selectedState;
  String? selectedCity;
  String? selectedMosque;
  XFile? image;
  String? imageUrl;

  final List<String> states = ["Hamburg", "Bremen", "Berlin", "Hessen"];
  final Map<String, List<String>> cities = {
    "Hamburg": ["Hamburg City", "Altona", "Eimsbüttel"],
    "Bremen": ["Bremen City", "Bremerhaven"],
    "Berlin": ["Berlin City", "Mitte", "Friedrichshain-Kreuzberg"],
    "Hessen": [
      "Frankfurt",
      "Wiesbaden",
      "Erlensee",
      "Kassel",
      "Gelnhausen",
      "Wächtersbach",
      "Schlüchtern"
    ],
  };

  final List<String> mosques = [
    "DITIB-Türkisch Islamische Gemeinde Gelnhausen eV",
    "Cologne Central Mosque",
    "Berlin Sehitlik Mosque",
    "Essen DITIB Merkez Camii",
    "Duisburg Merkez Moschee",
    "Frankfurt Zentralmoschee Wächtersbach",
    "Ditib Türkisch-Islamische Gemeinde zu Schlüchtern e.v. Eyüp Sultan Moschee",
    "DITIB Türkisch Islamischer Gemeinde zu Erlensee eV Fatih-Moschee Erlensee,"
        "Hamburg Merkez Camii",
    "Mannheim DITIB Yunus Emre Camii",
    "Stuttgart Zentral Moschee",
    "Nuremberg Süleymaniye Moschee",
    "Dortmund Kuba Camii"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF205761),
        title: const Text(
          'Hatıra Yaz',
          style: AppTextTheme.kAppBarTitleStyle,
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background_image.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: BlocListener<MemoryBloc, MemoryState>(
              listener: (context, state) {
                if (state is MemorySubmitting) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Gönderiliyor'),
                    ),
                  );
                } else if (state is MemorySubmitted) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Başarılı"),
                        content: const Text(
                            "Hatıranız başarıyla gönderildi ve admin tarafından onaylandıktan sonra yayımlanacaktır."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MemoryListPage(),
                                ),
                              );
                            },
                            child: const Text("Tamam"),
                          )
                        ],
                      );
                    },
                  );
                } else if (state is MemorySubmitError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Hata: ${state.error}'),
                    ),
                  );
                }
              },
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ad", style: AppTextTheme.kLabelStyle),
                        CustomTextField(
                          controller: nameController,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffd1d8ff),
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          inputHint: 'Adınızı Giriniz',
                          fillColor: Colors.white.withOpacity(0.5),
                          filled: true,
                        ),
                        Text("Soyad", style: AppTextTheme.kLabelStyle),
                        CustomTextField(
                          controller: surnameController,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffd1d8ff),
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          inputHint: 'Soyadınızı Giriniz',
                          fillColor: Colors.white.withOpacity(0.5),
                          filled: true,
                        ),
                        Text("E-posta", style: AppTextTheme.kLabelStyle),
                        CustomTextField(
                          controller: emailController,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color(0xffd1d8ff),
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          inputHint: 'E-posta adresinizi giriniz',
                          fillColor: Colors.white.withOpacity(0.5),
                          filled: true,
                        ),
                        SizedBox(height: 5),
                        Text("Eyalet", style: AppTextTheme.kLabelStyle),
                        CustomDropdownField(
                          value: selectedState,
                          items: states,
                          labelText: '',
                          onChanged: (value) {
                            setState(() {
                              selectedState = value;
                              selectedCity = null;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Lütfen bir eyalet seçin';
                            }
                            return null;
                          },
                          fillColor: Colors.white.withOpacity(0.5),
                          filled: true,
                        ),
                        Text("Şehir", style: AppTextTheme.kLabelStyle),
                        CustomDropdownField(
                          value: selectedCity,
                          items: selectedState != null &&
                                  cities.containsKey(selectedState)
                              ? cities[selectedState]!
                              : [],
                          labelText: '',
                          onChanged: (value) {
                            setState(() {
                              selectedCity = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Lütfen bir şehir seçin';
                            }
                            return null;
                          },
                          fillColor: Colors.white.withOpacity(0.5),
                          filled: true,
                        ),
                        Text("Cami", style: AppTextTheme.kLabelStyle),
                        CustomDropdownField(
                          value: selectedMosque,
                          items: mosques,
                          labelText: '',
                          onChanged: (value) {
                            setState(() {
                              selectedMosque = value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Lütfen bir cami seçin';
                            }
                            return null;
                          },
                          fillColor: Colors.white.withOpacity(0.5),
                          filled: true,
                        ),
                        Text("Hatıra", style: AppTextTheme.kLabelStyle),
                        TextFormField(
                          controller: memoryController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Color(0xffd1d8ff),
                              ),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            labelText: '',
                            fillColor: Colors.white.withOpacity(0.5),
                            filled: true,
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Lütfen hatıranızı yazın';
                            }
                            if (value.length > 1000) {
                              return 'Hatıra 1000 karakterden fazla olamaz';
                            }
                            return null;
                          },
                          maxLength: 1000,
                          minLines: 5,
                          maxLines: null,
                        ),
                        if (image != null) ...[
                          Image.file(
                            File(image!.path),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ],
                        GestureDetector(
                          onTap: () => _pickImage(ImageSource.camera),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                              color: const Color(0xFF205761),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add_a_photo,
                                  color: Colors.white,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  'Resim Ekle',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        CheckboxListTile(
                          title: Text('Okudum ve kabul ediyorum',
                              style: AppTextTheme.kLabelStyle),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value ?? false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        SizedBox(height: 5),
                        CustomButton(
                          buttonText: 'Gönder',
                          onTap: _submitMemory,
                          size: 16,
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });

      String? url = await _uploadImageToFirebase();
      if (url != null) {
        setState(() {
          imageUrl = url;
        });
      }
    }
  }

  Future<String?> _uploadImageToFirebase() async {
    try {
      String fileName = path.basename(image!.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child('images/$fileName');
      UploadTask uploadTask = firebaseStorageRef.putFile(File(image!.path));
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadURL = await taskSnapshot.ref.getDownloadURL();
      print("Download URL from Firebase Storage: $downloadURL");
      return downloadURL;
    } catch (e, stackTrace) {
      print("Error uploading image: $e");
      print("Stack trace: $stackTrace");
      return null;
    }
  }

  void _submitMemory() {
    if (_formKey.currentState!.validate() && isChecked) {
      String id = Uuid().v4();
      BlocProvider.of<MemoryBloc>(context).add(SubmitMemory(
        id: id,
        name: nameController.text,
        surname: surnameController.text,
        email: emailController.text,
        state: selectedState!,
        city: selectedCity!,
        memory: memoryController.text,
        imageUrl: imageUrl ?? '',
        mosque: selectedMosque!,
        isApproved: false,
      ));
    }
  }

  void _refreshPage() {
    setState(() {
      nameController.clear();
      surnameController.clear();
      memoryController.clear();
      selectedState = null;
      selectedCity = null;
      selectedMosque = null;
      isChecked = false;
      image = null;
      imageUrl = null;
    });
  }
}
