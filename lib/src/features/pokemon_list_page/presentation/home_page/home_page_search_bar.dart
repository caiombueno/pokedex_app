import 'package:flutter/material.dart';

class HomePageSearchBar extends StatelessWidget {
  const HomePageSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final searchBarBorder = OutlineInputBorder(
      borderSide: const BorderSide(
        color: Color(0xFF8D9DB9),
      ),
      borderRadius: BorderRadius.circular(16.0),
    );
    return TextField(
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusColor: Colors.black,
        prefixIcon: const Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 8.0,
          ),
          child: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
        hintText: 'Search a pokémon',
        hintStyle: const TextStyle(
          fontSize: 16,
          color: Color(0xFF8D9DB9),
        ),
        border: searchBarBorder,
        focusedBorder: searchBarBorder,
      ),
    );
  }
}
