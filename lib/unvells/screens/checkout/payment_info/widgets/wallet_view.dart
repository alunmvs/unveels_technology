import 'package:flutter/material.dart';

import '../../../../configuration/text_theme.dart';
import '../../../../constants/app_constants.dart';
import '../../../../models/checkout/payment_info/payment_info_model.dart';
import '../../../../models/wallet_extension_models/wallet_dashboard_model.dart';
import '../../../my_wallet_extension/transfer_waller_amount/view/payee_list_view.dart';

Widget showWalletView(context, List<PaymentMethods>? paymentMethods, WalletData? wallet,
    walletSelected, Function(String, bool) updatePaymentMethod) {
  return Column(
    children: List.generate(paymentMethods?.length ?? 0, (index) {
      var item = paymentMethods?[index];
      if (item?.code == AppConstant.m2Wallet) {
        return Container(
          decoration: ShapeDecoration(
            color: const Color(0xFFF5F5F5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: ListTile(
            leading: GestureDetector(
              onTap: () {
                updatePaymentMethod(item?.code ?? "", !walletSelected);
              },
              child: Icon(
                // selectedPaymentMethodCode == AppConstant.m2Wallet
                walletSelected
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: walletSelected?AppColors.gold:Colors.black,
              size: 22,),
            ),
            visualDensity: const VisualDensity(vertical: -4, horizontal: -4),
            title: Text(item?.title ?? "",
            style: KTextStyle.of(context).semiBoldSixteen,),
            subtitle: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(wallet != null)...[
                  showWalletData(context, "Available Balance", wallet.formattedAmountInWallet ?? ""),
                  const SizedBox(height: 2),
                  showWalletData(context, "Remaining Balance", wallet.formattedLeftInWallet ?? ""),
                  const SizedBox(height: 2),

                  showWalletData(context, "Payment To Be Made", wallet.formattedPaymentToMade ?? ""),
                  const SizedBox(height: 2),

                  showWalletData(context, "Left Amount To Be Paid", wallet.formattedLeftAmountToPay ?? ""),
                ]
              ],
            ),
          ),
        );
      }
      return const SizedBox();
    }),
  );
}

Widget showWalletData(context, title, body) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,

    children: [
      Text(title,
      style: Theme.of(context).textTheme?.bodySmall?.copyWith(
        fontSize: 12
      ),),
      // const Text(" : "),
      Text(body,
        style: Theme.of(context).textTheme?.bodySmall?.copyWith(
            fontSize: 12
        ),)
    ],
  );
}
