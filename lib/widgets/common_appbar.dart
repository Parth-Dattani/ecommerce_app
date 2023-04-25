import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constant/constant.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String? leadingIcon;
  final String? title;
  final String? titleIcon;
  final VoidCallback? leadingOnTap;
  final VoidCallback? actionOnTap;
  final double? iconSize;
  final String Function(String)? onChange;
  final String? actionIcon;
  final double? actionIconSize;

  const CommonAppBar({
    Key? key,
    this.leadingIcon,
    this.iconSize,
    this.title,
    this.titleIcon,
    this.leadingOnTap,
    this.onChange,
    this.actionIcon,
    this.actionIconSize,
    this.actionOnTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        backgroundColor: ColorConfig.colorPrimary,
        elevation: 0,
        title: Text(title!, style: CustomTextStyle.appBarText),
        leading: GestureDetector(
          onTap: leadingOnTap ?? (){
            Get.back();
          },
          child: leadingIcon != null
              ? Image.asset(
            leadingIcon!,
            scale: iconSize ??  25.0,
          )
              : Container(),
        ),
      actions: [
        Row(
          children: [
            GestureDetector(
                onTap: actionOnTap ?? (){
                  //Get.back();
                },
                child: actionIcon != null ?
                Image.asset(actionIcon!, scale: actionIconSize ??  25.0,
                ) : Container()

            ) ,
          ],
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
