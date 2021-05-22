part of 'pages.dart';

class PaymentMethodPage extends StatelessWidget {
  final String paymentURL;

  PaymentMethodPage(this.paymentURL);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: mainColor,
      ),
      backgroundColor: Colors.white,
      body: IllustrationPage(
        title: "Finish Your Payment",
        subtitle: "Please select your favourite\npayment method",
        picturePath: 'assets/payment.png',
        buttonTitle1: 'Payment Method',
        buttonTap1: () async {
          await launch(paymentURL);
        },
        buttonTitle2: 'Continue',
        buttonTap2: () {
          Get.to(SuccessOrderPage());
        },
      ),
    );
  }
}
