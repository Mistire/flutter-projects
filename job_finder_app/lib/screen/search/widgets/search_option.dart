import 'package:flutter/material.dart';

class SearchOption extends StatefulWidget {
  final Function(List<String>) onFilterChange; // Callback for filter changes

  const SearchOption({super.key, required this.onFilterChange});

  @override
  State<SearchOption> createState() => _SearchOptionState();
}

class _SearchOptionState extends State<SearchOption> {
  final optionMap = <String, bool>{
    'Software': false,
    'Product': false,
    'Data': false,
    'Cloud': false,
    'Machine': false,
  };

  List<String> selectedFilters = [];

  @override
  Widget build(BuildContext context) {
    var keys = optionMap.keys.toList();

    return Column(
      children: [
        // Filter options
        SizedBox(
          height: 35, // Height for better visuals
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                setState(() {
                  // Toggle filter selection
                  var isSelected = optionMap[keys[index]] ?? false;
                  optionMap[keys[index]] = !isSelected;

                  // Update the selected filters
                  selectedFilters = optionMap.entries
                      .where((entry) => entry.value)
                      .map((entry) => entry.key)
                      .toList();
                });

                // Notify the parent widget about the selected filters
                widget.onFilterChange(selectedFilters);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                decoration: BoxDecoration(
                  color: optionMap[keys[index]] == true
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      keys[index],
                      style: TextStyle(
                        fontSize: 14,
                        color: optionMap[keys[index]] == true
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                      ),
                    ),
                    if (optionMap[keys[index]] == true)
                      const Row(children: [
                        SizedBox(width: 10),
                        Icon(Icons.close, size: 15, color: Colors.white),
                      ]),
                  ],
                ),
              ),
            ),
            separatorBuilder: (_, index) => const SizedBox(width: 20),
            itemCount: optionMap.length,
          ),
        ),
        const SizedBox(height: 20), // Space between filter and job list
      ],
    );
  }
}
