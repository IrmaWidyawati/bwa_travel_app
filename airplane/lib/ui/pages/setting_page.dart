import 'package:airplane/cubit/auth_cubit.dart';
import 'package:airplane/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:airplane/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/page_cubit.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: kPinkColor, content: Text(state.error)),
          );
        } else if (state is AuthInitial) {
          context.read<PageCubit>().setPage(0);
          Navigator.pushNamedAndRemoveUntil(
              context, '/sign-in', (route) => false);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return Center(child: CircularProgressIndicator());
        }
        return Center(
          child: Container(
            width: 220,
            height: 55,
            margin: EdgeInsets.only(top: 50, bottom: 80),
            child: TextButton(
              onPressed: () {
                context.read<AuthCubit>().signOut();
              },
              style: TextButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(defaultRadius))),
              child: Text(
                'Sign Out',
                style:
                    whiteTextStyle.copyWith(fontSize: 18, fontWeight: medium),
              ),
            ),
          ),
        );
      },
    );
  }
}
