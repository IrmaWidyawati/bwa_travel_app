import 'package:airplane/cubit/seat_cubit.dart';
import 'package:flutter/material.dart';
import '../../shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SeatItem extends StatelessWidget {
  final String id;

  //note
  //status 0: available
  //status 1: selected
  //status 2: unavailable

  final bool isAvailable;

  const SeatItem({Key? key, required this.id, this.isAvailable = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isSelected = context.watch<SeatCubit>().isSelected(id);

    backgroundColor() {
      if (!isAvailable) {
        return kUnavailableColor;
      } else {
        if (isSelected) {
          return kPrimaryColor;
        } else {
          return kAvailableColor;
        }
      }
    }

    borderColor() {
      if (!isAvailable) {
        return kUnavailableColor;
      } else {
        return kPrimaryColor;
      }
    }

    child() {
      if (isSelected) {
        return Center(
            child: Text('YOU',
                style: whiteTextStyle.copyWith(fontWeight: semiBold)));
      } else {
        return SizedBox();
      }
    }

    return GestureDetector(
      onTap: () {
        if (isAvailable) {
          context.read<SeatCubit>().selectSeat(id);
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 16),
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: backgroundColor(),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: borderColor(), width: 2),
        ),
        child: child(),
      ),
    );
  }
}
