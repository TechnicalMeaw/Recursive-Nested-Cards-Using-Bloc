import 'package:flutter/material.dart';
import 'package:redoq_assignment/utils/color_constants.dart';

class CollapsableSectionWidget extends StatefulWidget {
  CollapsableSectionWidget({super.key, required this.content, this.contentWidgetList = const [], this.onClicked, this.initialValue = false,
    this.arrowColor, this.isPaddingNeeded = true, this.onAddClicked});
  Widget content;
  List<Widget> contentWidgetList;
  void Function(bool isOpened)? onClicked;
  final bool initialValue;
  final Color? arrowColor;
  final bool isPaddingNeeded;
  void Function()? onAddClicked;

  @override
  State<CollapsableSectionWidget> createState() => _RadiologyDatedReportsWidgetState();
}

class _RadiologyDatedReportsWidgetState extends State<CollapsableSectionWidget> {

  bool isOpened = false;

  @override
  void initState() {
    isOpened = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ColorConstants.borderColor)
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          visualDensity: const VisualDensity(vertical: -4),
        ),
        child: ExpansionTile(
            title: widget.content,
            trailing: Icon(!isOpened ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded, size: 24, color: widget.arrowColor ?? ColorConstants.arrowColor,),
            dense: true,
            visualDensity: VisualDensity.compact,
            onExpansionChanged: (isTileOpened) {
              setState(() {
                isOpened = isTileOpened;
              });
              if (widget.onClicked != null) {
                widget.onClicked!(isOpened);
              }
            },
            initiallyExpanded: widget.initialValue,
            tilePadding: EdgeInsets.symmetric(horizontal: widget.isPaddingNeeded ? 16 : 0),
            expandedCrossAxisAlignment: CrossAxisAlignment.start,
            childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
            children: [
              const SizedBox(height: 12,),
              ...widget.contentWidgetList,
              const SizedBox(height: 16,),
              InkWell(
                onTap: widget.onAddClicked,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    color: ColorConstants.primaryColor
                  ),
                  child: const Center(
                    child: Text('Add', style: TextStyle(color: ColorConstants.backgroundColor, fontSize: 14, fontWeight: FontWeight.w600),),
                  ),
                ),
              ),
              const SizedBox(height: 8,),
            ]

        ),
      ),
    );
  }
}
