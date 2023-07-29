import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:smartpay/core/service/dependency_injection.dart';
import 'package:smartpay/features/presentation/bloc/base_bloc.dart';
import 'package:smartpay/features/presentation/bloc/base_event.dart';
import 'package:smartpay/features/presentation/bloc/base_state.dart';
import 'package:smartpay/features/presentation/bloc/transaction_history/transaction_history_state.dart';
import 'package:smartpay/features/presentation/views/base_view.dart';
import 'package:smartpay/utils/app_colors.dart';
import 'package:smartpay/utils/app_constants.dart';
import 'package:smartpay/utils/enums.dart';

import '../../../../utils/app_images.dart';
import '../../../data/datasources/shared_preference.dart';
import '../../../data/models/response/transaction_filter_data_response.dart';
import '../../bloc/transaction_history/transaction_history_bloc.dart';
import '../../bloc/transaction_history/transaction_history_event.dart';
import '../../common/app_button.dart';
import '../../common/app_button_outline.dart';
import '../../common/appbar.dart';

class TransactionFilterView extends BaseView {
  final String walletType;

  TransactionFilterView({required this.walletType});

  @override
  State<TransactionFilterView> createState() => _TransactionFilterViewState();
}

class _TransactionFilterViewState extends BaseViewState<TransactionFilterView> {
  final _bloc = injection<TransactionHistoryBloc>();
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedFromDate, _selectedToDate;

  List<TxnTypeFilterData> txnFilterData = [];
  List<BillCategory> billCategoryList = [];
  List<DropdownMenuItem<String>> txnFilterDataTypes = [];
  List<DropdownMenuItem<String>> billCategoryTypes = [];
  List<DropdownMenuItem<String>> serviceProviders = [];

  String? selectedTxnType, selectedTxnTypeText;
  String? selectedBillerCategory, selectedBillerCategoryText;
  String? selectedServiceProvider, selectedServiceProviderText;
  String? enteredValue;
  String? selectedOpt = 'value';

  bool isBillerCategoriesAvailable = false;
  bool isServiceProvidersAvailable = false;

  RangeValues? _currentRangeValues;

