/*
 *
  

 *
 * /
 */

import 'package:flutter/material.dart';
import 'package:test_new/unvells/app_widgets/app_outlined_button.dart';
import 'package:test_new/unvells/app_widgets/app_text_field.dart';
import 'package:test_new/unvells/configuration/unvells_theme.dart';
import 'package:test_new/unvells/constants/app_constants.dart';
import 'package:test_new/unvells/constants/app_string_constant.dart';
import 'package:test_new/unvells/helper/app_localizations.dart';
import 'package:test_new/unvells/helper/utils.dart';

class DiscountView extends StatefulWidget {
  const DiscountView(
      {required this.discountApplied,
      required this.discountCode,
      required this.onClickApply,
      required this.onClickRemove,
      Key? key, required this.title, required this.hint})
      : super(key: key);

  final bool discountApplied;
  final String discountCode,title,hint;
  final Function(String)? onClickApply;
  final Function(String)? onClickRemove;
  @override
  State<DiscountView> createState() => _DiscountViewState();
}

class _DiscountViewState extends State<DiscountView> {
  TextEditingController codeController = TextEditingController();
  late FocusNode codeControllerNode;
  AppLocalizations? _localizations;
  final _formKey = GlobalKey<FormState>();

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations?.of(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    codeControllerNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.discountApplied) {
      codeController.text = widget.discountCode ?? "";
    } else {
      codeController.text = "";
    }
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0xFFF5F5F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),

        child: ExpansionTile(

          // childrenPadding: EdgeInsets.zero,
          leading: Icon(
            Icons.discount,
            color: Theme.of(context).iconTheme.color,
          ),
          iconColor: Theme.of(context).iconTheme.color,
          childrenPadding:
              const EdgeInsets.only(left: AppSizes.size12,right:AppSizes.size12 ,bottom: AppSizes.size12),
          initiallyExpanded: false,
          title: Text(
              (_localizations?.translate(
                       widget.title,
                      ) ??
                      "")
                  .toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontSize: 14, fontWeight: FontWeight.bold)),
          children: [
            Form(
              key: _formKey,
              child: Row(
                children: [
                  Expanded(
                    child: AppTextField(
                        isDense: true,
                        isRequired: false,
                        focusNode: codeControllerNode,
                        controller: codeController,
                        readOnly: widget.discountApplied ? true : false,
                        isPassword: false,
                        validationMessage: "Please enter some text",
                        hintText: Utils.getStringValue(
                            context, widget.hint),
                        suffix: GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              if (codeController.text.isNotEmpty) {
                                if (widget.discountApplied) {
                                  widget
                                      .onClickRemove!(codeController.text);
                                } else {
                                  widget.onClickApply!(codeController.text);
                                }
                              } else {
                                codeControllerNode.requestFocus();
                              }
                            }
                          },
                          child: Container(
                            width: AppSizes.deviceWidth / 4,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius:const BorderRadius.only(
                                topRight: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              ),
                            ),
                            child: Center(
                                child: Text(
                              widget.discountApplied
                                  ? Utils.getStringValue(
                                          context, AppStringConstant.remove)
                                      .toUpperCase()
                                  : Utils.getStringValue(
                                          context, AppStringConstant.apply)
                                      .toUpperCase(),
                              style: const TextStyle(
                                color: AppColors.white,
                              ),
                            )),
                          ),
                        )
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
