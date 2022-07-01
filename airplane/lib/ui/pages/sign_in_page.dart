import 'package:airplane/cubit/auth_cubit.dart';
import 'package:airplane/ui/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/theme.dart';
import '../widgets/custom_button.dart';

class SignInPage extends StatelessWidget {
  SignInPage({Key? key}) : super(key: key);

  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Widget title() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Text(
          'Sign In with your\nexisting account',
          style: blackTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
        ),
      );
    }

    Widget inputSection() {
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
                  context, '/main', (route) => false);
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
                  context.read<AuthCubit>().signIn(
                      email: emailController.text,
                      password: passwordController.text);
                },
                style: TextButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius))),
                child: Text(
                  'Sign In',
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
            emailInput(),
            passwordInput(),
            submitButton(),
          ],
        ),
      );
    }

    Widget tcButton() {
      return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/sign-up');
        },
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 50, bottom: 173),
          child: Text(
            'Don\'t have an account? Sign Up',
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
          children: [title(), inputSection(), tcButton()],
        ),
      ),
    );
  }
}
