import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfessionalAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String? subtitle;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;

  const ProfessionalAppBar({
    required this.title,
    this.subtitle,
    this.actions,
    this.leading,
    this.showBackButton = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppTheme.surfaceWhite,
        border: Border(
          bottom: BorderSide(color: AppTheme.surfaceGray200),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            children: [
              if (showBackButton)
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                  color: AppTheme.textSecondary,
                ),
              if (leading != null) leading!,
              
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                          ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
              
              if (actions != null) ...actions!,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class ProfessionalSearchBar extends StatefulWidget {
  final String hintText;
  final Function(String)? onChanged;
  final Function()? onFilterTap;
  final bool hasActiveFilters;

  const ProfessionalSearchBar({
    required this.hintText,
    this.onChanged,
    this.onFilterTap,
    this.hasActiveFilters = false,
    super.key,
  });

  @override
  State<ProfessionalSearchBar> createState() => _ProfessionalSearchBarState();
}

class _ProfessionalSearchBarState extends State<ProfessionalSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppTheme.surfaceGray50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.surfaceGray200),
      ),
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Icon(
              Icons.search,
              color: AppTheme.textMuted,
              size: 20,
            ),
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: AppTheme.textMuted,
                  fontSize: 14,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
              style: const TextStyle(
                fontSize: 14,
                color: AppTheme.textPrimary,
              ),
            ),
          ),
          if (_controller.text.isNotEmpty)
            IconButton(
              onPressed: () {
                _controller.clear();
                widget.onChanged?.call('');
              },
              icon: const Icon(
                Icons.clear,
                color: AppTheme.textMuted,
                size: 18,
              ),
            ),
          if (widget.onFilterTap != null)
            Container(
              margin: const EdgeInsets.only(right: 4),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: widget.onFilterTap,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: widget.hasActiveFilters
                          ? AppTheme.primaryBlue.withValues(alpha: 0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.tune,
                      color: widget.hasActiveFilters
                          ? AppTheme.primaryBlue
                          : AppTheme.textMuted,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ProfessionalActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool isPrimary;

  const ProfessionalActionButton({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.isPrimary = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isPrimary) {
      return FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      );
    } else {
      return OutlinedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 18),
        label: Text(label),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      );
    }
  }
}