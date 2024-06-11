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
  XFile? image;
  final List<String> states = ["Hamburg", "Bremen", "Berlin", "Hessen"];
  final Map<String, List<String>> cities = {
    "Hamburg": ["City1-1", "City1-2", "City1-3"],
    "Bremen": ["City2-1", "City2-2", "City2-3"],
    "Berlin": ["City3-1", "City3-2", "City3-3"],
    "Hessen": ["City4-1", "City4-2", "City4-3"],
  };

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
            showDialog(context: context, builder: (BuildContext context){
              return AlertDialog(
                title: Text("Başarılı"),
                content: Text("Hatıra başarıyla gönderildi"),
                actions: [
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                    _refreshPage();
                  }, child: Text("Tamam"))
                ],
              );
            });
            
          } else if (state is MemorySubmitError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Hata: ${state.error}'),
              ),
            );
          }
        },
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5),
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
                SizedBox(height: 5),
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
                      selectedCity =
                          null; // Eyalet değiştiğinde şehir sıfırlanır
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Lütfen bir eyalet seçin';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 5),
                Text("Şehir", style: AppTextTheme.kLabelStyle),
                CustomDropdownField(
                  value: selectedCity,
                  items:
                      selectedState != null && cities.containsKey(selectedState)
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
                SizedBox(height: 5),
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                  minLines: 5, // Minimum 5 satır genişlik
                  maxLines: null, // İçerik arttıkça genişleyecek
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: _pickImage, // Resim seçme işlevini çağırın
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
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
                        SizedBox(width: 8),
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
    );
  }

  Future<void> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedImage;
    });
  }

  void _submitMemory() {
    if (_formKey.currentState!.validate() && isChecked) {
      BlocProvider.of<MemoryBloc>(context).add(SubmitMemory(
        name: nameController.text,
        surname: surnameController.text,
        state: selectedState!,
        city: selectedCity!,
        memory: memoryController.text,
        imageUrl: image?.path ?? '', // image null ise boş string gönder
      ));
    }
  }


  void _refreshPage() {
    // setState içinde sayfanın yenilenmiş halini göstermek için gerekli işlemleri yapın
    // Örneğin, formu temizlemek için controller'ları sıfırlayabilirsiniz:
    nameController.clear();
    surnameController.clear();
    memoryController.clear();
    selectedState = null;
    selectedCity = null;
    isChecked = false;
    image = null;
  }

}
