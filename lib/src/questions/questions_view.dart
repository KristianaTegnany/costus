import 'package:flutter/material.dart';

enum SmallOrLarge { small, large }

enum ProjectType { domestic, commercial }

class QuestionsView extends StatefulWidget {
  const QuestionsView({super.key, required this.isElectrical});

  final bool isElectrical;
  static const routeName = '/questions';

  @override
  State<QuestionsView> createState() => _QuestionsViewState();
}

class _QuestionsViewState extends State<QuestionsView> {
  SmallOrLarge smallOrLarge = SmallOrLarge.small;
  ProjectType projectType = ProjectType.domestic;

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          iconTheme: const IconThemeData()
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
          title: Text(
            widget.isElectrical ? 'ELECTRICAL' : 'MECHANICAL',
            style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Center(
          child: SizedBox(
            width:
                MediaQuery.of(context).size.width > 500 ? 500 : double.infinity,
            child: Column(
              children: [
                Stepper(
                  currentStep: _index,
                  controlsBuilder: (context, controller) {
                    return const SizedBox.shrink();
                  },
                  onStepTapped: (int index) {
                    setState(() {
                      _index = index;
                    });
                  },
                  steps: <Step>[
                    Step(
                      title: RichText(
                          text: TextSpan(
                              text: 'LARGE',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground,
                                  fontSize: 18,
                                  fontWeight: smallOrLarge == SmallOrLarge.large
                                      ? FontWeight.bold
                                      : FontWeight.normal),
                              children: [
                            const TextSpan(
                                text: '  OR  ',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14)),
                            TextSpan(
                                text: 'SMALL',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground,
                                    fontSize: 18,
                                    fontWeight:
                                        smallOrLarge == SmallOrLarge.small
                                            ? FontWeight.bold
                                            : FontWeight.normal))
                          ])),
                      content: Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: DropdownButton<SmallOrLarge>(
                            isExpanded: true,
                            style: TextStyle(
                                fontSize: 22,
                                color: Theme.of(context).colorScheme.secondary),
                            value: smallOrLarge,
                            onChanged: (value) {
                              setState(() {
                                smallOrLarge = value!;
                                _index = 1;
                              });
                            },
                            items: const [
                              DropdownMenuItem(
                                value: SmallOrLarge.small,
                                child: Text('Small'),
                              ),
                              DropdownMenuItem(
                                value: SmallOrLarge.large,
                                child: Text('Large'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Step(
                      title: const Text('TYPE OF PROJECT'),
                      content: Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: DropdownButton<ProjectType>(
                            isExpanded: true,
                            style: TextStyle(
                                fontSize: 22,
                                color: Theme.of(context).colorScheme.secondary),
                            value: projectType,
                            onChanged: (value) {
                              setState(() {
                                projectType = value!;
                                _index = 1;
                              });
                            },
                            items: const [
                              DropdownMenuItem(
                                value: ProjectType.domestic,
                                child: Text('Domestic'),
                              ),
                              DropdownMenuItem(
                                value: ProjectType.commercial,
                                child: Text('Commercial'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                _index == 0
                    ? const SizedBox()
                    : Expanded(
                        child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: 'Labour Rate:      ',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                                    children: [
                                  TextSpan(
                                      text: smallOrLarge == SmallOrLarge.large
                                          ? (projectType == ProjectType.domestic
                                              ? '£40'
                                              : '£45')
                                          : '£35',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)),
                                  TextSpan(
                                      text: '/man hour',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 12))
                                ])),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Material Profit:  ',
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                                  children: [
                                    TextSpan(
                                        text:
                                            projectType == ProjectType.domestic
                                                ? '+20%'
                                                : '+25%',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary))
                                  ]),
                            ),
                          ],
                        ),
                      ))
              ],
            ),
          ),
        ));
  }
}
