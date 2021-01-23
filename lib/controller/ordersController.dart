import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:takeeazy_customer/model/navigator/navigatorservice.dart';
import 'package:takeeazy_customer/model/takeeazyapis/cart/cartmodel.dart';
import 'package:takeeazy_customer/screens/bottomnav/bottonnav.dart';

class ListController with ChangeNotifier {
  List<Map> _orderDetails = [];

  void setDetails(List<Map<String, List<CartModel>>> orderDetails) {
    _orderDetails = orderDetails;
  }

  List<Map<String, List<CartModel>>> get orderDetails {
    return [..._orderDetails];
  }
}

class OrdersController {
  final Razorpay _razorPay = Razorpay();
  final ListController listController = ListController();
  var options = {
    'key': 'rzp_test_c0Q0CAbLzJuzhU',
    'amount': 500, //in the smallest currency sub-unit.
    'name': 'takeEazy',
    'order_id': 'order_GLYM8hYUKIKBnG', // Generate order_id using Orders API
    'description': 'Milk packet',
    'timeout': 600, // in seconds
    'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
  };

  void initializeRazorPay() {
    _razorPay.clear();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(response.orderId);
    print('pavankalyan');
    _razorPay.clear();
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print(response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  void continuePayment() {
    _razorPay.open(options);
  }

  void updateValues() {
    List<Map> orderDetails = NavigatorService.cartArgument[CartNavigator.cart];
    Map<String, List<CartModel>> orders = Map<String, List<CartModel>>();
    for (Map order in orderDetails) {
      if (!orders.keys.contains(order['shopName'].toString()))
        orders[order['shopName'].toString()] = [];
      orders[order['shopName'].toString()].add(
        CartModel(
          id: order['id'],
          name: order['name'],
          quantity: int.parse(order['quan']),
          imageURL: order['imageURL'],
        ),
      );
    }
    print(orders);
    print("pavanKalyan");
    print(orderDetails);
  }
}
