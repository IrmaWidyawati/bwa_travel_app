import 'package:airplane/cubit/auth_cubit.dart';
import 'package:airplane/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/theme.dart';
import '../widgets/custom_button.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  final TextEditingController hobbyController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Text(
          'Join Us and get\nYour Next Journey',
          style: blackTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
        ),
      );
    }

    Widget inputSection() {
      Widget nameInput() {
        return CustomTextFormField(
            title: 'Full Name',
            hintText: 'Your Full Name',
            controller: nameController);
      }

      Widget emailInput() {
        return CustomTextFormField(
            title: 'Email Address',
            hintText: 'Your Email Address',
            controller: emailController);
      }

      Widget passwordInput() {
        return CustomTextFormField(
          title: 'Password',
          hintText: 'Your Password',
          obscureText: true,
          controller: passwordController,
        );
      }

      Widget hobbyInput() {
        return CustomTextFormField(
          title: 'Hobby',
          hintText: 'Your Hobby',
          controller: hobbyController,
        );
      }

      Widget submitButton() {
        // return CustomButton(
        //     title: 'Get Started',
        //     onPressed: () {
        //       Navigator.pushNamed(context, '/bonus');
        //     });
        return BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/bonus', (route) => false);
            } else if (state is AuthFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    backgroundColor: kPinkColor, content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return Container(
              width: 220,
              height: 55,
              margin: EdgeInsets.only(top: 50, bottom: 80),
              child: TextButton(
                onPressed: () {
                  context.read<AuthCubit>().signUp(
                      email: emailController.text,
                      password: passwordController.text,
                      name: nameController.text,
                      hobby: hobbyController.text);
                },
                style: TextButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius))),
                child: Text(
                  'Get Started',
                  style:
                      whiteTextStyle.copyWith(fontSize: 18, fontWeight: medium),
                ),
              ),
            );
          },
        );
      }

      return Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(defaultRadius),
          //defaultRadius=18
        ),
        child: Column(
          children: [
            nameInput(),
            emailInput(),
            passwordInput(),
            hobbyInput(),
            submitButton(),
          ],
        ),
      );
    }

    Widget signInButton() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/sign-in');
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 50, bottom: 173),
          child: Text(
            'Have an Account? Sign In',
            style: greyTextStyle.copyWith(
                fontSize: 16,
                fontWeight: light,
                decoration: TextDecoration.underline),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: defaultMargin,
          ),
          children: [title(), inputSection(), signInButton()],
        ),
      ),
    );
  }
}
