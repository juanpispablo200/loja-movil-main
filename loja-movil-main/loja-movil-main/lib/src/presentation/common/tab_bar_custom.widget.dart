import 'package:flutter/material.dart';

class TabBarCustom extends StatefulWidget {
  final List<TabBarCustomItem> items;
  final Function(int) onSelect;
  final Color selectedColor;
  final Color unselectedColor;

  const TabBarCustom({
    super.key,
    required this.items,
    required this.onSelect,
    required this.selectedColor,
    required this.unselectedColor,
  });

  @override
  State<TabBarCustom> createState() => _TabBarCustomState();
}

class _TabBarCustomState extends State<TabBarCustom> {
  int currentSelected = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(widget.items.length, (index) {
        var item = widget.items[index];
        return Padding(
          padding: const EdgeInsets.only(
            right: 10,
          ),
          child: GestureDetector(
            onTap: () {
              setState(
                () {
                  currentSelected = index;
                  widget.onSelect(index);
                },
              );
            },
            child: _TabBarCustomItem(
              label: item.label,
              index: index,
              selected: index == currentSelected,
              selectedColor: widget.selectedColor,
              unselectedColor: widget.unselectedColor,
            ),
          ),
        );
      }),
    );
  }
}

class TabBarCustomItem {
  final String label;

  TabBarCustomItem({
    required this.label,
  });
}

class _TabBarCustomItem extends StatelessWidget {
  final String label;
  final int index;
  final bool selected;
  final Color selectedColor;
  final Color unselectedColor;
  const _TabBarCustomItem({
    required this.label,
    required this.index,
    required this.selected,
    required this.selectedColor,
    required this.unselectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
        color: selected ? selectedColor : unselectedColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: selected ? Colors.white : selectedColor,
          ),
        ),
      ),
    );
  }
}
