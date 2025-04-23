import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:signature/signature.dart';

void main() {
  runApp(MaterialApp(
    home: FlutterFormValidation(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
          .copyWith(secondary: Colors.pinkAccent),
    ),
  ));
}

class FlutterFormValidation extends StatefulWidget {
  @override
  _FlutterFormValidationState createState() => _FlutterFormValidationState();
}

class _FlutterFormValidationState extends State<FlutterFormValidation> {
  final _formKey = GlobalKey<FormState>();
  final SignatureController _signatureController = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
  );

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  String? _gender;
  String _dob = '';
  double _familyMembers = 0;
  int _stepperValue = 10;
  int _rating = 0;
  double _siteRating = 3;
  bool _termsAccepted = false;

  Map<String, bool> _languages = {
    "English": false,
    "Chinese": false,
    "Malay": false,
  };

  @override
  void dispose() {
    _fullNameController.dispose();
    _ageController.dispose();
    _signatureController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Flutter Form Validation", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.pinkAccent,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Full Name", style: TextStyle(color: Colors.black)),
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                style: TextStyle(color: Colors.black),
                validator: (value) =>
                    value == null || value.isEmpty ? "This field cannot be empty." : null,
              ),
              SizedBox(height: 16),

              Text("Date of Birth", style: TextStyle(color: Colors.black)),
              InkWell(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime(2000, 1),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: ColorScheme.light(
                            primary: Colors.pinkAccent,
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                          textButtonTheme: TextButtonThemeData(
                            style: TextButton.styleFrom(foregroundColor: Colors.pinkAccent),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (picked != null) {
                    setState(() {
                      _dob = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                    });
                  }
                },
                child: IgnorePointer(
                  child: TextFormField(
                    controller: TextEditingController(text: _dob),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 8),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                    style: TextStyle(color: Colors.black),
                    validator: (value) => value == null || value.isEmpty ? "This field cannot be empty." : null,
                  ),
                ),
              ),
              SizedBox(height: 16),

              Text("Gender", style: TextStyle(color: Colors.black)),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                value: _gender,
                items: ["Male", "Female", "Other"]
                    .map((label) => DropdownMenuItem(
                          child: Text(label, style: TextStyle(color: Colors.black)),
                          value: label,
                        ))
                    .toList(),
                onChanged: (value) => setState(() => _gender = value),
                validator: (value) => value == null ? "This field cannot be empty." : null,
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 16),

              Text("Age", style: TextStyle(color: Colors.black)),
              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                style: TextStyle(color: Colors.black),
                validator: (value) =>
                    value == null || value.isEmpty ? "This field cannot be empty." : null,
              ),
              SizedBox(height: 16),

              Text("Number of Family Members", style: TextStyle(color: Colors.black)),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: Colors.pinkAccent,
                  inactiveTrackColor: Colors.pink[100],
                  thumbColor: Colors.pink,
                  overlayColor: Colors.pink.withAlpha(32),
                  valueIndicatorColor: Colors.pinkAccent,
                ),
                child: Slider(
                  value: _familyMembers,
                  min: 0,
                  max: 10,
                  divisions: 10,
                  label: _familyMembers.toStringAsFixed(0),
                  onChanged: (value) => setState(() => _familyMembers = value),
                ),
              ),
              SizedBox(height: 16),

              Text("Rating", style: TextStyle(color: Colors.black)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(5, (index) {
                  return OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.black),
                    child: Text("${index + 1}",
                        style: TextStyle(
                            color: _rating == index + 1 ? Colors.pinkAccent : Colors.black)),
                  );
                }),
              ),
              SizedBox(height: 16),

              Row(
                children: [
                  Text("Stepper", style: TextStyle(color: Colors.black)),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.remove, color: Colors.pinkAccent),
                    onPressed: () => setState(() => _stepperValue = (_stepperValue - 1).clamp(0, 100)),
                  ),
                  Text("$_stepperValue", style: TextStyle(color: Colors.black)),
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.pinkAccent),
                    onPressed: () => setState(() => _stepperValue = (_stepperValue + 1).clamp(0, 100)),
                  ),
                ],
              ),
              SizedBox(height: 16),

              Text("Languages you know", style: TextStyle(color: Colors.black)),
              ..._languages.entries.map((entry) {
                return CheckboxListTile(
                  title: Text(entry.key, style: TextStyle(color: Colors.black)),
                  value: entry.value,
                  onChanged: (value) => setState(() => _languages[entry.key] = value!),
                  activeColor: Colors.pinkAccent,
                );
              }).toList(),

              SizedBox(height: 16),
              Text("Signature", style: TextStyle(color: Colors.black)),
              Container(
                decoration: BoxDecoration(border: Border.all()),
                height: 100,
                child: Signature(
                  controller: _signatureController,
                  backgroundColor: Colors.white,
                ),
              ),
              Row(
                children: [
                  Spacer(),
                  TextButton(
                    onPressed: () => _signatureController.clear(),
                    child: Text("Clear", style: TextStyle(color: Colors.red)),
                  ),
                ],
              ),
              SizedBox(height: 16),

              Text("Rate this site", style: TextStyle(color: Colors.black)),
              SizedBox(height: 10),
              RatingBar.builder(
                initialRating: _siteRating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(Icons.star, color: Colors.pinkAccent),
                onRatingUpdate: (rating) => setState(() => _siteRating = rating),
              ),

              CheckboxListTile(
                title: Text("I have read and agree to the terms and conditions",
                    style: TextStyle(color: Colors.black)),
                value: _termsAccepted,
                onChanged: (value) => setState(() => _termsAccepted = value!),
                activeColor: Colors.pinkAccent,
              ),
              if (!_termsAccepted)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    "You must accept terms and conditions to continue",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: 20),

              Row(
                children: [
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text("Submit"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      foregroundColor: Colors.black,
                    ),
                  ),
                  SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () {
                      _formKey.currentState?.reset();
                      _signatureController.clear();
                      _fullNameController.clear();
                      _ageController.clear();
                      setState(() {
                        _dob = '';
                        _gender = null;
                        _familyMembers = 0;
                        _stepperValue = 10;
                        _rating = 0;
                        _siteRating = 3;
                        _termsAccepted = false;
                        _languages.updateAll((key, value) => false);
                      });
                    },
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.black),
                    child: Text("Reset"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() == true && _termsAccepted) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Submitted"),
          content: Text("Form submitted successfully!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            )
          ],
        ),
      );
    } else {
      setState(() {});
    }
  }
}
