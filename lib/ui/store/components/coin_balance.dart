import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jals/ui/store/view_models/coin_balance_viewmodel.dart';
import 'package:jals/utils/locator.dart';
import 'package:jals/utils/size_config.dart';
import 'package:stacked/stacked.dart';

class CoinBalance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CoinBalanceViewModel>.reactive(
      onModelReady: (model) => model.getWalletBalance(),
      disposeViewModel: false,
      builder: (context, model, child) {
        return GestureDetector(
          onTap: () {
            model.navigateToWalletView();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              // vertical: getProportionatefontSize(5),
              horizontal: getProportionatefontSize(20),
            ),
            decoration: BoxDecoration(
              color: Color(0xffFCF7E4),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (model.isBusy) ...[
                  CircleAvatar(
                    radius: 4,
                    backgroundColor: Colors.red,
                  ),
                  SizedBox(width: 5),
                ],
                Text(
                  "${model.coins}",
                  style: GoogleFonts.sourceSansPro(
                    fontSize: getProportionatefontSize(12.7),
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                    color: Color(0xffC16029),
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.add_circle_outline,
                  color: Color(0xffC16029),
                )
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => locator<CoinBalanceViewModel>(),
    );
  }
}
