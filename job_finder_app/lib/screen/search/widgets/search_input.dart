import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  final Function(String) onQueryChange;

  const SearchInput({super.key, required this.onQueryChange});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              cursorColor: Colors.grey,
              onChanged:
                  widget.onQueryChange, // Notify parent widget on input change
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                hintText: 'Search',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
                contentPadding: EdgeInsets.zero,
                prefixIcon: Container(
                  padding: const EdgeInsets.all(15),
                  child: Image.asset(
                    'assets/icons/search.png',
                    width: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          // Container(
          //   height: 50,
          //   width: 50,
          //   padding: const EdgeInsets.all(13),
          //   decoration: BoxDecoration(
          //     color: Theme.of(context).colorScheme.secondary,
          //     borderRadius: BorderRadius.circular(20),
          //   ),
          //   child: Image.asset('assets/icons/filter.png'),
          // )
        ],
      ),
    );
  }
}
