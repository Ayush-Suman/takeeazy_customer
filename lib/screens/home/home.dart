import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:takeeazy_customer/controller/homecontroller.dart';
import 'package:takeeazy_customer/screens/components/customtext.dart';
import 'package:takeeazy_customer/screens/values/colors.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    Provider.of<HomeController>(context, listen: false).updateValues();

    return Scaffold(
      body: Consumer<ServiceableArea>(
        builder: (_, serACont, child) => serACont.serviceableArea
            ? ListView(
                children: [
                  Consumer<HomeController>(
                      builder: (_, hcont, child) => Padding(
                          padding: EdgeInsets.all(20),
                          child: TEText(
                            controller: hcont.city,
                            fontSize: 20,
                            fontColor: TakeEazyColors.gradient2Color,
                            fontWeight: FontWeight.w700,
                          ))),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 16),
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        fillColor: Color(0xfff3f2f2),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xff3b6e9e),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.cancel_outlined,
                            color: Color(0xff3b6e9e),
                            size: 20,
                          ),
                          onPressed: () {},
                        ),
                        hintText: ' Search for a store/item',
                        hintStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        servicesWidget(height, 'pickupanddrop'),
                        servicesWidget(height, 'assistant'),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color.fromRGBO(196, 196, 196, 0.46),
                    ),
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 14),
                          child: TEText(
                            text: 'Instant delivery to your doorstep',
                            fontColor: Color(0xff3b6e9e),
                            fontWeight: FontWeight.w500,
                            fontSize: 19,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              categoryWidget(height, 'daily Groceries', true),
                              categoryWidget(
                                  height, 'fruits and Vegetables', true),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              categoryWidget(height, 'meat and Fish', false),
                              categoryWidget(height, 'medicines', false),
                              categoryWidget(height, 'pet Care', false),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 14),
                    child: TEText(
                      text: 'Top picks for you',
                      fontColor: Color(0xff3b6e9e),
                      fontWeight: FontWeight.w500,
                      fontSize: 19,
                    ),
                  ),
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.5),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey,
                      ),
                    ),
                    itemCount: 9,
                  )
                ],
              )
            : Center(
                child: TEText(text: "We are not serviceable in your area"),
              ),
      ),
    );
  }

  Expanded categoryWidget(double height, String widgetName, bool type) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          print(widgetName);
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 5.0,
              ),
            ],
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/' + widgetName + '.png',
                  fit: BoxFit.contain,
                  height: type ? height * 0.16 : height * 0.13,
                  errorBuilder: (context, error, stackTrace) => TEText(
                      text: widgetName[0].toUpperCase() +
                          widgetName.substring(1)),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(bottom: 5, top: 2, right: 1, left: 1),
                child: TEText(
                  text: widgetName[0].toUpperCase() + widgetName.substring(1),
                  fontColor: Color(0xff3b6e9e),
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded servicesWidget(double height, String widgetName) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          print(widgetName);
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                'assets/' + widgetName + '.png',
                fit: BoxFit.contain,
                height: height * 0.16,
                errorBuilder: (context, error, stackTrace) => TEText(
                    text:
                        widgetName[0].toUpperCase() + widgetName.substring(1)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
