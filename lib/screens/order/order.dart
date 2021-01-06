import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  Razorpay _razorpay = Razorpay();
  var options = {
    'key': 'rzp_test_c0Q0CAbLzJuzhU',
    'amount': 500, //in the smallest currency sub-unit.
    'name': 'takeEazy',
    'order_id': 'order_GLYM8hYUKIKBnG', // Generate order_id using Orders API
    'description': 'Milk packet',
    'timeout': 600, // in seconds
    'prefill': {
      'contact': '8888888888',
      'email': 'test@razorpay.com'
    }
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: InkWell(
        onTap: () {
          _razorpay.open(options);
          print('PavanKalyan');
        },
        child: Container(
          color: Colors.deepOrangeAccent,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              TEText(
                text: 'CONTINUE',
                fontSize: 20,
                fontWeight: FontWeight.w900,
                fontColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/assistant.png',
                    height: 80,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TEText(
                      text: 'MeatWala Di Hatti',
                      fontSize: 20,
                      fontColor: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    TEText(
                      text: 'Meerut Cantt',
                      fontSize: 15,
                      fontColor: Colors.grey[800],
                      fontWeight: FontWeight.w800,
                    ),
                  ],
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.adjust_rounded,
                color: Colors.redAccent,
              ),
              TEText(
                text: 'Chicken Biryani',
                fontColor: Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              Container(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      icon: Icon(
                        Icons.remove,
                        color: Colors.grey,
                      ),
                      onPressed: null),
                  TEText(
                    text: '1',
                    fontColor: Colors.black,
                    fontWeight: FontWeight.w800,
                  ),
                  IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.add,
                      color: Colors.greenAccent,
                    ),
                  ),
                  TEText(
                    fontColor: Colors.black,
                    text: 'Rs.1234',
                    fontWeight: FontWeight.w600,
                  )
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              thickness: 2,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TEText(
              text: 'Any Restaurant request? We will try our best to convey',
              fontColor: Colors.black54,
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          Divider(
            color: Colors.grey[200],
            thickness: 10,
          ),
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.deepOrange[50],
                borderRadius: BorderRadius.circular(15),
                border: Border(
                  left: BorderSide(
                    color: Colors.deepOrangeAccent[100],
                  ),
                  right: BorderSide(
                    color: Colors.deepOrangeAccent[100],
                  ),
                  bottom: BorderSide(
                    color: Colors.deepOrangeAccent[100],
                  ),
                  top: BorderSide(
                    color: Colors.deepOrangeAccent[100],
                  ),
                )),
            child: ListTile(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.deepOrangeAccent[100],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: Icon(
                    Icons.check_box_outline_blank,
                    color: Colors.deepOrangeAccent,
                    size: 30,
                  ),
                  onPressed: null,
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TEText(
                  text: 'Opt in for No-contact Delivery',
                  fontSize: 20,
                  fontColor: Colors.deepOrangeAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TEText(
                  text:
                      'Our delivery partner will call(or ring your doorbell after reaching and leave the order at your door/gate(Not applicable for COD)',
                  fontSize: 15,
                  fontColor: Colors.deepOrangeAccent,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.attach_money,
                  size: 30,
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TEText(
                    text: 'Tip your delivery partner',
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  TEText(
                    text: 'How it works',
                    fontSize: 15,
                    fontColor: Color(0xff3b6e9e),
                    fontWeight: FontWeight.w700,
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(
                  top: 8.0,
                ),
                child: Column(
                  children: [
                    TEText(
                      text:
                          'Thank your delivery partner for helping you stay safe indoors. Support them through these tough times with a tip',
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TEText(
                              text: 'Rs.10',
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TEText(
                              text: 'Rs.20',
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TEText(
                              text: 'Rs.30',
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TEText(
                              text: 'Rs.40',
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Divider(
            color: Colors.grey[200],
            thickness: 10,
          ),
          ListTile(
            leading: Icon(
              Icons.attractions,
              color: Colors.black,
            ),
            title: TEText(
              text: 'APPLY COUPON',
              fontColor: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[700],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[200],
            thickness: 10,
          ),
          Divider(),
          ListTile(
            title: TEText(
              fontColor: Colors.black,
              text: 'Almost There',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            subtitle: TEText(
              text: 'Login or Sign up to place your order',
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _razorpay.clear();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(response.orderId);
    print('pavankalyan');
    _razorpay.clear();
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print(response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
}
