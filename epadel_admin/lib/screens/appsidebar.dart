import 'package:flutter/material.dart';

class SidebarNavigation extends StatelessWidget {
  final String selectedPage;
  final Function(String) onPageSelected;

  const SidebarNavigation({
    Key? key,
    required this.selectedPage,
    required this.onPageSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double containerWidth = screenWidth * 0.2; // 20% width parenta

    return Container(
      width: containerWidth,
      color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "ePadel",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SidebarButton(
            title: 'Tereni',
            isSelected: selectedPage == 'tereni',
            onTap: () => onPageSelected('tereni'),
          ),
          const SizedBox(
            height: 10,
          ),
          SidebarButton(
            title: 'Korisnici',
            isSelected: selectedPage == 'korisnici',
            onTap: () => onPageSelected('korisnici'),
          ),
          const SizedBox(
            height: 10,
          ),
          SidebarButton(
            title: 'Rezervacije',
            isSelected: selectedPage == 'rezervacije',
            onTap: () => onPageSelected('rezervacije'),
          ),
          const SizedBox(
            height: 10,
          ),
            SidebarButton(
            title: 'Feedbacks',
            isSelected: selectedPage == 'feedback',
            onTap: () => onPageSelected('feedback'),
          ),
          const SizedBox(
            height: 10,
          ),
          SidebarButton(
            title: 'Reports',
            isSelected: selectedPage == 'report',
            onTap: () => onPageSelected('report'),
          ),
        ],
      ),
    );
  }
}

class SidebarButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const SidebarButton({
    Key? key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) {}, // Iskljuci hover efekat
      child: SizedBox(
        height: 30,
        child: FractionallySizedBox(
          widthFactor: 0.8,
          child: TextButton(
            onPressed: onTap,
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              backgroundColor:
                  MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.grey;
                }
                return isSelected
                    ? const Color(0xFF618264)
                    : const Color(0xFFB0D9B1);
              }),
              foregroundColor:
                  MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.disabled)) {
                  return Colors.black;
                }
                return isSelected ? Colors.white : Colors.black;
              }),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
