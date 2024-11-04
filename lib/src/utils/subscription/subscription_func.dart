import 'dart:developer';
import 'dart:io' show Platform;
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

Future<void> initSubscription() async {
  await Purchases.setLogLevel(LogLevel.verbose);

  late PurchasesConfiguration configuration;
  if (Platform.isAndroid) {
    configuration = PurchasesConfiguration('appl_MyURTdMJdECQkiTMDPtEcMedZMf');
  } else if (Platform.isIOS) {
    configuration = PurchasesConfiguration('appl_MyURTdMJdECQkiTMDPtEcMedZMf');
  }
  await Purchases.configure(configuration);
}

void presentPaywall() async {
  Purchases.getOfferings().then((offerings){
    print(offerings.toJson());
  });
  //final paywallResult = await RevenueCatUI.presentPaywall();
  //log('Paywall result: $paywallResult');
}

void presentPaywallIfNeeded() async {
  final paywallResult = await RevenueCatUI.presentPaywallIfNeeded("pro");
  log('Paywall result: $paywallResult');
}