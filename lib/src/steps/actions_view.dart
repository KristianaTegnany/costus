import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/steps/result/cubit/result_cubit.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:costus/src/widget/rounded_button.dart';
import 'package:costus/src/widget/subscribe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw;

class ActionsView extends StatelessWidget {
  const ActionsView({super.key});

  Future<void> _promptEmail(BuildContext context, String? result) {
    TextEditingController controller = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Your email?'),
          content: TextField(
            autofocus: true,
            controller: controller,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'test@email.com'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            RoundedButton(
              text: "Send",
              onPress: () {
                sendEmail(
                    recipient: controller.text,
                    subject: "Costus result",
                    body: "Result: £$result");
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void sendEmail(
      {String body = '', String subject = '', String recipient = ''}) async {
    Email email = Email(
      body: body,
      subject: subject,
      recipients: [recipient],
      //attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    FlutterEmailSender.send(email);
  }

  void generatePDF(String? result) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [
            pw.Text('Result', style: const pw.TextStyle(fontSize: 24)),
            pw.Text('£$result', style: const pw.TextStyle(fontSize: 34))
          ]),
        ),
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = FirebaseAuth.instance.currentUser != null;
    return StepLayout(
      isWhite: true,
      child:
          Center(child: BlocBuilder<StepNavigationCubit, StepNavigationState>(
        builder: (context, _) {
          return BlocBuilder<ResultCubit, ResultState>(
            builder: (_, state) {
              return SizedBox(
                width: kIsWeb ? 400 : double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RectButton(
                        primary: true,
                        text: 'Print',
                        onPress: !isConnected
                            ? null
                            : () => generatePDF(state.formatedResult)),
                    const SizedBox(
                      height: 20,
                    ),
                    RectButton(
                        primary: true,
                        text: 'Email',
                        onPress: !isConnected
                            ? null
                            : () =>
                                _promptEmail(context, state.formatedResult)),
                    const SizedBox(
                      height: 20,
                    ),
                    RectButton(
                        primary: true,
                        text: 'Share',
                        onPress: !isConnected
                            ? null
                            : () => Share.share('£${state.formatedResult}',
                                subject: 'Costus result')),
                    const SizedBox(
                      height: 20,
                    ),
                    RectButton(
                        primary: true,
                        text: 'Recalculate',
                        onPress: !isConnected
                            ? null
                            : () => context
                                .read<StepNavigationCubit>()
                                .onRecalculate()),
                    const SizedBox(
                      height: 20,
                    ),
                    RectButton(
                        primary: true,
                        text: 'Select New Method',
                        onPress: () =>
                            context.read<StepNavigationCubit>().onReset()),
                    !isConnected ? const Subscribe() : const SizedBox()
                  ],
                ),
              );
            },
          );
        },
      )),
    );
  }
}
