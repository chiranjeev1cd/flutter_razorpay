import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:toast/toast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Razorpay razorPay;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    razorPay = new Razorpay();
//event listners, handlers for payment operations
    razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorPay.clear();
  }

//function of checkout page
  void openCheckout() {
    var options = {
      "key": "rzp_test_OooQLJdBjP9pvV",
      "amount": num.parse(textEditingController.text) * 100,
      "name": "Test App",
      "description": "payment for the product you are purchasing",
      "prefill": {
        "contact": "",
        "email": "",
      },
      "external": {
        "wallets": ["paytm"]
      }
    };
    try {
      razorPay.open(options);
    } catch (e) {
      print(e.tostring());
    }
  }

  void handlerPaymentSuccess() {
    print("payment succesful");
    Toast.show("payment succesful", context);
  }

  void handlerErrorFailure() {
    print("payment error");
  }

  void handlerExternalWallet() {
    print("external wallet payment");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Razor Pay Integration Module")),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(hintText: "Enter The Payable Amount"),
            ),
            SizedBox(
              height: 12,
            ),
            RaisedButton(
                color: Colors.black,
                child: Text(
                  "Pay Now",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  openCheckout();
                })
          ],
        ),
      ),
    );
  }
}
