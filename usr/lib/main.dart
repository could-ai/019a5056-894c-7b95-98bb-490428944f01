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

class Profile {
  final String fullName;
  final String? phone;
  final String? email;
  final String originCountry;
  final String highestQualification;
  final String? specialization;
  final String marksPercentage;
  final int gradYear;
  final Map<String, double?> testScores; // e.g., {'IELTS': 7.0, 'TOEFL': null}
  final double budgetPerYear;
  final List<String> preferredCountries;
  final String desiredLevel;
  final List<String> specialConstraints;

  Profile({
    required this.fullName,
    this.phone,
    this.email,
    required this.originCountry,
    required this.highestQualification,
    this.specialization,
    required this.marksPercentage,
    required this.gradYear,
    required this.testScores,
    required this.budgetPerYear,
    required this.preferredCountries,
    required this.desiredLevel,
    this.specialConstraints = const [],
  });

  Map<String, dynamic> toJson() => {
    'full_name': fullName,
    'phone': phone,
    'email': email,
    'origin_country': originCountry,
    'highest_qualification': highestQualification,
    'specialization': specialization,
    'marks_percentage': marksPercentage,
    'grad_year': gradYear,
    'test_scores': testScores,
    'budget_per_year': budgetPerYear,
    'preferred_countries': preferredCountries,
    'desired_level': desiredLevel,
    'special_constraints': specialConstraints,
  };
}

class Recommendation {
  final String country;
  final String university;
  final String program;
  final String tuitionEstimate;
  final int pswYears;
  final int admissionChance;
  final String rationale;
  final List<Map<String, String>> sources;

  Recommendation({
    required this.country,
    required this.university,
    required this.program,
    required this.tuitionEstimate,
    required this.pswYears,
    required this.admissionChance,
    required this.rationale,
    required this.sources,
  });
}

class VisaSummary {
  final String country;
  final String route;
  final List<String> documents;
  final String estimatedProcessingTime;
  final List<Map<String, String>> sources;

  VisaSummary({
    required this.country,
    required this.route,
    required this.documents,
    required this.estimatedProcessingTime,
    required this.sources,
  });
}

class ResultsScreen extends StatelessWidget {
  final Profile profile;
  final List<Recommendation> recommendations;
  final Map<String, VisaSummary> visaSummaries;
  final String sopSnippet;
  final List<String> nextSteps;
  final List<String> warnings;

