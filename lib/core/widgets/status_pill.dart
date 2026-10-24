import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jivodsr/core/theme/app_colors.dart';

enum PillTone { ok, warn }

class StatusPill extends StatelessWidget {

  const StatusPill({
    super.key,
    required this.label,
    required this.icon,
    this.tone = PillTone.ok,
  }) : fg = null,
       bg = null,
       borderColor = null;

  /// Pill with your own colours — used by attendance statuses.
  const StatusPill.colored({
    super.key,
    required this.label,
    required this.icon,
    required Color this.fg,
    required Color this.bg,
    required Color this.borderColor,
  }) : tone = PillTone.ok;

  final String label;
  final IconData icon;
  final PillTone tone;
  final Color? fg;
  final Color? bg;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    
    final (fg, bg, border) = switch (tone) {
      PillTone.ok => (AppColors.okFg, AppColors.okBg, AppColors.okBorder),
      PillTone.warn => (AppColors.warnFg, AppColors.warnBg, AppColors.warnBorder),
    };
  
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 3, 8, 3),
      decoration: BoxDecoration(
        color: bg,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: fg,
            ),
          ),
        ],
      ),
    );
  
  }
  
}