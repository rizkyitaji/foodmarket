part of 'pages.dart';

class IllustrationPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final String picturePath;
  final String buttonTitle1;
  final String buttonTitle2;
  final Function() buttonTap1;
  final Function() buttonTap2;

  IllustrationPage({
    this.title,
    this.subtitle,
    this.picturePath,
    this.buttonTitle1,
    this.buttonTitle2,
    this.buttonTap1,
    this.buttonTap2,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            margin: EdgeInsets.only(bottom: 50),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(picturePath),
              ),
            ),
          ),
          Text(title, style: blackFontStyle3.copyWith(fontSize: 20)),
          Text(
            subtitle,
            style: greyFontStyle.copyWith(fontWeight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
          Container(
            width: 200,
            height: 45,
            margin: EdgeInsets.only(top: 30, bottom: 12),
            child: ElevatedButton(
              style: mainButtonStyle,
              child: Text(buttonTitle1, style: blackFontStyle3),
              onPressed: buttonTap1,
            ),
          ),
          (buttonTap2 == null)
              ? SizedBox()
              : SizedBox(
                  width: 200,
                  height: 45,
                  child: ElevatedButton(
                    style: greyButtonStyle,
                    child: Text(
                      buttonTitle2 ?? 'Button',
                      style: whiteFontStyle,
                    ),
                    onPressed: buttonTap2,
                  ),
                ),
        ],
      ),
    );
  }
}
