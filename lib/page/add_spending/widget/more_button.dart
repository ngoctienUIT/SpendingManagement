import '../../../constants/app_styles.dart';
import '../../../setting/localization/app_localizations.dart';
import 'package:flutter/material.dart';

class MoreButton extends StatelessWidget {
  const MoreButton({Key? key, required this.action, required this.more})
      : super(key: key);
  final Function action;
  final bool more;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        action();
      },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            more
                ? AppLocalizations.of(context).translate('hide_away')
                : AppLocalizations.of(context).translate('more_details'),
            style: AppStyles.p,
          ),
          Icon(more ? Icons.arrow_drop_up : Icons.arrow_drop_down)
        ],
      ),
    );
  }
}
