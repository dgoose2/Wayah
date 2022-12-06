import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class OpenPanel extends StatelessWidget {
  Widget collapsedPanel;
  Widget innerOpenPanel;
  final panelController = PanelController();

  OpenPanel({
    super.key,
    required this.collapsedPanel,
    required this.innerOpenPanel,
  });

  void togglePanel() {
    panelController.isPanelOpen
        ? panelController.close()
        : panelController.open();
  }

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: panelController,
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      color: Colors.white,
      minHeight: 0,
      maxHeight: MediaQuery.of(context).size.height * 0.65,
      collapsed: collapsedPanel,
      panel: innerOpenPanel,
      body: Padding(
        padding: const EdgeInsets.only(top: 65),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'BACK',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Transform.rotate(
                  angle: 4.68,
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 23,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Transform.rotate(
                  angle: 3.95,
                  child: FloatingActionButton(
                    heroTag: "btn2",
                    elevation: 0,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9)),
                    onPressed: () {
                      togglePanel();
                    },
                    child: Transform.rotate(
                      angle: 3.9,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                                color: Color.fromARGB(255, 141, 141, 218),
                                width: 3)),
                        child: Icon(
                          Icons.add,
                          color: Color.fromARGB(255, 141, 141, 218),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    ;
  }
}