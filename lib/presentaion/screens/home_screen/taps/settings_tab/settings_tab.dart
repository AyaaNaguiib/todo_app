import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/utils/colors_manager.dart';
import '../../../../../providers/theme_provider.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  String selectedTheme = 'Light';
  String selectedLang = 'English';

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Theme', style: themeProvider.themeLabelStyle),
          const SizedBox(height: 4),
          buildSettingsTabComponent(
            'Light',
            'Dark',
            themeProvider.themeMode == ThemeMode.light ? 'Light' : 'Dark',
                (newTheme) {
              themeProvider.setTheme(newTheme == 'Light' ? ThemeMode.light : ThemeMode.dark);
            },
          ),
          const SizedBox(height: 12),
          Text('Language', style: themeProvider.themeLabelStyle),
          const SizedBox(height: 4),
          buildSettingsTabComponent(
            'English',
            'Arabic',
            selectedLang,
                (newLang) {
              setState(() {
                selectedLang = newLang ?? selectedLang;
              });
            },
          ),
        ],
      ),
    );
  }



Widget buildSettingsTabComponent(String item1, String item2, String textView, ValueChanged<String?> onChanged) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      height: 48,
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        border: Border.all(width: 1, color: ColorsManager.blue),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(textView, style: themeProvider.selectedThemeLabelStyle),
          DropdownButton<String>(
            value: textView,
            underline: const SizedBox(),
            borderRadius: BorderRadius.circular(12),
            items: <String>[item1, item2].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
class MenuItem {
  String item1;
  String item2;

  MenuItem({required this.item1, required this.item2});
}