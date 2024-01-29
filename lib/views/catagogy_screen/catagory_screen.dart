import 'package:eshopping_app/common_widgets/bg_widget.dart';
import 'package:eshopping_app/consts/consts.dart';
import 'package:flutter/material.dart';

class CatagoryScreen extends StatelessWidget {
  const CatagoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar:
          AppBar(title: topCatagories.text.fontFamily(semibold).white.make()),
      body: Container(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200),
            itemBuilder: (context, index) {
              return Column(
                children: [],
              ).box.white.rounded.clip(Clip.antiAlias).outerShadowSm.make();
            }),
      ),
    ));
  }
}