  const ResultsScreen({
    super.key,
    required this.profile,
    required this.recommendations,
    required this.visaSummaries,
    required this.sopSnippet,
    required this.nextSteps,
    required this.warnings,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommendations'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TL;DR: Based on your profile, here are top recommendations for ${profile.desiredLevel} in ${profile.preferredCountries.join(', ')}.', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 20),
              Text('Recommendations:', style: Theme.of(context).textTheme.titleLarge),
              ...recommendations.map((rec) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${rec.university} - ${rec.program}', style: Theme.of(context).textTheme.titleMedium),
                      Text('Tuition: ${rec.tuitionEstimate}'),
                      Text('PSW: ${rec.pswYears} years'),
                      Text('Admission Chance: ${rec.admissionChance}%'),
                      Text('Rationale: ${rec.rationale}'),
                      Text('Sources: ${rec.sources.map((s) => '${s['name']} (${s['last_checked']})').join(', ')}'),
                    ],
                  ),
                ),
              )),
              const SizedBox(height: 20),
              Text('Visa Summaries:', style: Theme.of(context).textTheme.titleLarge),
              ...visaSummaries.entries.map((entry) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${entry.key} - ${entry.value.route}'),
                      Text('Documents: ${entry.value.documents.join(', ')}'),
                      Text('Processing Time: ${entry.value.estimatedProcessingTime}'),
                      Text('Sources: ${entry.value.sources.map((s) => '${s['name']} (${s['last_checked']})').join(', ')}'),
                    ],
                  ),
                ),
              )),
              const SizedBox(height: 20),
              Text('SOP Snippet:', style: Theme.of(context).textTheme.titleLarge),
              Text(sopSnippet),
              const SizedBox(height: 20),
              Text('Next Steps:', style: Theme.of(context).textTheme.titleLarge),
              ...nextSteps.map((step) => Text('• $step')),
              if (warnings.isNotEmpty) ...[
                const SizedBox(height: 20),
                Text('Warnings:', style: Theme.of(context).textTheme.titleLarge),
                ...warnings.map((w) => Text('• $w')),
              ],
            ],
          ),
        ),
      ),
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
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _countryOfOriginController = TextEditingController();
  final _qualificationController = TextEditingController();
  final _specializationController = TextEditingController();
  final _marksController = TextEditingController();
  final _graduationYearController = TextEditingController();
  final _ieltsController = TextEditingController();
  final _pteController = TextEditingController();
  final _toeflController = TextEditingController();
  final _duolingoController = TextEditingController();
  final _budgetController = TextEditingController();
  final _preferredCountriesController = TextEditingController();
  final _constraintsController = TextEditingController();
  String? _programLevel;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _countryOfOriginController.dispose();
    _qualificationController.dispose();
    _specializationController.dispose();
    _marksController.dispose();
    _graduationYearController.dispose();
    _ieltsController.dispose();
    _pteController.dispose();
    _toeflController.dispose();
    _duolingoController.dispose();
    _budgetController.dispose();
    _preferredCountriesController.dispose();
    _constraintsController.dispose();
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
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone (optional)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email (optional)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
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
                  controller: _specializationController,
                  decoration: const InputDecoration(
                    labelText: 'Specialization (optional)',
                    border: OutlineInputBorder(),
                  ),
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
                Text('Test Scores:', style: Theme.of(context).textTheme.titleMedium),
                TextFormField(
                  controller: _ieltsController,
                  decoration: const InputDecoration(
                    labelText: 'IELTS',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _pteController,
                  decoration: const InputDecoration(
                    labelText: 'PTE',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _toeflController,
                  decoration: const InputDecoration(
                    labelText: 'TOEFL',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _duolingoController,
                  decoration: const InputDecoration(
                    labelText: 'Duolingo',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),n                const SizedBox(height: 16),
                TextFormField(
                  controller: _budgetController,
                  decoration: const InputDecoration(
                    labelText: 'Budget per Year (USD)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your budget';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _preferredCountriesController,
                  decoration: const InputDecoration(
                    labelText: 'Preferred Countries (comma-separated)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter preferred countries';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _programLevel,
                  decoration: const InputDecoration(
                    labelText: 'Program Level',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Foundation', 'Bachelor', 'Master']
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
                const SizedBox(height: 16),
                TextFormField(
                  controller: _constraintsController,
                  decoration: const InputDecoration(
                    labelText: 'Special Constraints (comma-separated, optional)',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Create Profile
                        final profile = Profile(
                          fullName: _nameController.text,
                          phone: _phoneController.text.isEmpty ? null : _phoneController.text,
                          email: _emailController.text.isEmpty ? null : _emailController.text,
                          originCountry: _countryOfOriginController.text,
                          highestQualification: _qualificationController.text,
                          specialization: _specializationController.text.isEmpty ? null : _specializationController.text,
                          marksPercentage: _marksController.text,
                          gradYear: int.parse(_graduationYearController.text),
                          testScores: {
                            'IELTS': _ieltsController.text.isEmpty ? null : double.parse(_ieltsController.text),
                            'PTE': _pteController.text.isEmpty ? null : double.parse(_pteController.text),
                            'TOEFL': _toeflController.text.isEmpty ? null : double.parse(_toeflController.text),
                            'Duolingo': _duolingoController.text.isEmpty ? null : double.parse(_duolingoController.text),
                          },
                          budgetPerYear: double.parse(_budgetController.text),
                          preferredCountries: _preferredCountriesController.text.split(',').map((s) => s.trim()).toList(),
                          desiredLevel: _programLevel!,
                          specialConstraints: _constraintsController.text.isEmpty ? [] : _constraintsController.text.split(',').map((s) => s.trim()).toList(),
                        );
                        // Mock recommendations based on profile
                        final recommendations = _getMockRecommendations(profile);
                        final visaSummaries = _getMockVisaSummaries(profile);
                        final sopSnippet = _getMockSopSnippet(profile);
                        final nextSteps = _getMockNextSteps();
                        final warnings = _getMockWarnings();
                        // Navigate to results
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultsScreen(
                              profile: profile,
                              recommendations: recommendations,
                              visaSummaries: visaSummaries,
                              sopSnippet: sopSnippet,
                              nextSteps: nextSteps,
                              warnings: warnings,
                            ),
                          ),
                        );
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

  List<Recommendation> _getMockRecommendations(Profile profile) {
    // Mock data based on profile
    return [
      Recommendation(
        country: profile.preferredCountries.first,
        university: 'University of Example',
        program: '${profile.desiredLevel} in Computer Science',
        tuitionEstimate: '\$20,000 - \$30,000',
        pswYears: 3,
        admissionChance: 75,
        rationale: 'Based on your IELTS score and GPA. Historical trends show increasing acceptances.',
        sources: [{'name': 'University site', 'url': 'https://example.edu', 'last_checked': '2025-01-01'}],
      ),
      // Add more as needed
    ];
  }

  Map<String, VisaSummary> _getMockVisaSummaries(Profile profile) {
    return {
      profile.preferredCountries.first: VisaSummary(
        country: profile.preferredCountries.first,
        route: 'SDS',
        documents: ['Passport', 'Offer Letter', 'Bank Statements'],
        estimatedProcessingTime: '2-4 weeks',
        sources: [{'name': 'Embassy site', 'url': 'https://embassy.gov', 'last_checked': '2025-01-01'}],
      ),
    };
  }

  String _getMockSopSnippet(Profile profile) {
    return '''I am applying for the ${profile.desiredLevel} program at University of Example. My background in ${profile.highestQualification} with specialization in ${profile.specialization ?? 'General'} has prepared me for this. I aim to contribute to research in AI. My IELTS score of ${profile.testScores['IELTS'] ?? 'N/A'} demonstrates my language proficiency. I am eager to immerse in the academic environment and gain international exposure. This program aligns with my career goals in technology.'''; // Mock SOP
  }

  List<String> _getMockNextSteps() {
    return ['Apply to universities', 'Prepare documents', 'Schedule IELTS retake if needed'];
  }

  List<String> _getMockWarnings() {
    return ['Recent policy change in visa processing (source: embassy.gov, last_checked: 2025-01-01)'];
  }
}
