part of 'shared.dart';

const double defaultMargin = 24;

Color mainColor = "FFC700".toColor();
Color greyColor = "8D92A3".toColor();
Color greenColor = '1ABC9C'.toColor();
Color redColor = 'D9435E'.toColor();
Color bgColor = 'FAFAFC'.toColor();

TextStyle greyFontStyle = GoogleFonts.poppins().copyWith(color: greyColor);

TextStyle blackFontStyle1 = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500);

TextStyle blackFontStyle2 = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);

TextStyle blackFontStyle3 = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontWeight: FontWeight.w500);

TextStyle statusFontStyle = GoogleFonts.poppins().copyWith(fontSize: 10);

TextStyle whiteFontStyle = GoogleFonts.poppins().copyWith(color: Colors.white);

Widget loadingIndicator = SpinKitFadingCircle(
  size: 45,
  color: mainColor,
);

ButtonStyle mainButtonStyle = ElevatedButton.styleFrom(
  primary: mainColor,
  elevation: 0,
  onPrimary: Colors.black,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
);

ButtonStyle greyButtonStyle = ElevatedButton.styleFrom(
  primary: greyColor,
  elevation: 0,
  onPrimary: Colors.black,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
);
