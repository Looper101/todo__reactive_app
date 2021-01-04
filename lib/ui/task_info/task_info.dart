import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_stream/deviceSizeConfig/device_size_config.dart';
import 'package:todo_stream/pallete.dart';

class TaskInfo extends StatelessWidget {
  static String id = 'TaskInfoId';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.extraInactiveColor,
      body: Container(
        margin: EdgeInsets.symmetric(
          horizontal: DeviceSizeConfig.screenWidth * 0.026,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: DeviceSizeConfig.screenWidth * 0.015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lists',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: DeviceSizeConfig.longestSide * 0.04,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Add',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: DeviceSizeConfig.longestSide * 0.025),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: buildReusableCard(
                      mq: DeviceSizeConfig.mq,
                      isTrue: false,
                      title: 'Today',
                      counter: 10),
                ),
                Expanded(
                  child: buildReusableCard(
                      mq: DeviceSizeConfig.mq, title: 'This week', counter: 0),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: buildReusableCard(
                      mq: DeviceSizeConfig.mq, title: 'All', counter: 5),
                ),
                Expanded(
                  child: buildReusableCard(
                      mq: DeviceSizeConfig.mq, counter: 10, title: 'Completed'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildReusableCard(
    {MediaQueryData mq, bool isTrue = true, int counter, String title}) {
  return InkWell(
    borderRadius: BorderRadius.circular(10),
    splashColor: Pallete.activeColor,
    onTap: () {},
    child: Container(
      height: mq.size.height * 0.15,
      margin: EdgeInsets.symmetric(
          horizontal: DeviceSizeConfig.screenWidth * 0.01,
          vertical: DeviceSizeConfig.screenHeight * 0.008),
      padding: EdgeInsets.symmetric(
        horizontal: DeviceSizeConfig.screenWidth * 0.04,
        vertical: DeviceSizeConfig.screenHeight * 0.03,
      ),
      decoration: BoxDecoration(
        color: isTrue ? Pallete.activeColor : Color(0xFF343441),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            counter.toString(),
            style: TextStyle(
                fontSize: mq.size.longestSide * 0.035,
                fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: TextStyle(fontSize: mq.size.longestSide * 0.025),
          ),
        ],
      ),
    ),
  );
}
