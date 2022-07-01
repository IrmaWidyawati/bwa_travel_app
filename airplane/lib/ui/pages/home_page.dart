import 'package:airplane/cubit/auth_cubit.dart';
import 'package:airplane/cubit/destination_cubit.dart';
import 'package:airplane/models/destination_model.dart';
import 'package:airplane/shared/theme.dart';
import 'package:airplane/ui/widgets/destination_card.dart';
import 'package:airplane/ui/widgets/destination_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<DestinationCubit>().fetchDestinations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccess) {
            return Container(
              margin: EdgeInsets.only(
                  left: defaultMargin,
                  right: defaultMargin,
                  top: 30), //defaultMargin=24
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Howdy, \n${state.user.name}',
                            style: blackTextStyle.copyWith(
                              fontSize: 24,
                              fontWeight: semiBold,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text('Where to fly today?',
                              style: greyTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: light,
                              )),
                        ]),
                  ),
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage('assets/image_profile.png'))),
                  )
                ],
              ),
            );
          } else {
            return SizedBox();
          }
        },
      );
    }

    Widget popularDestinations(List<DestinationModel> destinations) {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: destinations.map((DestinationModel destination) {
              return DestinationCard(destination);
            }).toList(),
            //[
            // DestinationCard(
            //   name: 'Lake Ciliwung',
            //   city: 'Tangerang',
            //   imageUrl: 'assets/image_dest1.png',
            //   rating: 4.8,
            // ),
            // DestinationCard(
            //   name: 'White Houses',
            //   city: 'Spain',
            //   imageUrl: 'assets/image_dest2.png',
            //   rating: 4.7,
            // ),
            // DestinationCard(
            //   name: 'Hill Heyo',
            //   city: 'Monaco',
            //   imageUrl: 'assets/image_dest3.png',
            //   rating: 4.8,
            // ),
            // DestinationCard(
            //   name: 'Menarra',
            //   city: 'Japan',
            //   imageUrl: 'assets/image_dest4.png',
            //   rating: 5.0,
            // ),
            // DestinationCard(
            //   name: 'Payung Teduh',
            //   city: 'Singapore',
            //   imageUrl: 'assets/image_dest5.png',
            //   rating: 4.8,
            // ),
            //],
          ),
        ),
      );
    }

    // Widget newDestinations() {
    Widget newDestinations(List<DestinationModel> destinations) {
      return Container(
        margin: EdgeInsets.only(
            top: 30, left: defaultMargin, right: defaultMargin, bottom: 100),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('New This Year',
              style:
                  blackTextStyle.copyWith(fontSize: 18, fontWeight: semiBold)),
          Column(
              children: destinations.map((DestinationModel destination) {
            return DestinationTile(destination);
          }).toList()),
          // DestinationTile(
          //     name: 'Danau Beratan',
          //     city: 'Singaraja',
          //     imageUrl: 'assets/image_dest6.png',
          //     rating: 4.6),
          // DestinationTile(
          //     name: 'Sidney Opera',
          //     city: 'Australia',
          //     imageUrl: 'assets/image_dest7.png',
          //     rating: 4.7),
          // DestinationTile(
          //     name: 'Roma',
          //     city: 'Italy',
          //     imageUrl: 'assets/image_dest8.png',
          //     rating: 4.8),
          // DestinationTile(
          //     name: 'Payung Teduh',
          //     city: 'Singapore',
          //     imageUrl: 'assets/image_dest5.png',
          //     rating: 4.5),
          // DestinationTile(
          //     name: 'Hill Hey',
          //     city: 'Monaco',
          //     imageUrl: 'assets/image_dest3.png',
          //     rating: 4.7
          //    ),
        ]),
      );
    }

    return BlocConsumer<DestinationCubit, DestinationState>(
      listener: (context, state) {
        if (state is DestinationFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(backgroundColor: kPinkColor, content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        if (state is DestinationSuccess) {
          return ListView(
            children: [
              header(),
              //popularDestinations(),
              popularDestinations(state.destinations),
              //newDestinations(),
              newDestinations(state.destinations),
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
