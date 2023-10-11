import 'package:flutter/material.dart';
import 'package:flutter_base_project/app/constants/other/padding_and_radius_size.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String?) onChanged;
  final Function(String?) onSubmitted;
  final Function() queryDelete;

  const SearchField({
    Key? key,
    required this.controller,
    required this.onChanged,
    required this.queryDelete,
    required this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
          hintText: 'Search a movie...',
          suffixIcon: GestureDetector(onTap: queryDelete, child: const Icon(Icons.close)),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(left: paddingS, right: paddingXXXS),
            child: GestureDetector(
              child: const Icon(Icons.search),
            ),
          )),
    );
  }
}
