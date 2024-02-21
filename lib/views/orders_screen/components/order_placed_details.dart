import 'package:eshopping_app/consts/consts.dart';

Widget orderPlacedDetails({title1, title2, d1, d2}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "${title1}".text.semiBold.make(),
          "${d1}".text.color(redColor).make()
        ],
      ),
      SizedBox(
        width: 130,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "${title2}".text.semiBold.make(),
            "${d2}".text.color(redColor).make()
          ],
        ),
      )
    ]),
  );
}
