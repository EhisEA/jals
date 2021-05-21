import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:jals/ui/shop/view_models/payment_page_viewmodel.dart';
import 'package:jals/utils/colors_utils.dart';
import 'package:jals/utils/size_config.dart';
import 'package:jals/utils/ui_helper.dart';
import 'package:jals/widgets/button.dart';
import 'package:jals/widgets/retry.dart';
import 'package:stacked/stacked.dart';

class PaymentPageWithTokenView extends StatelessWidget {
  final int coins;

  const PaymentPageWithTokenView({Key key, this.coins}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ViewModelBuilder<PaymentPageViewModel>.reactive(
        viewModelBuilder: () => PaymentPageViewModel(),
        onModelReady: (model) {
          model.initialize();
        },
        builder: (context, model, _) {
          return SafeArea(
            child: Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    TopBox(
                      coins: coins,
                    ),
                    SizedBox(
                      height: getProportionatefontSize(30),
                    ),
                    Text(
                      "What are JALS Token?",
                      style: GoogleFonts.sourceSansPro(
                        fontSize: getProportionatefontSize(20),
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0.3,
                      ),
                    ),
                    SizedBox(
                      height: getProportionatefontSize(10),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: SizeConfig.screenWidth / 8),
                      child: Text(
                        "JALS Token are used to purchase contents such as videos, audios and articles on the app.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.sourceSansPro(
                          fontSize: getProportionateAdjustedfontSize(16),
                          fontWeight: FontWeight.w400,
                          color: Color(0xff222431).withOpacity(0.68),
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionatefontSize(10),
                    ),
                    if (model.isBusy) CircularProgressIndicator(),
                    if (model.products.isEmpty && !model.isBusy) ...[
                      SizedBox(height: 30),
                      Retry(onRetry: model.initialize),
                      Text("Could not get coins: no network"),
                      SizedBox(height: 30),
                    ],
                    if (!model.isBusy)
                      Column(
                        children: List.generate(
                          model.products.length,
                          (index) => TokenPriceTile(
                            model.selected == index,
                            () => model.changeSelected(index),
                            title: model.products[index].title.replaceRange(
                              model.products[index].title.length - 19,
                              model.products[index].title.length,
                              "",
                            ),
                            price: model.products[index].price,
                          ),
                        ),
                      ),
                    SizedBox(
                      height: getProportionatefontSize(10),
                    ),
                    Container(
                      margin: UIHelper.kSidePadding,
                      child: DefaultButton(
                        color: model.selected == null
                            ? Colors.grey
                            : Color(0xff3C8AF0),
                        onPressed: () {
                          if (model.selected != null) model.buyCoin();
                        },
                        title: "Purchase JALS Token",
                      ),
                    ),
                    SizedBox(
                      height: getProportionatefontSize(40),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class TokenPriceTile extends StatelessWidget {
  final InAppPurchaseConnection _connection = InAppPurchaseConnection.instance;
  final String title, price;
  final bool selected;
  final Function onSelect;
  TokenPriceTile(
    this.selected,
    this.onSelect, {
    Key key,
    this.title,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: selected ? kPrimaryColor.shade200 : null,
      height: getProportionateAdjustedfontSize(72),
      width: SizeConfig.screenWidth,
      child: Center(
        child: ListTile(
          // tileColor: Colors.red,
          title: Text(
            title,
            style: GoogleFonts.sourceSansPro(
              fontSize: getProportionatefontSize(16),
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontStyle: FontStyle.normal,
            ),
          ),
          trailing: InkWell(
            onTap: onSelect,
            child: Container(
              height: getProportionatefontSize(36),
              width: getProportionatefontSize(94),
              constraints: BoxConstraints(
                maxHeight: 200,
                maxWidth: 200,
              ),
              child: Center(
                child: Text(
                  price ?? "\$100",
                  style: GoogleFonts.sourceSansPro(
                    fontSize: getProportionatefontSize(16),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                  color: Color(0xff3C8AF0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  )),
            ),
          ),
          leading: Image.asset(
            "icons/time.png",
            height: getProportionatefontSize(36),
          ),
        ),
      ),
    );
  }
}

class TopBox extends StatelessWidget {
  final int coins;
  const TopBox({
    Key key,
    this.coins,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: getProportionatefontSize(201),
      decoration: BoxDecoration(
        color: Color(0xffFCF7E4),
      ),
      child: Column(
        children: [
          SizedBox(
            height: getProportionatefontSize(20),
          ),
          Stack(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: InkWell(
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 16,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              // SizedBox(
              //   width: getProportionatefontSize(70),
              // ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  "Buy JALS Token",
                  style: GoogleFonts.sourceSansPro(
                    fontSize: getProportionateAdjustedfontSize(22),
                    fontWeight: FontWeight.w600,
                    color: Color(0xffC16029),
                  ),
                ),
              )
            ],
          ),
          //
          SizedBox(
            height: getProportionatefontSize(30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "icons/time.png",
                height: getProportionatefontSize(48),
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: getProportionatefontSize(15),
              ),
              Text(
                "$coins",
                style: GoogleFonts.sourceSansPro(
                  fontSize: getProportionatefontSize(32),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          Spacer(),
          Text(
            "JALS Token Balance",
            style: GoogleFonts.sourceSansPro(
              fontSize: getProportionatefontSize(12),
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: getProportionatefontSize(15),
          ),
        ],
      ),
    );
  }
}
