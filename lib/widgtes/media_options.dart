import 'package:flutter/material.dart';
import '../app/themes/colors.dart';

class MediaOptionsPopup extends StatelessWidget {
  const MediaOptionsPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: [
          buildMediaOption(
            icon: Icons.camera_alt,
            label: 'Camera',
            onTap: () {
              // Add camera functionality
            },
          ),
          buildMediaOption(
            icon: Icons.mic,
            label: 'Record',
            onTap: () {
              // Add record functionality
            },
          ),
          buildMediaOption(
            icon: Icons.contacts,
            label: 'Contact',
            onTap: () {
              // Add contact functionality
            },
          ),
          buildMediaOption(
            icon: Icons.photo,
            label: 'Gallery',
            onTap: () {
              // Add gallery functionality
            },
          ),
          buildMediaOption(
            icon: Icons.location_on,
            label: 'Location',
            onTap: () {
              // Add location functionality
            },
          ),
          buildMediaOption(
            icon: Icons.insert_drive_file,
            label: 'Document',
            onTap: () {
              // Add document functionality
            },
          ),
        ],
      ),
    );
  }

  Widget buildMediaOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.primary,
            radius: 30,
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(color: AppColors.text, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
