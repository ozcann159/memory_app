import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memory_app/bloc/memory_bloc.dart';
import 'package:memory_app/bloc/memory_event.dart';
import 'package:memory_app/bloc/memory_state.dart';

class MemoryEntryPage extends StatefulWidget {
  const MemoryEntryPage({Key? key}) : super(key: key);

  @override
  _MemoryEntryPageState createState() => _MemoryEntryPageState();
}

class _MemoryEntryPageState extends State<MemoryEntryPage> {
  final _formKey = GlobalKey<FormState>();
  late String name, surname, memory;
  String? selectedState;
  String? selectedCity;
  XFile? image;
  final List<String> states = ["Hamburg", "Bremen", "Berlin", "Hessen"];
  final Map<String, List<String>> cities = {
    "Hamburg": ["City1-1", "City2-2", "City3-3"],
    "Bremen": ["City1-1", "City2-2", "City3-3"],
    "Berlin": ["City1-1", "City2-2", "City3-3"],
    "Hessen": ["City1-1", "City2-2", "City3-3"],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hatıra Yaz'),
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Hatıra başarıyla gönderildi'),
              ),
            );
            Navigator.pop(context);
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
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'isim'),
                  onSaved: (value) => name = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen isminizi girin';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Soyisim'),
                  onSaved: (value) => surname = value!,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Lütfen soyisminizi girin';
                    }
                    return null;
                  },
                ),
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Eyalet'),
                  value: selectedState,
                  items: states.map((String state) {
                    return DropdownMenuItem<String>(
                      value: state,
                      child: Text(state),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedState = value!;
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
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(labelText: 'Şehir'),
                  value: selectedCity,
                  items: selectedState == null
                      ? []
                      : cities[selectedState]?.map((String city) {
                          return DropdownMenuItem<String>(
                            value: city,
                            child: Text(city),
                          );
                        }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedCity = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Lütfen bir şehir seçin';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Hatıra'),
                  onSaved: (value) => memory = value!,
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
                ),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Resim Ekle'),
                ),
                ElevatedButton(
                  onPressed: _submitMemory,
                  child: Text('Gönder'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      image = pickedImage!;
    });
  }

  void _submitMemory() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      BlocProvider.of<MemoryBloc>(context).add(SubmitMemory(
        name: name,
        surname: surname,
        state: selectedState!,
        city: selectedCity!,
        memory: memory,
        imageUrl: image!.path,
      ));
    }
  }
}
