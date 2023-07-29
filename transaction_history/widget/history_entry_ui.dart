import 'package:flutter/material.dart';
import 'package:smartpay/utils/app_colors.dart';

class TransactionHistoryEntry{
  final String key;
  final String data;

  TransactionHistoryEntry({required this.key, required this.data});
}

class HistoryEntryUI extends StatelessWidget {
  final TransactionHistoryEntry entry;
  HistoryEntryUI({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entry.key, style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.fontColorLightGray
          ),),
          const SizedBox(height: 5,),
          Text(entry.data, style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.fontColorDark
          ),),
        ],
      ),
    );
  }
}
