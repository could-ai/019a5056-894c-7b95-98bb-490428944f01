import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BALAK-AI Global',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers
  final _nameController = TextEditingController();
  final _countryOfOriginController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _graduationYearController = TextEditingController();
  final _marksController = TextEditingController();
  final _testScoresController = TextEditingController();
  final _budgetController = TextEditingController();
  final _preferredCountriesController = TextEditingController();
  String? _programLevel;

  @override
  void dispose() {
    _nameController.dispose();
    _countryOfOriginController.dispose();
    _qualificationController.dispose();
    _graduationYearController.dispose();
    _marksController.dispose();
    _testScoresController.dispose();
    _budgetController.dispose();
    _preferredCountriesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BALAK-AI Global Counselor'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Please enter your profile details',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _countryOfOriginController,
                  decoration: const InputDecoration(
                    labelText: 'Country of Origin',
                    border: OutlineInputBorder(),
                  ),
                   validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your country of origin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _qualificationController,
                  decoration: const InputDecoration(
                    labelText: 'Highest Qualification',
                    border: OutlineInputBorder(),
                  ),
                   validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your qualification';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _graduationYearController,
                  decoration: const InputDecoration(
                    labelText: 'Year of Graduation',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                   validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your graduation year';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _marksController,
                  decoration: const InputDecoration(
                    labelText: 'Marks (%)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                   validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your marks';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _testScoresController,
                  decoration: const InputDecoration(
                    labelText: 'Test Scores (e.g., IELTS: 7.0, TOEFL: 95)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _budgetController,
                  decoration: const InputDecoration(
                    labelText: 'Budget (e.g., 25000 USD)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _preferredCountriesController,
                  decoration: const InputDecoration(
                    labelText: 'Preferred Countries (comma-separated)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _programLevel,
                  decoration: const InputDecoration(
                    labelText: 'Program Level',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Foundation', 'Undergraduate (UG)', 'Postgraduate (PG)']
                      .map((label) => DropdownMenuItem(
                            child: Text(label),
                            value: label,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _programLevel = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a program level';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Process data
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data...')),
                        );
                        // For now, just show a snackbar.
                        // Later, navigate to a results screen.
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      textStyle: const TextStyle(fontSize: 18),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    child: const Text('Get Recommendations'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