  @override
  void initState() {
    super.initState();
    _currentRangeValues = RangeValues(
      double.parse(appSharedData.getData(MIN_TRAN_FILTER)),
      double.parse(appSharedData.getData(MAX_TRAN_FILTER)),
    );
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: SmartpayAppBar(title: "Filter by"),
      body: BlocProvider<TransactionHistoryBloc>(
        create: (context) => _bloc,
        child: BlocListener<TransactionHistoryBloc,
            BaseState<TransactionHistoryState>>(
          bloc: _bloc,
          listener: (context, state) {
            if (state is TransactionFilterDataSuccessState) {
              setState(() {
                txnFilterData.clear();
                billCategoryList.clear();
                txnFilterDataTypes.clear();
                txnFilterData.addAll(state.txnTypes);
                billCategoryList.addAll(state.billCategories);
                txnFilterDataTypes.add(const DropdownMenuItem(
                    value: "-1",
                    child: Text(
                      "Select Transaction Type",
                      style: TextStyle(color: AppColors.fontLabelGray),
                    )));
                txnFilterDataTypes.addAll(txnFilterData.map((e) =>
                    DropdownMenuItem(
                        value: e.txnTypeCode, child: Text(e.txnTypeDsc!))));
              });
            }
          },
          child: Padding(
            padding: EdgeInsets.all(AppConstants.UI_PADDING),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'From',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.fontColorDark),
                                  ),
                                  const SizedBox(height: 15.0),
                                  InkWell(
                                    onTap: () {
                                      _showFromDatePicker();
                                    },
                                    child: TextField(
                                      enabled: false,
                                      controller: _fromDateController,
                                      decoration: InputDecoration(
                                        hintText: 'YYYY-MM-DD',
                                        contentPadding:
                                            const EdgeInsets.all(10.0),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: SvgPicture.asset(
                                            AppImages.icCalender,
                                            width: 25.0,
                                          ),
                                          onPressed: () {},
                                        ),
                                        hintStyle: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 0.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'To',
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.fontColorDark),
                                  ),
                                  const SizedBox(height: 15.0),
                                  InkWell(
                                    onTap: () {
                                      _showToDatePicker();
                                    },
                                    child: TextField(
                                      enabled: false,
                                      controller: _toDateController,
                                      decoration: InputDecoration(
                                        hintText: 'YYYY-MM-DD',
                                        contentPadding:
                                            const EdgeInsets.all(10.0),
                                        disabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: SvgPicture.asset(
                                            AppImages.icCalender,
                                            width: 25.0,
                                          ),
                                          onPressed: () {},
                                        ),
                                        hintStyle: const TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 0.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Amount in LKR',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              color: AppColors.fontColorDark),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Radio(
                                  value: "value",
                                  activeColor: AppColors.colorPrimary,
                                  groupValue: selectedOpt,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOpt = value.toString();
                                    });
                                  },
                                ),
                                const Text(
                                  'Value',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.fontColorDark),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Radio(
                                  value: "range",
                                  activeColor: AppColors.colorPrimary,
                                  groupValue: selectedOpt,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedOpt = value.toString();
                                    });
                                  },
                                ),
                                const Text(
                                  'Range',
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.fontColorDark),
                                ),
                              ],
                            ),
                          ],
                        ),
                        selectedOpt == 'value'
                            ? TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  CurrencyTextInputFormatter(symbol: '')
                                ],
                                decoration: InputDecoration(
                                  hintText: '0.00',
                                  contentPadding: const EdgeInsets.all(10.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  hintStyle: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                                controller: _valueController,
                                onChanged: (value) {
                                  setState(() {
                                    enteredValue = value;
                                  });
                                },
                              )
                            : RangeSlider(
                                activeColor: AppColors.colorPrimary,
                                inactiveColor: AppColors.fontColorGray,
                                values: _currentRangeValues!,
                                max: double.parse(
                                    appSharedData.getData(MAX_TRAN_FILTER)),
                                min: double.parse(
                                    appSharedData.getData(MIN_TRAN_FILTER)),
                                labels: RangeLabels(
                                  'LKR ${_currentRangeValues!.start.round().toStringAsFixed(2)}',
                                  'LKR ${_currentRangeValues!.end.round().toStringAsFixed(2)}',
                                ),
                                onChanged: (values) {
                                  setState(() {
                                    _currentRangeValues = values;
                                  });
                                },
                              ),
                        txnFilterData.isNotEmpty &&
                                widget.walletType ==
                                    AppConstants.historyTypeCustomer
                            ? DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    isExpanded: true,
                                    items: txnFilterDataTypes,
                                    value: selectedTxnType,
                                    hint: const Text("Select Transaction Type"),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value !=
                                            txnFilterDataTypes[0].value) {
                                          selectedTxnType = value;
                                          final filterData = txnFilterData
                                              .where((element) =>
                                                  element.txnTypeCode ==
                                                  selectedTxnType)
                                              .first;
                                          selectedTxnTypeText =
                                              filterData.txnTypeDsc;
                                          if (filterData.txnTypeCode ==
                                                  AppConstants
                                                      .utilityBillPaymentFilterType ||
                                              filterData.txnTypeCode ==
                                                  AppConstants
                                                      .bocBillPaymentFilterType) {
                                            if (billCategoryList.isNotEmpty) {
                                              setState(() {
                                                isBillerCategoriesAvailable =
                                                    true;
                                                billCategoryTypes.clear();
                                                billCategoryTypes
                                                    .add(const DropdownMenuItem(
                                                        value: "-1",
                                                        child: Text(
                                                          "Select Biller Category",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .fontLabelGray),
                                                        )));
                                                billCategoryTypes.addAll(
                                                    billCategoryList.map((e) =>
                                                        DropdownMenuItem(
                                                            value:
                                                                e.categoryCode,
                                                            child: Text(e
                                                                .categoryName!))));
                                              });
                                            }
                                          }
                                        }
                                      });
                                    }),
                              )
                            : const SizedBox.shrink(),
                        isBillerCategoriesAvailable
                            ? DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    isExpanded: true,
                                    items: billCategoryTypes,
                                    value: selectedBillerCategory,
                                    hint: const Text("Select Biller Category"),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value !=
                                            billCategoryTypes[0].value) {
                                          selectedBillerCategory = value;
                                          final filterData = billCategoryList
                                              .where((element) =>
                                                  element.categoryCode ==
                                                  selectedBillerCategory)
                                              .first;
                                          selectedBillerCategoryText =
                                              filterData.categoryName;
                                          final filteredServiceProviders =
                                              filterData.billers;
                                          if (filteredServiceProviders !=
                                              null) {
                                            setState(() {
                                              isServiceProvidersAvailable =
                                                  true;
                                              serviceProviders.clear();
                                              serviceProviders
                                                  .add(const DropdownMenuItem(
                                                      value: "-1",
                                                      child: Text(
                                                        "Select Service Provider",
                                                        style: TextStyle(
                                                            color: AppColors
                                                                .fontLabelGray),
                                                      )));
                                              serviceProviders.addAll(filterData
                                                  .billers!
                                                  .map((e) => DropdownMenuItem(
                                                      value: e.billerId,
                                                      child: Text(e
                                                          .billeDisplayName!))));
                                            });
                                          }
                                        }
                                      });
                                    }),
                              )
                            : const SizedBox.shrink(),
                        isServiceProvidersAvailable
                            ? DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                    isExpanded: true,
                                    items: serviceProviders,
                                    value: selectedServiceProvider,
                                    hint: const Text(
                                      "Select Service Provider",
                                    ),
                                    onChanged: (value) {
                                      if (value != serviceProviders[0].value) {
                                        setState(() {
                                          selectedServiceProvider = value;
                                          final filterBillerData =
                                              billCategoryList
                                                  .where((element) =>
                                                      element.categoryCode ==
                                                      selectedBillerCategory)
                                                  .first;
                                          final filterServiceData =
                                              filterBillerData
                                                  .billers!
                                                  .where((element) =>
                                                      element.billerId ==
                                                      selectedServiceProvider)
                                                  .first;
                                          selectedServiceProviderText =
                                              filterServiceData
                                                  .billeDisplayName;
                                        });
                                      }
                                    }),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    AppButton(
                      buttonText: 'Apply Filter',
                      textColor: AppColors.fontColorDark,
                      buttonType: _validateDateValueRange(),
                      onTapButton: () {
                        double? fixedAmount =
                            enteredValue == null || enteredValue == ''
                                ? null
                                : double.parse(enteredValue!);
                        Navigator.pop(
                          context,
                          ApplyFilterArgs(
                            fromDate: _selectedFromDate,
                            toDate: _selectedToDate,
                            maxAmount: _currentRangeValues!.end,
                            minAmount: _currentRangeValues!.start,
                            txnFixedAmount: fixedAmount,
                            txnType: selectedTxnType,
                            txnTypeText: selectedTxnTypeText,
                            categoryCode: selectedBillerCategory,
                            categoryCodeText: selectedBillerCategoryText,
                            billerId: selectedServiceProvider,
                            billerIdText: selectedServiceProviderText,
                            selectedOpt: selectedOpt,
                          ),
                        );
                      },
                    ),
                    AppButtonOutline(
                      appButtonStyle: AppButtonStyle.EMPTY,
                      onTapButton: () {
                        setState(() {
                          txnFilterData.clear();
                          billCategoryList.clear();
                          txnFilterDataTypes.clear();
                          billCategoryTypes.clear();
                          serviceProviders.clear();
                          selectedTxnType = null;
                          selectedTxnTypeText = null;
                          selectedBillerCategory = null;
                          selectedBillerCategoryText = null;
                          selectedServiceProvider = null;
                          selectedServiceProviderText = null;
                          enteredValue = null;
                          _valueController.clear();
                          selectedOpt = 'value';
                          isBillerCategoriesAvailable = false;
                          isServiceProvidersAvailable = false;
                          _selectedFromDate = null;
                          _fromDateController.text = '';
                          _selectedToDate = null;
                          _toDateController.text = '';
                          _currentRangeValues = RangeValues(
                            double.parse(
                                appSharedData.getData(MIN_TRAN_FILTER)),
                            double.parse(
                                appSharedData.getData(MAX_TRAN_FILTER)),
                          );
                        });
                      },
                      buttonText: 'Reset All',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _showFromDatePicker() async {
    await showDatePicker(
      context: context,
      initialDate: _selectedToDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: _selectedToDate ?? DateTime.now(),
    ).then((date) {
      if (date != null) {
        setState(() {
          _selectedFromDate = date;
          _fromDateController.text = DateFormat('yyyy-MM-dd').format(date);
        });

        if (_selectedToDate != null) {
          _bloc.add(
            GetTransactionFilterDataEvent(
                walletType: widget.walletType.toString(),
                fromDate: _selectedFromDate!,
                toDate: _selectedToDate!),
          );
        }
      }
    });
  }

  _showToDatePicker() async {
    await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: _selectedFromDate ?? DateTime(2020),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date != null) {
        setState(() {
          _selectedToDate = date;
          _toDateController.text = DateFormat('yyyy-MM-dd').format(date);
        });

        if (_selectedFromDate != null) {
          _bloc.add(
            GetTransactionFilterDataEvent(
                walletType: widget.walletType,
                fromDate: _selectedFromDate!,
                toDate: _selectedToDate!),
          );
        }
      }
    });
  }

  _validateDateValueRange() {
    if (selectedOpt == 'value') {
      if (_selectedFromDate == null ||
          _selectedToDate == null ||
          enteredValue == null ||
          enteredValue == '') {
        return ButtonType.DISABLED;
      } else {
        return ButtonType.ENABLED;
      }
    } else {
      if (_selectedFromDate == null || _selectedToDate == null) {
        return ButtonType.DISABLED;
      } else {
        return ButtonType.ENABLED;
      }
    }
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return _bloc;
  }
}

class ApplyFilterArgs {
  DateTime? fromDate;
  DateTime? toDate;
  double? txnFixedAmount;
  double? minAmount;
  double? maxAmount;
  String? txnType;
  String? txnTypeText;
  String? categoryCode;
  String? categoryCodeText;
  String? billerId;
  String? billerIdText;
  String? selectedOpt;

  ApplyFilterArgs({
    this.fromDate,
    this.toDate,
    this.txnFixedAmount,
    this.minAmount,
    this.maxAmount,
    this.txnType,
    this.txnTypeText,
    this.categoryCode,
    this.categoryCodeText,
    this.billerId,
    this.billerIdText,
    this.selectedOpt,
  });
}
