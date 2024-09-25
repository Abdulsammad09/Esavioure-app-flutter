import 'package:flutter/material.dart';

class Contactscreen extends StatefulWidget {
  const Contactscreen({super.key});

  @override
  _ContactscreenState createState() => _ContactscreenState();
}

class _ContactscreenState extends State<Contactscreen> {
  // Define a global key for the form
  final _formKey = GlobalKey<FormState>();

  // Controllers to capture user input
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Dispose controllers when not needed
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // Function to handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Here, you can handle the submission logic, such as sending data to a server
      // For demonstration, we'll just show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Your message has been sent!')),
      );

      // Clear the form fields
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define primary colors
    const Color primaryRed = Colors.redAccent;
    const Color primaryWhite = Colors.white;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
        backgroundColor: primaryRed, // Primary theme color
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: primaryWhite, // Background color
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Assign the form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Heading
                const Text(
                  'Get in Touch',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: primaryRed,
                  ),
                ),
                const SizedBox(height: 24),

                // Name Field
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Email Field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    // Simple email validation
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Subject Field
                TextFormField(
                  controller: _subjectController,
                  decoration: InputDecoration(
                    labelText: 'Subject',
                    prefixIcon: const Icon(Icons.subject),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a subject';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Message Field
                TextFormField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    prefixIcon: const Icon(Icons.message),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your message';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryRed, // Button color
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
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
