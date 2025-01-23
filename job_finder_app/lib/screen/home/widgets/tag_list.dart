import 'package:flutter/material.dart';

class TagList extends StatefulWidget {
  final Function(String) onTagChange; // Callback to notify parent of tag change

  const TagList({super.key, required this.onTagChange});

  @override
  State<TagList> createState() => _TagListState();
}

class _TagListState extends State<TagList> {
  final tagList = <String>['All', '⚡ Popular', '⭐ Featured'];
  var selected = 0; // Default selected tag

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            setState(() {
              selected = index;
            });
            widget
                .onTagChange(tagList[index]); // Notify parent with selected tag
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: selected == index
                  ? Theme.of(context).primaryColor.withOpacity(0.3)
                  : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selected == index
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).primaryColor.withOpacity(0.2),
              ),
            ),
            child: Text(tagList[index]),
          ),
        ),
        separatorBuilder: (_, index) => const SizedBox(width: 15),
        itemCount: tagList.length,
      ),
    );
  }
}
