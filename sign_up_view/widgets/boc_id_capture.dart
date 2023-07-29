import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/app_colors.dart';
import '../../../../../utils/enums.dart';

class IdCapture extends StatelessWidget {
  final IDType idType;
  final String? image;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const IdCapture(
      {required this.idType,
        this.image,
        required this.onTap,
        required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          children: [
            InkWell(
              onTap: onTap,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              child: Container(
                height: idType == IDType.SELFIE ? 120 : 93,
                width: idType == IDType.SELFIE ? 120 : 154,
                decoration: BoxDecoration(
                  color: AppColors.colorScaffoldBackground,
                  border:
                  Border.all(color: AppColors.colorPrimary, width: 1.0),
                  borderRadius: BorderRadius.all(
                    Radius.circular(idType == IDType.SELFIE ? 100 : 3),
                  ),
                ),
                child: Center(
                  child: (image != null)
                      ? Padding(
                    padding: EdgeInsets.all(
                        idType == IDType.SELFIE ? 0 : 10.0),
                    child: idType == IDType.SELFIE
                        ? CircleAvatar(
                      radius: 100,
                      backgroundImage: FileImage(
                        File(image!),
                      ),
                    )
                        : Image.file(
                      File(image!),
                    ),
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        _uploadIcon(),
                      ),
                      const SizedBox(height: 5.0),
                      idType != IDType.SELFIE
                          ? Text(
                        idType == IDType.ID_FRONT
                            ? 'NIC Front'
                            : 'NIC Back',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
          ],
        ),
        if (image != null)
          Positioned(
            top: idType == IDType.SELFIE ? 0 : 2,
            right: idType == IDType.SELFIE ? 5 : 2,
            child: InkWell(
              onTap: onDelete,
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              child: const CircleAvatar(
                backgroundColor: AppColors.appColorAccent,
                radius: 13,
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Color(0xFFFFFFFF),
                  child: Icon(
                    Icons.close,
                    size: 15,
                    color: AppColors.appColorAccent,
                  ),
                ),
              ),
            ),
          )
        else
          const SizedBox.shrink(),
      ],
    );
  }

  String _uploadIcon() {
    switch (idType) {
      case IDType.SELFIE:
        return "images/svg/ic_doc_user.svg";
      case IDType.ID_FRONT:
        return "images/svg/ic_doc_front_id.svg";
      case IDType.ID_BACK:
        return "images/svg/ic_doc_back_id.svg";
    }
  }
}
