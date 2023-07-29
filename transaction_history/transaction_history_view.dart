import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:smartpay/core/service/dependency_injection.dart';
import 'package:smartpay/features/domain/entities/transaction_history_args.dart';
import 'package:smartpay/features/presentation/bloc/base_bloc.dart';
import 'package:smartpay/features/presentation/bloc/base_event.dart';
import 'package:smartpay/features/presentation/bloc/base_state.dart';
import 'package:smartpay/features/presentation/bloc/transaction_history/transaction_history_state.dart';
import 'package:smartpay/features/presentation/common/appbar.dart';
import 'package:smartpay/features/presentation/views/base_view.dart';
import 'package:smartpay/features/presentation/views/transaction_history/transaction_filter_view.dart';
import 'package:smartpay/utils/app_colors.dart';
import 'package:smartpay/utils/app_constants.dart';
import 'package:smartpay/utils/navigation_routes.dart';

import '../../../../utils/app_images.dart';
import '../../../data/models/response/transaction_history_response.dart';
import '../../../domain/usecases/tansaction_history/widget/history_item_ui.dart';
import '../../bloc/transaction_history/transaction_history_bloc.dart';
import '../../bloc/transaction_history/transaction_history_event.dart';
import '../../common/app_switch_chip.dart';

class TransactionHistoryView extends BaseView {
  TransactionHistoryView({Key? key}) : super(key: key);

  @override
  State<TransactionHistoryView> createState() => _TransactionHistoryViewState();
}

