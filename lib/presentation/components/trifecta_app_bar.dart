import 'package:flutter/material.dart';

class TrifectaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TrifectaAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: SafeArea(
        child: SizedBox(
          height: 80,
          child: Column(
            children: [
              Text(
                'Trifecta',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                '//a minimalistic productive app.',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
