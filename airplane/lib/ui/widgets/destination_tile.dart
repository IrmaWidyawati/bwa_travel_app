import 'package:airplane/models/destination_model.dart';
import 'package:airplane/shared/theme.dart';
import 'package:airplane/ui/pages/detail_page.dart';
import 'package:flutter/material.dart';

class DestinationTile extends StatelessWidget {
  // final String name;
  // final String city;
  // final String imageUrl;
  // final double rating;
  final DestinationModel destination;

  //const DestinationTile(
  const DestinationTile(
    this.destination, {
    Key? key,
    // required this.name,
    // required this.city,
    // required this.imageUrl,
    // this.rating = 0.0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => DetailPage(destination)));
      },
      child: Container(
        margin: EdgeInsets.only(top: 16),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              margin: EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      // image: AssetImage(
                      //   imageUrl,
                      image: NetworkImage(
                        destination.imageUrl,
                      ))),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    //name,
                    destination.name,
                    style: blackTextStyle.copyWith(
                        fontWeight: medium, fontSize: 18),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    //city,
                    destination.city,
                    style: greyTextStyle.copyWith(fontWeight: light),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(right: 2),
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/icon_star.png')))),
                Text(
                    //rating.toString(),
                    destination.rating.toString(),
                    style: blackTextStyle.copyWith(fontWeight: medium))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
