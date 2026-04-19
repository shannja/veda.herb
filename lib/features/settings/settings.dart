import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vedaherb/core/theme.dart';
import 'package:vedaherb/main.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeMode = ref.watch(themeProvider);

    return Scaffold(
      backgroundColor: isDark ? VedaTheme.darkBg : VedaTheme.lightBg,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              children: [
                const SizedBox(height: 48),

                /// --- Appearance ---
                _buildSectionHeader("Appearance", context, isDark),
                const SizedBox(height: 16),
                _buildSettingTile(
                  isDark: isDark,
                  icon: _getThemeIcon(themeMode),
                  label: "Theme",
                  trailing: TextButton(
                    onPressed: () {
                      ThemeMode next;
                      if (themeMode == ThemeMode.system) {
                        next = ThemeMode.light;
                      } else if (themeMode == ThemeMode.light) {
                        next = ThemeMode.dark;
                      } else {
                        next = ThemeMode.system;
                      }
                      ref.read(themeProvider.notifier).state = next;
                    },
                    style: _buttonStyle(),
                    child: Text(_getThemeLabel(themeMode), style: _textButtonStyle()),
                  ),
                ),

                const SizedBox(height: 32),

                /// --- About ---
                _buildSectionHeader("About", context, isDark),
                const SizedBox(height: 16),
                _buildSettingTile(
                  isDark: isDark,
                  icon: Icons.info_rounded,
                  label: "Version",
                  trailing: _buildStaticBox(
                    child: Text("1.0.0", style: _textButtonStyle()),
                  ),
                ),
                const SizedBox(height: 12),
                _buildSettingTile(
                  isDark: isDark,
                  icon: Icons.description_rounded,
                  label: "Terms of Service",
                  trailing: TextButton(
                    onPressed: () => debugPrint("ToS Clicked"),
                    style: _buttonStyle(),
                    child: const Icon(Icons.arrow_outward, size: 14, color: VedaTheme.brandGreen),
                  ),
                ),
              ],
            ),

            /// Fixed Back Button (Top Right)
            Positioned(
              top: 10,
              right: 16,
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: VedaTheme.brandGreen.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_rounded, 
                    size: 18, 
                    color: VedaTheme.brandGreen
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Reusable Row Structure
  Widget _buildSettingTile({
    required bool isDark,
    required IconData icon,
    required String label,
    required Widget trailing,
  }) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: VedaTheme.brandGreen.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Icon(icon, color: VedaTheme.brandGreen, size: 22),
          const SizedBox(width: 16),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          const Spacer(),
          
          /// Forces all trailing widgets (Buttons, Icons, Text) to the same size
          SizedBox(
            width: 70,
            height: 30,
            child: trailing,
          ),
        ],
      ),
    );
  }

  /// Section Header Styling
  Widget _buildSectionHeader(String title, BuildContext context, bool isDark) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontFamily: VedaTheme.titleFont,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black87,
          ),
    );
  }

  /// Helper for static info (like Version) to match Button size
  Widget _buildStaticBox({required Widget child}) {
    return Container(
      alignment: Alignment.center,
      child: child,
    );
  }

  /// Consistent Button Styling
  ButtonStyle _buttonStyle() => TextButton.styleFrom(
        backgroundColor: VedaTheme.brandGreen.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
      );

  TextStyle _textButtonStyle() => const TextStyle(
        color: VedaTheme.brandGreen,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      );

  IconData _getThemeIcon(ThemeMode mode) {
    if (mode == ThemeMode.light) return Icons.light_mode_rounded;
    if (mode == ThemeMode.dark) return Icons.dark_mode_rounded;
    return Icons.brightness_auto_rounded;
  }

  String _getThemeLabel(ThemeMode mode) {
    if (mode == ThemeMode.light) return "Light";
    if (mode == ThemeMode.dark) return "Dark";
    return "System";
  }
}