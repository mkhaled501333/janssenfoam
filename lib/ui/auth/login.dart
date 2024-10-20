import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:janssenfoam/controllers/main_controller.dart';
import 'package:janssenfoam/core/recources/publicVariables.dart';
import 'package:janssenfoam/data/sharedprefs.dart';
import 'package:janssenfoam/core/commen/errmsg.dart';
import 'package:janssenfoam/ui/auth/users_controllers.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MyloginPage extends StatelessWidget {
  MyloginPage({super.key});
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Consumer2<Users_controller, MainController>(
              builder: (context, myType, mm, child) {
                TextEditingController nameController = TextEditingController();
                TextEditingController passwordController =
                    TextEditingController();

                nameController.text = Sharedprfs.getemail() ?? '';
                passwordController.text = Sharedprfs.getpassword() ?? '';
                print(nameController.text);
                if (currentuser == null &&
                    nameController.text != '' &&
                    passwordController.text != '') {
                  myType.getuser(nameController.text, passwordController.text);
                }

                var children = <Widget>[
                  errmsg(context),
                  header(),
                  fields(nameController, passwordController),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: const Text('Login'),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            myType.getuser(nameController.text.toString(),
                                passwordController.text.toString());
                          }
                        },
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ElevatedButton(
                        child: const Text('Login Out'),
                        onPressed: () {
                          currentuser = null;
                          Sharedprfs.removeemailAndPassword();
                          passwordController.text = '';
                          nameController.text = '';
                          initialized = false;
                          myType.Refrsh_ui();
                        },
                      )),
                  const Gap(15),
                  Consumer<Users_controller>(
                    builder: (context, myType, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'اختر طريقة االاتصال',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w700),
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: true,
                                      groupValue: internet,
                                      onChanged: (onChanged) {
                                        myType.changeValOf_internet(onChanged!);
                                      }),
                                  const Text('الانترنت')
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                      value: false,
                                      groupValue: internet,
                                      onChanged: (onChanged) {
                                        myType.changeValOf_internet(onChanged!);
                                      }),
                                  const Text("السيرفر")
                                ],
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  )
                ];
                return ListView(
                  children: children,
                );
              },
            ),
          )),
    );
  }

  Widget header() => Column(
        children: [
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const Text(
                ' تسجيل الدخول  ك',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: Text(
                Sharedprfs.getemail() ?? "",
                style: const TextStyle(fontSize: 20),
              )),
        ],
      );

  Widget fields(nameController, passwordController) => Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "فارغ";
                }
                return null;
              },
              controller: nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User Name',
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: TextFormField(
              validator: (value) {
                if (value!.isEmpty) {
                  return "فارغ";
                }
                return null;
              },
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
        ],
      );
}
