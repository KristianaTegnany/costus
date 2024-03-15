import 'package:costus/src/steps/cubit/step_navigation_cubit.dart';
import 'package:costus/src/steps/layout/step_layout.dart';
import 'package:costus/src/widget/rect_button.dart';
import 'package:costus/src/widget/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:pdf/widgets.dart' as pw;

class ActionsView extends StatelessWidget {
  const ActionsView({super.key});

  Future<void> _promptEmail(BuildContext context) {
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
                sendEmail(recipient: controller.text);
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

  void generatePDF() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(children: [
            pw.Text('Result', style: const pw.TextStyle(fontSize: 24)),
            pw.Text('£300,000', style: const pw.TextStyle(fontSize: 34))
          ]),
        ),
      ),
    );

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return StepLayout(
      isWhite: true,
      child:
          Center(child: BlocBuilder<StepNavigationCubit, StepNavigationState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RectButton(
                  primary: true, text: 'Print', onPress: () => generatePDF()),
              const SizedBox(
                height: 20,
              ),
              RectButton(
                  primary: true,
                  text: 'Email',
                  onPress: () => _promptEmail(context)),
              const SizedBox(
                height: 20,
              ),
              RectButton(
                  primary: true,
                  text: 'Share',
                  onPress: () => {Share.share('My result', subject: 'Costus')}),
              const SizedBox(
                height: 20,
              ),
              RectButton(
                  primary: true,
                  text: 'Recalculate',
                  onPress: () =>
                      context.read<StepNavigationCubit>().onRecalculate()),
              const SizedBox(
                height: 20,
              ),
              RectButton(
                  primary: true,
                  text: 'Select New Method',
                  onPress: () => context.read<StepNavigationCubit>().onReset()),
            ],
          );
        },
      )),
    );
  }
}
