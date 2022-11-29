import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PanelWidget extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;

  PanelWidget(
      {required this.controller, required this.panelController, super.key});

  void togglePanel() {
    panelController.isPanelOpen
        ? panelController.close()
        : panelController.open();
  }

  @override
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.zero,
        controller: controller,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 17),
            child: GestureDetector(
              // ignore: sort_child_properties_last
              child: Center(
                child: Column(
                  children: [
                    Container(
                      width: 35,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        'TRIPS',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
              onTap: togglePanel,
            ),
          ),
          Column(
            children: [],
          )
        ],
      );
}
