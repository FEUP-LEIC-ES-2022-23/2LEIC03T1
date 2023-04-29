import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      width: MediaQuery.of(context).size.width - 10,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      child: Text(
        title,
        style: GoogleFonts.montserratAlternates(
            fontWeight: FontWeight.bold, fontSize: 22),
      ),
    );
  }
}
