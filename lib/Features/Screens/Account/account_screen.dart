import 'package:clothes/Core/Healpers/app_colors.dart';
import 'package:clothes/Features/Screens/Account/address_screen.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        title: const Text(
          "Account",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: const SizedBox(),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          _AccountTile(
            icon: Icons.inventory_2_outlined,
            title: "My Orders",
            onTap: () {},
          ),
          Container(height: 6, color: Colors.grey.shade200),
          _AccountTile(
            icon: Icons.badge_outlined,
            title: "My Details",
            onTap: () {},
          ),
          _AccountTile(
            icon: Icons.home_outlined,
            title: "Address Book",
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AddressScreen(),
                ),
              );
            },
          ),
          _AccountTile(
            icon: Icons.help_outline,
            title: "FAQs",
            onTap: () {},
          ),
          _AccountTile(
            icon: Icons.headset_mic_outlined,
            title: "Help Center",
            onTap: () {},
          ),
          Container(height: 6, color: Colors.grey.shade200),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout, color: Colors.red),
                label: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountTile extends StatelessWidget {
  const _AccountTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: 22, color: Colors.black87),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}