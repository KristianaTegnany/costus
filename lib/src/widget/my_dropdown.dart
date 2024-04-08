import 'package:costus/src/signup/signup_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

enum DataKey { id, data, value }

class MyDropDown extends StatelessWidget {
  const MyDropDown(
      {super.key,
      required this.data,
      required this.value,
      required this.label,
      required this.onChange,
      this.isForm = false,
      this.isExpanded = true});

  final List<Map<DataKey, String>> data;
  final String? value;
  final String label;
  final void Function(String? value) onChange;
  final bool isForm;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: isForm ? 5 : 15, vertical: 5),
      width: !isExpanded
          ? null
          : kIsWeb
              ? 400
              : double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10)),
      child: DropdownButton(
          isExpanded: isExpanded,
          hint: Text(
            label,
          ),
          style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 18,
              fontWeight: isForm ? FontWeight.normal : FontWeight.bold),
          iconEnabledColor: Theme.of(context).colorScheme.onBackground,
          underline: const SizedBox(),
          borderRadius: BorderRadius.circular(10),
          items: data
              .map((item) => DropdownMenuItem(
                  value: '${item[DataKey.id]}:${item[DataKey.data]}',
                  child: Text(
                    item[DataKey.value]!,
                  )))
              .toList(),
          value: value,
          onChanged: FirebaseAuth.instance.currentUser != null ||
                  ModalRoute.of(context)?.settings.name == SignupView.routeName
              ? (value) => onChange(value as String)
              : null),
    );
  }
}
