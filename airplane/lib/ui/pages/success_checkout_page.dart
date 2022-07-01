import 'package:airplane/cubit/page_cubit.dart';
import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessCheckoutPage extends StatelessWidget {
  const SuccessCheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              margin: EdgeInsets.only(bottom: 80),
              width: 300,
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image_success.png'),
                ),
              ),
            ),
            Text('Well Booked 😍',
                style: blackTextStyle.copyWith(
                    fontSize: 32, fontWeight: semiBold)),
            SizedBox(height: 10),
            Text(
              'Are you ready to explore the new\nworld of experiences?',
              style: greyTextStyle.copyWith(fontSize: 16, fontWeight: light),
              textAlign: TextAlign.center,
            ),

            // CustomButton(
            //   title: 'Continue to Checkout',
            //   width: 220,
            //   margin: EdgeInsets.only(top: 50, bottom: 46),
            //   onPressed: () {
            //     Navigator.pushNamedAndRemoveUntil(
            //         context, '/main', (route) => false);
            //   },
            // ),
            Container(
              width: 220,
              height: 55,
              margin: EdgeInsets.only(top: 50, bottom: 46),
              child: TextButton(
                onPressed: () {
                  context.read<PageCubit>().setPage(1);
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/main', (route) => false);
                },
                style: TextButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(defaultRadius))),
                child: Text(
                  'My Bookings',
                  style:
                      whiteTextStyle.copyWith(fontSize: 18, fontWeight: medium),
                ),
              ),
            )
          ]),
        ));
  }
}
