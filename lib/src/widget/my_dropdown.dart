import 'package:flutter/material.dart';

enum DataKey { id, value }

class MyDropDown extends StatelessWidget {
  const MyDropDown(
      {super.key,
      required this.data,
      required this.value,
      required this.label,
      required this.onChange});

  final List<Map<DataKey, String>> data;
  final String? value;
  final String label;
  final void Function(String? value) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: DropdownButton(
          isExpanded: true,
          hint: Text(
            label,
          ),
          style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          iconEnabledColor: Theme.of(context).colorScheme.onBackground,
          underline: const SizedBox(),
          borderRadius: BorderRadius.circular(10),
          items: data
              .map((item) => DropdownMenuItem(
                  value: item[DataKey.id],
                  child: Text(
                    item[DataKey.value]!,
                  )))
              .toList(),
          value: value,
          onChanged: (value) => onChange(value)),
    );
  }
}
