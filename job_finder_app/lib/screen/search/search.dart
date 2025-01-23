import 'package:flutter/material.dart';
import 'package:job_finder_app/screen/search/widgets/search_input.dart';
import 'package:job_finder_app/screen/search/widgets/search_list.dart';
import 'package:job_finder_app/screen/search/widgets/search_option.dart';
import 'widgets/search_app_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _query = ""; // For search input
  List<String> _filters = []; // For selected filters

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(flex: 2, child: Container()),
              Expanded(
                flex: 1,
                child: Container(color: Colors.grey.withOpacity(0.1)),
              ),
            ],
          ),
          SizedBox(
            height: 1000,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SearchAppBar(),
                SearchInput(
                  onQueryChange: (value) => setState(() {
                    _query = value; // Update query dynamically
                  }),
                ),
                SearchOption(
                  onFilterChange: (filters) => setState(() {
                    _filters = filters; // Update filters dynamically
                  }),
                ),
                Expanded(
                  child: SearchList(
                    query: _query,
                    filters: _filters,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
