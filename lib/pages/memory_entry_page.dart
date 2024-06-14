import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_app/bloc/memory_bloc.dart';
import 'package:memory_app/bloc/memory_event.dart';
import 'package:memory_app/bloc/memory_state.dart';
import 'package:memory_app/theme/text_theme.dart';
import 'package:memory_app/widgets/custom_button.dart';
import 'package:memory_app/widgets/custom_dropdown_field.dart';
import 'package:memory_app/widgets/custom_textfield.dart';
import 'package:path/path.dart' as path;

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
    "Hessen": ["Frankfurt", "Wiesbaden", "Kassel"],
  };

  final List<String> mosques = [
    "Cologne Central Mosque",
    "Berlin Sehitlik Mosque",
    "Essen DITIB Merkez Camii",
    "Duisburg Merkez Moschee",
    "Frankfurt Nida Moschee",
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
        title: const Text('Hatıra Yaz'),
      ),
      body: BlocListener<MemoryBloc, MemoryState>(
        listener: (context, state) {
          if (state is MemorySubmitting) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Gönderiliyor'),
              ),
            );
          } else if (state is MemorySubmitted) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Başarılı"),
                  content: Text("Hatıra başarıyla gönderildi"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _refreshPage();
                      },
                      child: Text("Tamam"),
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
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 12,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
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
                      ),
                      SizedBox(height: 5),
                      Text("Eyalet", style: AppTextTheme.kLabelStyle),
                      CustomDropdownField(
                        value: selectedState,
                        items: states,
                        labelText: 'Eyalet',
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
                      ),
                      const SizedBox(height: 3),
                      Text("Şehir", style: AppTextTheme.kLabelStyle),
                      CustomDropdownField(
                        value: selectedCity,
                        items: selectedState != null &&
                                cities.containsKey(selectedState)
                            ? cities[selectedState]!
                            : [],
                        labelText: 'Şehir',
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
                      ),
                      Text("Cami", style: AppTextTheme.kLabelStyle),
                      CustomDropdownField(
                        value: selectedMosque,
                        items: mosques,
                        labelText: 'Cami',
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
                          labelText: 'Hatıra',
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
                      if (image != null)
                        Image.file(
                          File(image!.path),
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.blue,
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
                      CheckboxListTile(
                        title: Text('Okudum ve kabul ediyorum'),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CustomButton(
                        buttonText: 'Gönder',
                        buttonColor: Colors.white,
                        onTap: _submitMemory,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
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
      BlocProvider.of<MemoryBloc>(context).add(SubmitMemory(
        name: nameController.text,
        surname: surnameController.text,
        state: selectedState!,
        city: selectedCity!,
        memory: memoryController.text,
        imageUrl: imageUrl ?? '', // URL'yi ekle
        mosque: selectedMosque!,
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
