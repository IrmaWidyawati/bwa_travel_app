import 'package:airplane/cubit/auth_cubit.dart';
import 'package:airplane/cubit/transaction_cubit.dart';
import 'package:airplane/models/transaction_model.dart';
import 'package:airplane/ui/widgets/destination_tile.dart';
import 'package:flutter/material.dart';
import 'package:airplane/shared/theme.dart';
import 'package:airplane/ui/widgets/booking_details_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CheckoutPage extends StatelessWidget {
  final TransactionModel transaction;

  const CheckoutPage(this.transaction, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget route() {
      return Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              width: 291,
              height: 65,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/image_checkout.png')),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('CGK',
                      style: blackTextStyle.copyWith(
                          fontSize: 24, fontWeight: semiBold)),
                  Text('Tangerang',
                      style: greyTextStyle.copyWith(fontWeight: light))
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('TLC',
                      style: blackTextStyle.copyWith(
                          fontSize: 24, fontWeight: semiBold)),
                  Text('Ciliwung',
                      style: greyTextStyle.copyWith(fontWeight: light))
                ],
              )
            ])
          ]));
    }

    Widget bookingDetails() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //NOTE: DESTINATION TILE
            Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  margin: EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(transaction.destination.imageUrl),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.destination.name,
                        style: blackTextStyle.copyWith(
                          fontSize: 18,
                          fontWeight: medium,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        transaction.destination.city,
                        style: greyTextStyle.copyWith(
                          fontWeight: light,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      margin: EdgeInsets.only(right: 2),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/icon_star.png',
                          ),
                        ),
                      ),
                    ),
                    Text(
                      transaction.destination.rating.toString(),
                      style: blackTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            //NOTE: BOOKING DETAILS
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Text(
                'Booking Details',
                style:
                    blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
              ),
            ),
            //NOTE: BOOKING DETAILS ITEM
            BookingDetailsItem(
                title: 'Traveler',
                valueText: '${transaction.amountOfTraveler} person',
                valueColor: kBlackColor),
            BookingDetailsItem(
                title: 'Seat',
                valueText: '${transaction.selectedSeats}',
                valueColor: kBlackColor),
            BookingDetailsItem(
                title: 'Insurance',
                valueText: transaction.insurance ? 'YES' : 'NO',
                valueColor: transaction.insurance ? kGreenColor : kPinkColor),
            BookingDetailsItem(
                title: 'Refundable',
                valueText: transaction.refundable ? 'YES' : 'NO',
                valueColor: transaction.refundable ? kGreenColor : kPinkColor),
            BookingDetailsItem(
                title: 'VAT',
                valueText: '${(transaction.vat * 100).toStringAsFixed(0)}%',
                valueColor: kBlackColor),
            BookingDetailsItem(
                title: 'Price',
                valueText: NumberFormat.currency(
                  locale: 'id',
                  symbol: 'IDR',
                  decimalDigits: 0,
                ).format(transaction.price),
                valueColor: kBlackColor),
            BookingDetailsItem(
                title: 'Grand Total',
                valueText: NumberFormat.currency(
                  locale: 'id',
                  symbol: 'IDR',
                  decimalDigits: 0,
                ).format(transaction.grandTotal),
                valueColor: kPrimaryColor),
          ],
        ),
      );
    }

    Widget paymentDetails() {
      return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
        if (state is AuthSuccess) {
          return Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18), color: kWhiteColor),
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(children: [
              Text('Payment Details',
                  style: blackTextStyle.copyWith(
                      fontSize: 16, fontWeight: semiBold)),
              Container(
                margin: EdgeInsets.only(top: 16),
                child: Row(children: [
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    width: 100,
                    height: 70,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/image_card2.png'))),
                  ),
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'IDR',
                                    decimalDigits: 0)
                                .format(state.user.balance),
                            style: blackTextStyle.copyWith(
                                fontSize: 18, fontWeight: medium),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 5),
                          Text('Current Balance',
                              style: greyTextStyle.copyWith(fontWeight: light))
                        ]),
                  )
                ]),
              ),
            ]),
          );
        } else {
          return SizedBox();
        }
      });
    }

    Widget payNowButton() {
      return BlocConsumer<TransactionCubit, TransactionState>(
          listener: (context, state) {
        if (state is TransactionSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/success', (route) => false);
        } else if (state is TransactionFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: kPinkColor, content: Text(state.error)),
          );
        }
      }, builder: (context, state) {
        if (state is TransactionLoading) {
          return Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 30),
            child: CircularProgressIndicator(),
          );
        }
        return Container(
          width: 170,
          height: 55,
          margin: EdgeInsets.only(top: 30),
          child: TextButton(
            onPressed: () {
              context.read<TransactionCubit>().createTransaction(transaction);
            },
            style: TextButton.styleFrom(
                backgroundColor: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(defaultRadius))),
            child: Text(
              'Pay Now',
              style: whiteTextStyle.copyWith(fontSize: 18, fontWeight: medium),
            ),
          ),
        );
      });
    }

    Widget tcButton() {
      return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(top: 30, bottom: 30),
        child: Text(
          'Terms and Conditions',
          style: greyTextStyle.copyWith(
              fontSize: 16,
              fontWeight: light,
              decoration: TextDecoration.underline),
        ),
      );
    }

    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: ListView(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            children: [
              route(),
              bookingDetails(),
              paymentDetails(),
              payNowButton(),
              tcButton(),
            ]));
  }
}
