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
    final textTheme = Theme.of(context).textTheme;

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
                Text("Appearance", style: textTheme.headlineMedium),
                const SizedBox(height: 16),
                _buildSettingTile(
                  isDark: isDark,
                  icon: _getThemeIcon(themeMode),
                  label: "Theme",
                  textTheme: textTheme,
                  trailing: TextButton(
                    onPressed: () {
                      ThemeMode next;
                      if (themeMode == ThemeMode.system) { next = ThemeMode.light;
                      } else if (themeMode == ThemeMode.light) {
                        next = ThemeMode.dark;
                      } else {
                        next = ThemeMode.system;
                      }
                      ref.read(themeProvider.notifier).state = next;
                    },
                    style: _buttonStyle(),
                    child: Text(
                      _getThemeLabel(themeMode), 
                      style: textTheme.labelLarge?.copyWith(color: VedaTheme.brandGreen),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                /// --- About ---
                Text("About", style: textTheme.headlineMedium),
                const SizedBox(height: 16),
                _buildSettingTile(
                  isDark: isDark,
                  icon: Icons.info_rounded,
                  label: "Version",
                  textTheme: textTheme,
                  trailing: _buildStaticBox(
                    child: Text(
                      "1.0.0", 
                      style: textTheme.bodyLarge?.copyWith(
                        color: VedaTheme.brandGreen,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _buildSettingTile(
                  isDark: isDark,
                  icon: Icons.description_rounded,
                  label: "Terms",
                  textTheme: textTheme,
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

  /// Reusable Row Structure with Theme Integration
  Widget _buildSettingTile({
    required bool isDark,
    required IconData icon,
    required String label,
    required Widget trailing,
    required TextTheme textTheme,
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
            style: textTheme.displayLarge?.copyWith(fontSize: 15), // Scale down displayLarge for the label
          ),
          const Spacer(),
          
          /// Strict Size Consistency (80x36)
          SizedBox(
            width: 80,
            height: 36,
            child: trailing,
          ),
        ],
      ),
    );
  }

  /// Helper for static info boxes
  Widget _buildStaticBox({required Widget child}) {
    return Container(
      alignment: Alignment.center,
      child: child,
    );
  }

  /// Button Style derived from VedaTheme logic
  ButtonStyle _buttonStyle() => TextButton.styleFrom(
        backgroundColor: VedaTheme.brandGreen.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
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