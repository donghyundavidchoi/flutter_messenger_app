import 'dart:io';

import 'package:flutter/material.dart';
import 'package:messenger_app/widgets/pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    File image,
    bool isLogin,
    BuildContext context,
  ) submitFn;

  const AuthForm({
    super.key,
    required this.submitFn,
    required this.isLoading,
  });

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  File _userImageFile = File('');
  BuildContext? ctx;

  void _pickedIamge(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == File('') && !_isLogin) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please pick an image.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (isValid!) {
      _formKey.currentState?.save();
      widget.submitFn(
        _userEmail,
        _userName,
        _userPassword,
        _userImageFile,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!_isLogin)
                    UserImagePicker(
                      imagePickFn: _pickedIamge,
                    ),
                  const SizedBox(
                    height: 6,
                  ),
                  TextFormField(
                    key: const ValueKey('email'),
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email Address',
                    ),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _userEmail = newValue!;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: const ValueKey('userName'),
                      decoration: const InputDecoration(
                        labelText: 'User Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return 'Please enter full name with at least 6 characters';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _userName = newValue!;
                      },
                    ),
                  TextFormField(
                    key: const ValueKey('password'),
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty || value.length < 6) {
                        return 'Passward must be at least 6 characters long';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      _userPassword = newValue!;
                    },
                  ),
                  const SizedBox(
                    height: 34,
                  ),
                  if (widget.isLoading) const CircularProgressIndicator(),
                  if (!widget.isLoading)
                    ElevatedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                    ),
                  if (!widget.isLoading)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? 'Create New Account'
                          : 'I already have an account'),
                    ),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
