import 'package:flutter/material.dart';
import 'package:smartpay/features/presentation/common/app_button.dart';

import '../../../../core/service/dependency_injection.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/enums.dart';
import '../../../../utils/navigation_routes.dart';
import '../../bloc/base_bloc.dart';
import '../../bloc/base_event.dart';
import '../../bloc/base_state.dart';
import '../../bloc/splash/splash_bloc.dart';
import '../../common/app_button_outline.dart';
import '../../common/appbar.dart';
import '../base_view.dart';

class TermsNConditionsView extends BaseView {
  final bool isFromHome;

  TermsNConditionsView({this.isFromHome = false});

  @override
  State<TermsNConditionsView> createState() => _TermsNConditionsViewState();
}

class _TermsNConditionsViewState extends BaseViewState<TermsNConditionsView> {
  var bloc = injection<SplashBloc>();
  final String termsNConditions =
      'TERMS AND CONDITIONS GOVERNING THE USE OF BOC SMARTPAY APP SERVICE\n\n'
      'Bank of Ceylon (hereinafter referred to as the "Bank") shall provide subject to these Terms and Conditions online services and facility (hereinafter referred to as “SmartPay App”). By registering an account with SmartPay App or using any of the services, you agree that you have read, understood and accepted all the terms and conditions contained hereunder.'
      '\n\n'
      'By clicking on the “I Accept” button below, you accept and confirm that you have read, understood and agreed to be bound by these Terms and Conditions contained hereunder.'
      '\n\n'
      'PERSONAL IDENTIFICATION NUMBER/ BIOMETRICS DATA & ONE TIME PASSWORD\n\n'
      '1.1 I shall follow the guidance provided by the Bank in designating/creating the Personal Identification Number (PIN), Biometrics Data for identifying me the purposes of the services in SmartPay mobile Apps. PIN shall mean the original PIN confidentially created by me.'
      '\n\n'
      '1.2 The Bank may in its sole discretion require me to use a One-Time Password (OTP), which shall be transmitted through the short message service (SMS) by the Bank to my registered mobile number, for transactions that require such OTP for authentication purpose. I agree to input the OTP wherever and whenever applicable. I acknowledge and agree that I am responsible for the security of each mobile phone/number or other electronic devices used to receive SMS sent by the Bank. It is my responsibility to ensure that all electronic devices and One Time Password kept confidential and secure.'
      '\n\n'
      '1.3 I shall act in good faith, exercise reasonable care and diligence in keeping the PIN, saved Biometrics Data, electronic device/s, One-Time Password, Security Questions and the answers thereto in secrecy. At no time and under no circumstances I shall disclose the PIN or the One-Time Password, Security Questions and the answers thereto to any other person or permit the security device to come into the possession or control of any other person.'
      '\n\n'
      '1.4 I shall agree to provide access to biometrics data saved on my mobile device to facilitate the user authentication process of the SmartPay app. I shall accept full responsibility if any third party access my mobile or any other mechanism of storing the biometrics data and make changes in biometrics data that result in modifications in the user authentication process of the SmartPay app.'
      '\n\n'
      '1.5 I shall be fully responsible for any accidental or unauthorized disclosure of the PIN and/or the One Time Password or Security Questions and the answers thereto to any other person and shall bear the risks of the PIN, Biometrics Data, the One Time Password or the Security Device being used by unauthorized persons or for unauthorized purposes.'
      '\n\n'
      '1.6 Upon notice or suspicion of the PIN and/or the One Time Password being disclosed to any unauthorized person or any unauthorized use of the services being made, I shall notify the Bank in person as soon as practicable or by telephone at such telephone number(s) as the Bank may from time to time prescribe (and the Bank may ask me to confirm in writing any details given) and, until the Bank\'s actual receipt of such notification, I shall remain responsible for all  transactions made by the use of SmartPay App by unauthorized persons or for unauthorized purposes.'
      '\n\n'
      'TRANSACTIONS VIA SmartPay APP\n\n'
      '2.1 By completing SmartPay App application Form, I give my authority to accept and/or to act upon any instructions or messages received by the Bank through SmartPay App which comes from me and which are authenticated in any way.'
      '\n\n'
      '2.2 I agree to perform SmartPay App operations through the App Store/Play Store and use of specific menu options available therein.'
      '\n\n'
      '2.3 I do provide data, information, instructions and messages at my own risk. I will ensure that all data transmitted to the Bank for or in connection with SmartPay App is correct and complete. I will let the Bank know immediately about any errors, discrepancies or omissions.'
      '\n\n'
      '2.4 I shall accept full responsibility for all transactions processed or effected by the use of SmartPay App howsoever effected, and further agree that the Bank is not responsible in any manner for the transactions processed or effected by me by the use of SmartPay App.'
      '\n\n'
      '2.5 I shall accept full responsibility for all documents including but not limited to all applications, forms, Letters of Set off, Letters of Indemnity executed or processed by the use of SmartPay App.'
      '\n\n'
      '2.6 I do hereby authorize the Bank to debit my account/s linked to the SmartPay App (existing at the time of this application or linked by me subsequently) with the amount of any transaction made by the use of the SmartPay App with or without the knowledge or any further authority by me.'
      '\n\n'
      '2.7 I agree that at no time will I attempt to effect transactions executed through SmartPay App unless sufficient funds are available in my account/s. I agree that the Bank is under no obligation to honor payment instructions unless there are sufficient funds in the designated account/s at the time of receiving the payment instructions and /or at the time such payments fall due.'
      '\n\n'
      '2.8 I agree that some requests/instructions given by me are subject to authorization by officer/s of the Bank, and therefore may not be immediately and automatically effected. I further agree that the Bank reserves the right to allow or disable such requests at its discretion without notice to me.'
      '\n\n'
      '2.9 I agree that when the Bank makes a payment on behalf of me the Bank is not acting as agent or agent of the Biller to whom that payment is directed.'
      '\n\n'
      '2.10 I agree and authorize the Bank, at its discretion to record by whatever means the transactions which are effected via SmartPay App by me and that such records may be used by the Bank for the purpose of, amongst other things, establishing or verifying that a particular transaction was effected through the use of authorized PIN and/or Biometrics Data and One time password.'
      '\n\n'
      '2.11 I shall accept that Bank’s records and statements of all transactions processed by the use of the SmartPay App as conclusive and binding on me for all purposes.'
      '\n\n'
      '2.12 I acknowledge that if I apply for Debit Card, Credit Card, loan or any other product or service electronically through my SmartPay App access, the Bank will accept  such documents including but not limited to applications, forms, Letters of setoff and Letters of Indemnity  as originating from me and as legally valid, and if such documents are approved by the Bank and the requested card, product, loan or service is offered, the Terms and Conditions governing the use of such respective card, product, loan or service will be valid and binding upon me.'
      '\n\n'
      '2.13 I may link Payment Instruments from other banks/financial institutions to the SmartPay App. Once a Payment Instrument has been successfully linked to the SmartPay App, Bank of Ceylon will store the relevant account/card numbers as may be required to provide the Services of SmartPay App to me. I acknowledge that Bank of Ceylon is not a party to any agreement between me and such other bank/financial institution in relation to the payment Instruments and is not involved in issuing credit or determining eligibility for credit. Further Bank of Ceylon does not make any representation or verify that any of such Payment Instruments are in good standing or that relevant bank/financial institution will authorize or approve any Payment Transaction carried out through the SmartPay App.'
      '\n\n'
      '2.14 Use of the SmartPay App and the added / linked Payment Instruments are governed by these Terms and Conditions as well as by the applicable terms/privacy policy of the bank/financial institution where the relevant Payment Instrument is opened/issued. Nothing in these Terms and Conditions modifies such terms or privacy policy of such bank/financial institution. In the event of any inconsistency between these Terms and Conditions and the relevant bank/financial institution’s terms, these Terms and Conditions will govern the relationship between me and Bank of Ceylon, and the bank/financial institution’s terms will govern the relationship between me and such bank/financial institution.'
      '\n\n'
      '2.15 I agree that by nominating the Payment Instruments to be linked to my SmartPay App, I am consenting to Bank of Ceylon to debit and credit Payment Instruments for the purposes of utilizing the SmartPay App. I represent, warrant and undertake to Bank of Ceylon that I will ensure operating instructions relating to the Payment instruments will be consistent with my use of the SmartPay App.'
      '\n\n'
      'REFUNDS\n\n'
      'I agree that the Bank is only a facilitator in making payments to the merchants and the Bank cannot and does not take any responsibility or liability for any refunds related to non-delivery of items, which should be taken up with the merchant concerned.'
      '\n\n'
      'RESPONSIBILITIES FOR SECURITY'
      '4.1 I undertake to ensure the safety of the mobile device and to report immediately the loss of the mobile device to Bank of Ceylon.'
      '\n\n'
      '4.2 I am aware that it is my responsibility to obtain and maintain any equipment, which may be necessary for using SmartPay App, in proper working condition and with adequate safeguards against malicious threats to such equipment or to SmartPay App.'
      '\n\n'
      'I undertake to access SmartPay App only through the link provided in App Store/Play Store and not to access same using any other link.'
      '\n\n'
      '4.4 I undertake not to access SmartPay App using defective or insecure equipment, or by any manner, which might adversely affect SmartPay App.'
      '\n\n'
      '4.5 I do hereby agree to the change the PIN created by me, from time to time.'
      '\n\n'
      '4.6 I will set up and maintain adequate measures to safeguard the SmartPay App (including all information and data relating to its authentication information, biometrics data, user credentials, and payment information) from the access or use by anyone who is not authorized to do so.'
      '\n\n'
      '4.7 I shall inform the Bank immediately if I am aware of any unauthorized use of the PIN and/or Biometrics Data / other authentication modes or one-time Passwords by anyone.'
      '\n\n'
      '4.8 I acknowledge that, the Bank will not be liable for any loss incurred due to misuse of communications sent to the registered Mobile Number and/or Email Address provided by me to the Bank or due to change of any said details without prior written notice to the Bank.'
      '\n\n'
      '4.9 I accept that transmission of information through the internet/via e-mail cannot be guaranteed to be error free and /or risk free due to the inherent nature of such transmission and I further agree that the Bank shall not be liable for such errors and/or for any loss or damage that maybe suffered or incurred by me thereby.'
      '\n\n'
      '4.10 I accept and agree that the Bank will not be responsible or liable for non-availability of this service due to any technical or other defect in the registered mobile phone/s and/or disconnection of the mobile phone/s for whatsoever reason which will automatically disable me from using this service.'
      '\n\n'
      'CONFIDENTIALITY OF SMARTPAY APP SERVICE INFORMATION'
      '5.1 I shall keep my PIN, Biometrics Data, one time Password/s and security questions and answers thereto strictly confidential and undertake not to reveal such numbers/information to any person at any time or under any circumstances.'
      '\n\n'
      '5.2 I shall keep all information, techniques, data and designs relating to BOC SmartPay App completely confidential. I shall not disclose any of them to any other party.'
      '\n\n'
      '5.3 My obligations in connection with confidentiality will continue indefinitely and will not end with the expiry or termination of the facility.'
      '\n\n'
      'CHARGES AND PAYMENTS'
      '6.1 I do hereby authorize the Bank to debit my account/s with any charges relating to transactions made through SmartPay Apps and also with any other liabilities inclusive of legal fees or other statutory charges, if any, relating to the use of SmartPay App.'
      '\n\n'
      '6.2 I agree that the Bank is entitled to alter the charges for SmartPay app at any time.'
      '\n\n'
      'EXCLUSION OF BANK’S LIABILITIES'
      '7.1 I shall not hold the Bank liable for any loss incurred by the use of PIN and/or Biometrics Data and/or One Time password/s issued to me used with or without my authority. In the event of loss of the registered phone/SIM, I shall immediately inform the Bank to disable the SmartPay App. The Bank will not be liable in any manner whatsoever, for any and all losses, damages, expenses or detriment suffered or incurred by me as a result of the Bank effecting any transaction or furnishing any information via SmartPay App which may not have been originated by me, unless I had notified the Bank of the loss of phone or SIM, or any misuse thereof, prior to such transaction.'
      '\n\n'
      '7.2 The Bank shall not be responsible for any loss or damage nor for any loss of profits, loss of contracts, financial losses and loss of data or loss of goodwill incurred or suffered by me as a result of non-acceptance of and/or non-adherence to instructions given on SmartPay App for any reason whatsoever.'
      '\n\n'
      '7.3 I agree that in case of payments made for goods or services offered by third parties, the Bank cannot and does not take responsibility or liability on the quality, on time delivery or the availability of such goods or services such offered.'
      '\n\n'
      '7.4 I agree that Bank will not be responsible for the reliability or performance of any Merchant or third party provider (including telecom operators and financial institutions whose bank accounts, debit cards and credit cards are linked to the SmartPay App)'
      '\n\n'
      '7.5 By choosing to link Payment Instruments to my SmartPay App, I acknowledge and consent to the Bank to pass details of such Payment Instruments and related information to a third party for that third party to charge the same for goods or services to be supplied to me. In such cases, after passing on such details to that third party, the Bank will have no further involvement in the transaction with that third party. The Bank is not responsible for any issues arising from such third party transaction. In the case of disputes, I should contact the third party or financial institution at which such Payment Instrument has been opened or issued.'
      '\n\n'
      '7.6 I agree that Bank shall not be responsible for any and all damages/losses arising in connection with the safety, quality, accuracy, reliability, integrity or legality of any product, service, offer, loyalty program, or other items that may be stored and/or redeemed on the SmartPay App System, or of any advice, opinion, offer, proposal, statement, data or other information (collectively, "Content") displayed or distributed, purchased or paid through the SmartPay App Services System.'
      '\n\n'
      '7.7 I shall accept full responsibility for all transactions processed or effected by the use of aforesaid facilities and shall release the Bank and its employees from all claims, demands & damages arising out of or in any way connected with dispute(s).'
      '\n\n'
      'OPERATION OF SMARTPAY APP'
      '8.1 I do hereby authorize the Bank to debit any of my account/s with the amount of the transactions performed by me.'
      '\n\n'
      '8.2 I agree to use SmartPay App only for the purpose of completing the domestic transactions in Sri Lanka Rupees'
      '\n\n'
      '8.3 I agree to use SmartPay App only for lawful and legitimate purposes and to conduct the permitted transactions as specified in these Terms and Conditions'
      '\n\n'
      '8.4 I agree to use SmartPay App only for the purpose of completing personal transactions and not for the transactions with commercial intent or association.'
      '\n\n'
      '8.5 I agree to pay any charges/payments due to the Bank on transactions/functions performed by me by using SmartPay app.'
      '\n\n'
      '8.6 The Bank shall attach or detach any accounts opened in my name/s, subsequent to this application. I agree and acknowledge that such attachment or detachment can be due to prevailing rules and regulations of the Bank.'
      '\n\n'
      '8.7 The Bank shall, from time to time introduce new facilities/options into SmartPay app. I do hereby agree to abide by the terms and conditions applicable to such newly added services, facilities/options though added subsequently to the activation whether or not, I have expressly registered to avail such services.'
      '\n\n'
      '8.8 In case if the Bank requires me to register for a specific service provided by SmartPay app, I undertake to adhere to such request for registration to avail such service. I agree that any such subsequent registration becomes an integral part of the terms and conditions specified herein.'
      '\n\n'
      '8.9 I agree that the Bank or their agents may hold and process my Personal Information, Mobile device ID(s) and all other information concerning my Account(s) or otherwise in connection with the SmartPay app Services as well as for analysis, credit scoring, marketing and customer safe guard & customer security. I also agreed that the Bank may disclose, to other institutions/ Government departments/ statutory bodies/ Central Bank of Sri Lanka/ Credit Information Bureau of Sri Lanka such Personal Information as may be necessary for reasons inclusive of but not limited to participation in any telecommunication or electronic clearing network, in compliance with a legal or regulatory directives, for credit rating by recognized credit scoring agencies, for fraud prevention purposes.'
      '\n\n'
      '8.10 I will be subject to and shall comply with the applicable Merchant Limit, Transaction Limit and Daily Limit as may be imposed by Bank of Ceylon. I have the option of imposing my own Daily Limit and Transaction Limit, provided that such limits are within the applicable Merchant Limit, Transaction Limit and Daily Limit.'
      '\n\n'
      '8.11 I acknowledge that all payment transactions conducted through the SmartPay App are effected in real time. Accordingly, other than expressly specified in the terms and conditions applicable to the individual payment instruments, Bank of Ceylon does not undertake to stop or reverse any payment transaction once I have entered into it.'
      '\n\n'
      'CHANGING THE TERMS AND CONDITIONS\n\n'
      '9.1 I agree that the Bank shall at any time be entitled to amend, supplement or vary any of these terms and conditions at its absolute discretion and such amendments, supplements or variation shall be immediately binding on me.'
      '\n\n'
      '9.2 I accept and agree that the Bank has the right to determine and vary from time to time the scope and type of the services to be made available including, without limitation:'
      'Expanding, modifying or reducing the Services at any time;'
      'Imposing and varying any restrictions on the use of the services such as minimum   and maximum daily limits with respect to the value of any transaction or dealing which I may conduct by using the Services.'
      'Prescribing and changing the normal service hours during which the Services are available and any daily cutoff time for any type of services or transactions. Any of my instruction received by the Bank after any applicable daily cutoff time shall be deemed to be received on the next business day.  I agree that the Bank may specify business day and daily cutoff time by reference to the time of various services.'
      '\n\n'
      'CANCELLATION\n\n'
      '10.1 The Bank shall have the full discretion to cancel or withdraw the SmartPay App without any prior notice or any reasons given to me.'
      '\n\n'
      '10.2 In the event that I decide to terminate the use of SmartPay App, I shall give the Bank not less than seven days prior notice in writing and forthwith return any document relating to SmartPay App which are given to me by the Bank and obtain a valid receipt thereof.'
      '\n\n'
      '10.3 I shall pay any outstanding charges and/or levies, prior to deactivation or termination of the SmartPay App. Failure to do so will entitle Bank of Ceylon to debit the Bank of Ceylon Account or any other bank account linked by me with Bank of Ceylon SmartPay app to recover such charges and/or levies.'
      '\n\n'
      '10.4 If I wish to deactivate the SmartPay App, I may do so by logging onto the SmartPay App or by contacting any Branch of Bank of Ceylon or Bank of Ceylon Call Centre and following the instructions provided therein. If I wish to deactivate or remove a Mobile Device, I may do so by logging into the SmartPay App and following the instructions provided therein.'
      '\n\n'
      '10.5 If I wish to deactivate or remove any Payment Instrument from the SmartPay App, I may do so by myself or contacting Bank of Ceylon Call Centre and following the instructions provided therein'
      '\n\n'
      '10.6 The Bank shall have the right, in its sole and absolute discretion without liability to me or any third party, to suspend or terminate any one or more of the SmartPay App at any given time and for any reason whatsoever by giving ten (10) days’ notice or at any time at its discretion without prior intimation, for reasonable cause.'
      '\n\n'
      '10.7 Termination or suspension the SmartPay App will not affect my liability in respect of any transactions and any other obligations under these Terms and Conditions. On termination, the Bank reserves the right to prohibit access to the SmartPay App and to refuse future access to the SmartPay App.'
      '\n\n'
      '10.8 The Bank reserves the right, in its sole and absolute discretion without liability to me or any third party, to impose general practices and limitations concerning the use of the SmartPay App, including to restrict access to some or all of the SmartPay App.'
      '\n\n'
      '10.9 In the event that the SmartPay App is terminated for any reason other than for breach of the Terms and Conditions by me or contravention of applicable laws and regulations (including but not limited to anti money laundering legislation) by me,  the Bank will disburse any funds lying to the credit of Bank of Ceylon Bank Account (less any Charges or Levies) by way of a transfer to such account as may be specified by me(any costs relating to such transfer being borne by me or in cash where a Customer personally visits any branch of Bank of Ceylon.'
      '\n\n'
      '10.10 In the event that the SmartPay App is terminated by reason of breach of the provisions of the Terms and Conditions by me or by reason of contravention of applicable laws and regulations (including but not limited to anti money laundering legislation) by me, the will be entitled to withhold payment of funds in my Bank of Ceylon Bank Account until the completion of any investigation and/or prosecution conducted in relation thereto and/or make payments in such manner as may be prescribed by a regulatory authority.  The Bank may at its absolute discretion without prior notice cancel my access to the SmartPay App and/or refuse to provide access to me to create a new SmartPay App in the future, in the event that the Bank is of the view that the SmartPay App is being used for illegal or unauthorized activities and/or purposes.'
      '\n\n'
      '10.11 The Bank may terminate the aforesaid service/s, for any reason including limitation inactivity, violation of terms & conditions of services or other policies that the Bank may establish from time to time. Upon termination of the services, I shall remain liable for all payment transactions I have incurred. Upon termination the Bank has the right to prohibit my access to the service/s.'
      '\n\n'
      'PROPRIETARY AND OTHER RIGHTS\n\n'
      'I agree that the SmartPay App will remain the property of the Bank at all times and I will not copy the SmartPay App or any of the information, technique data or designs relating to them.'
      '\n\n'
      'INDEMNITY\n\n'
      'I do hereby agree and irrevocably hold the Bank indemnified and save harmless against any and all losses, charges, suits, claims, expenses and damages that the Bank shall or may be caused sustained, incurred or suffered by reasons of using SmartPay App by me in any manner whatsoever and for any loss and/or misdirection of data in transit electronically and/or by reasons of the Bank generating and/or issuing one time password/s according to my request and/or subsequent one time passwords to me at any request.'
      '\n\n'
      'GOVERNING LAW\n\n'
      'Any dispute or any controversy arising under or in connection with BOC SmartPay App service and/or  the terms and conditions hereof shall be governed by and construed in accordance with the laws of Sri Lanka and each of the parties hereto submits to the exclusive jurisdiction of the Courts of Sri Lanka.'
      '\n\n'
      ''
      'GENERAL TERMS AND CONDITIONS\n\n'
      '14.1 The Bank shall determine the privileges attached to the use of the aforesaid facilities and shall have absolute discretion to change, vary add or amend these privileges and conditions attached thereto, from time to time, as the Bank deems fit.'
      '\n\n'
      '14.2 To the fullest extent permissible by the Law, in no event shall the Bank be responsible or liable to me or any third party under any circumstances of direct or indirect losses/ damages. The Bank shall not have any liability for any failure or delay resulting from any conditions beyond its reasonable control.'
      '\n\n'
      '14.3 The Bank has the right to monitor and supervise transactions that take place using SmartPay App and Payment Instruments linked thereto. In the event the Bank is of the view that there are suspicious or unintended transactions taking place through the SmartPay App and/or the Payment Instruments linked thereto, the Bank reserves the right to reverse or suspend such transactions, including the right to suspend the availability of the SmartPay App without giving notice to me .  The Bank shall not be liable for restricting access to the SmartPay App in such circumstances.'
      '\n\n'
      '14.4 The Bank has the right to report suspicious transactions to the Financial Intelligence Unit (“FIU”) established under the Financial Transactions Reporting Act No. 6 of 2006 and any other law enforcement authorities and other regulators as the case may be. In the event the FIU/authority/regulator instructs the Bank not to carry out any transaction, the Bank will suspend the transaction in order to allow the FIU/authority/regulator to make necessary inquires. I will not be entitled to be informed of any action taken by the Bank in relation to the above and the Bank will not be liable or responsible to me in respect of any such action taken by Bank of Ceylon.'
      '\n\n'
      '14.5 Notifications by the Bank in relation to the SmartPay App(including changes to the Terms and Conditions, publication of fees and charges and operational instructions for the use of the SmartPay App) may be made/given by the Bank from time to time by way of text message to the registered Mobile Number, email to my registered email address, notifications through the SmartPay App, publication on the Bank of Ceylon Website or in any other manner deemed appropriate by the Bank at its sole discretion. Notifications will be binding on me immediately. I agree and consent to receive such notifications electronically and it is my responsibility to open and review such notifications of the Bank through the methods described above.'
      '\n\n'
      '14.6 The Bank shall be entitled to promote any of its products or any third party products through the SmartPay App.'
      '\n\n'
      '14.7 The Bank reserves the right to display Bank of Ceylon’s marketing material electronically on the SmartPay App.';

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: SmartpayAppBar(
        title: "Terms and Conditions",
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Please read carefully.",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              width: 30.0,
              child: Divider(
                color: AppColors.colorPrimary,
                thickness: 3.0,
              ),
            ),
            const SizedBox(height: 10.0),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      termsNConditions,
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15.0),
            Column(
              children: [
                AppButton(
                  buttonText: widget.isFromHome ? 'OK' : 'Accept',
                  textColor: AppColors.fontColorDark,
                  onTapButton: () {
                    if (widget.isFromHome) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushNamed(context, Routes.kUserSignUpView);
                    }
                  },
                ),
                widget.isFromHome
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          const SizedBox(height: 5.0),
                          AppButtonOutline(
                            appButtonStyle: AppButtonStyle.EMPTY,
                            onTapButton: () {
                              Navigator.pop(context);
                            },
                            buttonText: 'Reject',
                          ),
                        ],
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Base<BaseEvent, BaseState> getBloc() {
    return bloc;
  }
}
