import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vt_live_map/features/live_map/domain/enum/prod_class.dart';

class MultiSelectChip extends StatefulWidget {
  final List<ProdClass> chipOptions;
  final List<ProdClass> selectedChipOptions;
  final Function(List<ProdClass>) onChanged; // +added

  MultiSelectChip(
    this.chipOptions,
    this.selectedChipOptions, {
    this.onChanged,
  });

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<ProdClass> selectedChips = List();

  @override
  void initState() {
    super.initState();
    selectedChips = widget.selectedChipOptions;
  }

  _buildChoiceList() {
    List<Widget> choices = List();

    widget.chipOptions.forEach((chip) {
      final bool isSelected = selectedChips.contains(chip);

      choices.add(
        Container(
          padding: const EdgeInsets.all(2.0),
          child: ChoiceChip(
            label: Text(translateProdClass(chip)),
            selected: isSelected,
            onSelected: (final bool selected) {
              setState(() {
                isSelected
                    ? selectedChips.remove(chip)
                    : selectedChips.add(chip);
                widget.onChanged(selectedChips);
              });
            },
          ),
        ),
      );
    });

    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
