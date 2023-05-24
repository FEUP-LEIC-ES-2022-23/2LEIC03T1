import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final ValueChanged<String> onSearch;

  const SearchBar({Key? key, required this.onSearch}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
        padding: EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Color(0x22000000)),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
              ),
              onSubmitted: widget.onSearch,
            ),
          ),
          TextButton(
            onPressed: () {
              widget.onSearch(_controller.text);
            },
            style: TextButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                minimumSize: Size(10, 10)),
            child: Icon(Icons.search),
          ),
        ]));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
