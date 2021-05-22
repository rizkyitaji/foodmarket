part of 'widgets.dart';

class ProfileListItem extends StatelessWidget {
  final String item;

  ProfileListItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 78,
          child: Text(item, style: blackFontStyle3),
        ),
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/right_arrow.png'),
            ),
          ),
        ),
      ],
    );
  }
}
