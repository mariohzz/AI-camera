import 'package:flutter/material.dart';
import 'package:python_project/userCreate.dart';

class UserProfilePage extends StatefulWidget {
  final UserDatabase _userDatabase;
  UserProfilePage(this._userDatabase);
  @override
  _UserProfilePageState createState() => _UserProfilePageState(this._userDatabase);
}

class _UserProfilePageState extends State<UserProfilePage> {
  final UserDatabase _userDatabase;
  _UserProfilePageState(this._userDatabase);
  late TextEditingController _nameController;
  late TextEditingController _cityController;
  late TextEditingController _clinicController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with the user's current information
    _nameController = TextEditingController();
    _cityController = TextEditingController();
    _clinicController = TextEditingController();
    _passwordController = TextEditingController();

    _getUserInfo();
  }

  Future<void> _getUserInfo() async {
    Map<String, String> userInfo = await _userDatabase.getUser();
    setState(() {
      
      _nameController.text = userInfo['name'] ?? '';
      _cityController.text = userInfo['city'] ?? '';
      _clinicController.text = userInfo['clinic'] ?? '';
      // Password field should not be pre-filled for security reasons
    });
  }

  Future<void> _updateUserInfo() async {
    String newName = _nameController.text;
    String newCity = _cityController.text;
    String newClinic = _clinicController.text;
    // Password field is not updated here for security reasons, update it separately if needed

    await _userDatabase.updateName(newName);
    await _userDatabase.updateCity(newCity);
    await _userDatabase.updateClinic(newClinic);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('User information updated successfully!')),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _cityController.dispose();
    _clinicController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      // Handle name update settings
                      // Open a dialog or navigate to a settings page for name update
                      // Implement the logic for updating the name
                    },
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_city),
              title: TextFormField(
                controller: _cityController,
                decoration: InputDecoration(
                  labelText: 'City',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      // Handle city update settings
                      // Open a dialog or navigate to a settings page for city update
                      // Implement the logic for updating the city
                    },
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.local_hospital),
              title: TextFormField(
                controller: _clinicController,
                decoration: InputDecoration(
                  labelText: 'Clinic',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.settings),
                    onPressed: () {
                      // Handle clinic update settings
                      // Open a dialog or navigate to a settings page for clinic update
                      // Implement the logic for updating the clinic
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _updateUserInfo,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
