import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Form(
                  key: controller.formKey,
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: controller.emailTextController,
                            decoration: InputDecoration(
                              hintText: 'Email ID',
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) return 'Required*';
                              if (!value.isEmail) return 'Enter valid Email ID!';
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: controller.passwordTextController,
                            decoration: InputDecoration(
                              hintText: 'Password',
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value!.isEmpty) return 'Required*';
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton(
                              onPressed: () => controller.loginUser(),
                              child: Text('Login'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
