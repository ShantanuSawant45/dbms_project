import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'home_screen.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // Controllers for all fields
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _graduationYearController = TextEditingController();
  final _degreeController = TextEditingController();
  final _majorController = TextEditingController();
  final _currentCompanyController = TextEditingController();
  final _designationController = TextEditingController();
  final _experienceController = TextEditingController();
  final _linkedinController = TextEditingController();
  final _twitterController = TextEditingController();
  final _githubController = TextEditingController();
  final _skillsController = TextEditingController();
  final _bioController = TextEditingController();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    _graduationYearController.dispose();
    _degreeController.dispose();
    _majorController.dispose();
    _currentCompanyController.dispose();
    _designationController.dispose();
    _experienceController.dispose();
    _linkedinController.dispose();
    _twitterController.dispose();
    _githubController.dispose();
    _skillsController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(0.1),
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!)
                          : null,
                      child: _profileImage == null
                          ? const Icon(Icons.person,
                              size: 60, color: Colors.grey)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 18,
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt,
                              size: 18, color: Colors.white),
                          onPressed: _pickImage,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              _buildTextField(_nameController, 'Full Name', Icons.person),
              _buildTextField(_emailController, 'Email', Icons.email),
              _buildTextField(_phoneController, 'Phone Number', Icons.phone),
              _buildTextField(_addressController, 'Address', Icons.location_on),
              _buildTextField(_cityController, 'City', Icons.location_city),
              _buildTextField(_countryController, 'Country', Icons.flag),
              _buildTextField(
                  _graduationYearController, 'Graduation Year', Icons.school),
              _buildTextField(_degreeController, 'Degree', Icons.school),
              _buildTextField(
                  _majorController, 'Major/Specialization', Icons.book),
              _buildTextField(
                  _currentCompanyController, 'Current Company', Icons.business),
              _buildTextField(
                  _designationController, 'Designation', Icons.work),
              _buildTextField(
                  _experienceController, 'Years of Experience', Icons.timeline),
              _buildTextField(
                  _linkedinController, 'LinkedIn Profile', Icons.link),
              _buildTextField(
                  _twitterController, 'Twitter Profile', Icons.link),
              _buildTextField(_githubController, 'GitHub Profile', Icons.link),
              _buildTextField(_skillsController, 'Skills (comma separated)',
                  Icons.psychology),
              _buildTextField(_bioController, 'Bio', Icons.description,
                  maxLines: 3),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // if (_formKey.currentState!.validate()) {
                    //   // TODO: Implement save logic to MySQL
                    //   Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const HomeScreen()),
                    //   );
                    // }
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreen()),
                    );
                  },
                  child: const Text('Save Profile'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          prefixIcon: Icon(icon),
        ),
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $label';
          }
          return null;
        },
      ),
    );
  }
}
