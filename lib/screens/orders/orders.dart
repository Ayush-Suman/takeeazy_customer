import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/ordersController.dart';
import 'package:takeeazy_customer/model/takeeazyapis/cart/cartmodel.dart';
import 'package:takeeazy_customer/screens/components/custombutton.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';

class Orders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final OrdersController ordersController =
        Provider.of(context, listen: false);
    final width = MediaQuery.of(context).size.width;
    ordersController.initializeRazorPay();
    ordersController.updateValues();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order Now',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(10.0),
        child: TEButton(
            height: 50,
            width: width,
            text: TEText(
                text: "CONTINUE",
                fontWeight: FontWeight.w700,
                fontColor: Color(0xffffffff)),
            onPressed: () async {
              ordersController.continuePayment();
            }),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ChangeNotifierProvider.value(
              value: ordersController.listController,
              builder: (context, child) {
                Map<String, List<CartModel>> orderDetails =
                    ordersController.listController.orderDetails;
                List<Widget> widgets = [];
                orderDetails.forEach(
                  (key, value) {
                    print(value.length);
                    widgets.add(Container(
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
                                text: key,
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
                    ));
                    value.forEach(
                      (cartModel) => widgets.add(
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.adjust_rounded,
                                color: Colors.redAccent,
                              ),
                              Spacer(),
                              TEText(
                                text: cartModel.name,
                                fontColor: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                              Spacer(),
                              TEText(
                                text: cartModel.quantity.toString(),
                                fontColor: Colors.black,
                                fontWeight: FontWeight.w800,
                              ),
                              Spacer(),
                              TEText(
                                fontColor: Colors.black,
                                text: 'Rs.1234',
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                    widgets.add(
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Divider(
                          thickness: 2,
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                );
                return Column(
                  children: widgets,
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TEText(
                text: 'Total: Rs.1234',
                fontColor: Colors.black54,
                fontWeight: FontWeight.w500,
                fontSize: 20,
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
      ),
    );
  }
}