class _TransactionHistoryViewState
    extends BaseViewState<TransactionHistoryView> {
  final _bloc = injection<TransactionHistoryBloc>();
  List<TransactionHistoryItemData> historyData = [];
  ApplyFilterArgs? filterData;
  int _userType = 1;
  bool _isFilterAvailable = false;
  List<Map<dynamic, String>> chipsList = [];

  String _getHistoryType() {
    return _userType == 1
        ? AppConstants.historyTypeCustomer
        : AppConstants.historyTypeMerchant;
  }

  @override
  void initState() {
    _bloc.add(
      GetTransactionHistoryDataEvent(
        historyType: _getHistoryType(),
        historyMode: AppConstants.HISTORY_DEFAULT,
      ),
    );
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: SmartpayAppBar(title: 'Transaction History'),
      body: BlocProvider<TransactionHistoryBloc>(
        create: (context) => _bloc,
        child: BlocListener<TransactionHistoryBloc,
            BaseState<TransactionHistoryState>>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is TransactionHistorySuccessState) {
              setState(() {
                historyData.clear();
                historyData.addAll(state.historyData);
              });
            } else if (state is TransactionHistoryFailedState) {
              setState(() {
                historyData.clear();
              });
            }
          },
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                width: double.infinity,
                child: Center(
                  child: Wrap(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _userType = 1;
                            _bloc.add(
                              GetTransactionHistoryDataEvent(
                                historyType: _getHistoryType(),
                                historyMode: AppConstants.HISTORY_DEFAULT,
                              ),
                            );
                          });
                        },
                        child: AppSwitchChip(
                          selectedIndex: _userType,
                          currentChip: 1,
                          title: 'My Wallet',
                          selectedColor: AppColors.colorPrimary,
                          textSelectedColor: AppColors.fontColorDark,
                          textUnselectedColor: AppColors.fontColorDark,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _userType = 2;
                            _bloc.add(
                              GetTransactionHistoryDataEvent(
                                historyType: _getHistoryType(),
                                historyMode: AppConstants.HISTORY_DEFAULT,
                              ),
                            );
                          });
                        },
                        child: AppSwitchChip(
                          selectedIndex: _userType,
                          currentChip: 2,
                          title: 'My Shop',
                          selectedColor: AppColors.colorPrimary,
                          textSelectedColor: AppColors.fontColorDark,
                          textUnselectedColor: AppColors.fontColorDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppConstants.UI_PADDING),
                child: Column(
                  children: [
                    chipsList.isNotEmpty
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Filters',
                                    style: TextStyle(
                                        color: AppColors.fontColorDark,
                                        fontSize: 14),
                                  ),
                                  InkResponse(
                                    onTap: () {
                                      chipsList.clear();
                                      _bloc.add(
                                        GetTransactionHistoryDataEvent(
                                          historyType: _getHistoryType(),
                                          historyMode:
                                              AppConstants.HISTORY_DEFAULT,
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Clear Filters',
                                      style: TextStyle(
                                        color: AppColors.fontColorDark,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10.0,
                              ),
                              SizedBox(
                                height: 25.0,
                                child: ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount: chipsList.length,
                                  itemBuilder: (BuildContext context, index) {
                                    final chipData = chipsList[index];
                                    return _filterChips(
                                      context,
                                      chipData['title']!,
                                      chipData['details']!,
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                            ],
                          )
                        : const SizedBox.shrink(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _isFilterAvailable
                              ? historyData.length == 1
                                  ? '1 Result'
                                  : '${historyData.length} Results'
                              : historyData.length == 1
                                  ? 'Recent Transaction'
                                  : 'Recent ${historyData.length} Transactions',
                          style: const TextStyle(
                              color: AppColors.fontColorDark,
                              fontSize: 13,
                              fontWeight: FontWeight.w400),
                        ),
                        InkResponse(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              Routes.kTransactionFilterView,
                              arguments: _getHistoryType(),
                            ).then((value) {
                              _filterTransactionHistory(value);
                            });
                          },
                          child: SvgPicture.asset(
                            AppImages.icFilter,
                            width: 20.0,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: historyData.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(15),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, index) {
                      return HistoryItemUI(
                        itemIndex: index,
                        userType: _userType,
                        data: historyData[index],
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.kTransactionDetailView,
                            arguments: TransactionHistoryArgs(
                              walletType: _getHistoryType(),
                              txnType: historyData[index].txnType!,
                              isPaymentSuccess:
                                  historyData[index].resCode == '00' ||
                                      (historyData[index].resCode == '06' &&
                                          historyData[index].statusCode == '4'),
                              transactionHistoryItemData: historyData[index],
                              isVoidTransaction:
                                  historyData[index].voidStatus == 'Y',
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InkResponse _filterChips(BuildContext context, String title, String details) {
    return InkResponse(
      onTap: () {
        Navigator.pushNamed(
          context,
          Routes.kTransactionFilterView,
          arguments: _getHistoryType(),
        ).then((value) {
          _filterTransactionHistory(value);
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 10.0),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            color: AppColors.colorBackground,
            borderRadius: BorderRadius.circular(5)),
        child: RichText(
          textAlign: TextAlign.end,
          text: TextSpan(
            children: [
              TextSpan(
                text: title,
                style: const TextStyle(
                    fontSize: 12.5, color: AppColors.fontColorGray),
              ),
              TextSpan(
                text: details,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.fontColorDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _filterTransactionHistory(Object? value) {
    if (value != null) {
      setState(() {
        chipsList.clear();
        filterData = value as ApplyFilterArgs;
        chipsList.add({
          'title': 'From ',
          'details': DateFormat('dd-MMM-yyyy').format(filterData!.fromDate!),
        });
        chipsList.add({
          'title': 'To ',
          'details': DateFormat('dd-MMM-yyyy').format(filterData!.toDate!)
        });
      });
      if (filterData!.selectedOpt == 'range') {
        setState(() {
          chipsList.add({
            'title': 'LKR ',
            'details':
                '${filterData!.minAmount!.round()} - ${filterData!.maxAmount!.round()}',
          });
        });
        _bloc.add(
          GetTransactionHistoryDataEvent(
            historyType: _getHistoryType(),
            historyMode: _setTransactionHistoryModes(filterData!),
            fromDate: DateFormat('dd-MMM-yyyy').format(filterData!.fromDate!),
            toDate: DateFormat('dd-MMM-yyyy').format(filterData!.toDate!),
            minAmount: filterData!.minAmount,
            maxAmount: filterData!.maxAmount,
            txnType: filterData!.txnType,
            categoryCode: filterData!.categoryCode,
            billerId: filterData!.billerId,
          ),
        );
      } else {
        setState(() {
          chipsList.add({
            'title': 'LKR ',
            'details': filterData!.txnFixedAmount!.round().toString(),
          });
        });
        _bloc.add(
          GetTransactionHistoryDataEvent(
            historyType: _getHistoryType(),
            historyMode: _setTransactionHistoryModes(filterData!),
            fromDate: DateFormat('dd-MMM-yyyy').format(filterData!.fromDate!),
            toDate: DateFormat('dd-MMM-yyyy').format(filterData!.toDate!),
            txnFixedAmount: filterData!.txnFixedAmount,
            txnType: filterData!.txnType,
            categoryCode: filterData!.categoryCode,
            billerId: filterData!.billerId,
          ),
        );
      }
      if (filterData!.txnType != null) {
        chipsList.add({
          'title': '',
          'details': filterData!.txnTypeText!,
        });
      }
      if (filterData!.categoryCode != null) {
        chipsList.add({
          'title': '',
          'details': filterData!.categoryCodeText!,
        });
      }
      if (filterData!.billerId != null) {
        chipsList.add({
          'title': '',
          'details': filterData!.billerIdText!,
        });
      }
    }
  }

  _setTransactionHistoryModes(ApplyFilterArgs transactionFilterData) {
    if (transactionFilterData.selectedOpt == 'range') {
      //Range Amount
      if (transactionFilterData.txnType != null) {
        if (transactionFilterData.categoryCode != null) {
          if (transactionFilterData.billerId != null) {
            return AppConstants
                .HISTORY_BY_AMOUNT_RANGE_TXN_TYPE_BILL_CAT_SERVICE_PRO;
          } else {
            return AppConstants.HISTORY_BY_AMOUNT_RANGE_TXN_TYPE_BILL_CAT;
          }
        } else {
          return AppConstants.HISTORY_BY_AMOUNT_RANGE_TXN_TYPE;
        }
      } else {
        return AppConstants.HISTORY_BY_AMOUNT_RANGE;
      }
    } else {
      //Fixed Amount
      if (transactionFilterData.txnType != null) {
        if (transactionFilterData.categoryCode != null) {
          if (transactionFilterData.billerId != null) {
            return AppConstants
                .HISTORY_BY_FIXED_AMOUNT_TXN_TYPE_BILL_CAT_SERVICE_PRO;
          } else {
            return AppConstants.HISTORY_BY_FIXED_AMOUNT_TXN_TYPE_BILL_CAT;
          }
        } else {
          return AppConstants.HISTORY_BY_FIXED_AMOUNT_TXN_TYPE;
        }
      } else {
        return AppConstants.HISTORY_BY_FIXED_AMOUNT;
      }
    }
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}
