import 'package:flutter/material.dart';

class SearchTabs extends StatefulWidget {
  final List<String> tabs;
  final String searchQuery;

  const SearchTabs({
    super.key,
    required this.tabs,
    required this.searchQuery,
  });

  @override
  State<SearchTabs> createState() => _SearchTabsState();
}

class _SearchTabsState extends State<SearchTabs> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Tabs Row
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
          child: Row(
            children: [
              for (int i = 0; i < widget.tabs.length; i++)
                _buildTab(i, widget.tabs[i]),
              const Spacer(),
              Text(
                widget.searchQuery,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Indicator Line
        Container(
          height: 2,
          color: Colors.grey.shade900,
          child: Row(
            children: [
              for (int i = 0; i < widget.tabs.length; i++)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: i == _selectedIndex
                      ? MediaQuery.of(context).size.width / widget.tabs.length
                      : 0,
                  height: 2,
                  color: Colors.white,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTab(int index, String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: _selectedIndex == index ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
