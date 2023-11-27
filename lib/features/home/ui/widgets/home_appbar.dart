import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeAppBar extends StatelessWidget {
  HomeAppBar({super.key, required this.subtitle});
  String subtitle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: SvgPicture.asset(
            "assets/home_appbar.svg",
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: SvgPicture.asset(
            "assets/home_appbar_vector.svg",
            fit: BoxFit.fill,
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.centerRight,
            child: ListTile(
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hello, peoples",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.people_alt, color: Colors.white, size: 18)
                ],
              ),
              subtitle: Text(
                textAlign: TextAlign.center,
                subtitle,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
