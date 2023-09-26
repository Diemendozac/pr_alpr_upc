import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/theme/image_manager.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({super.key});

  @override
  Widget build(BuildContext context) {

    String selectPage = 'success';

    Map caseSelector = {
      'warning': {
        'color' : Colors.amber,
        'icon' : Icons.warning_amber,
        'title': 'Precaución'
      },
      'error': {
        'color' : Theme.of(context).colorScheme.error,
        'icon' : Icons.close,
        'title': 'Error'

      },
      'success': {
        'color' : Theme.of(context).colorScheme.primary,
        'icon' : Icons.check,
        'title': 'Success'

      }
    };

    ImageManager imageManager = ImageManager.instance;

    return Scaffold(
      backgroundColor: caseSelector[selectPage]['color'],
      body: Stack(
        children: [
          imageManager.getBackgroundBottomAlertImage(context),
          imageManager.getBackgroundTopAlertImage(context),
          _createAlertSubject(context, caseSelector, selectPage)
        ],
      ),
    );
  }

  Widget _createAlertSubject(BuildContext context, Map caseSelector, String selectPage) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.onError,
            ),
            child: Icon(
              caseSelector[selectPage]['icon'],
              size: 50,
              color: caseSelector[selectPage]['color']
            ),
          ),
          Text(caseSelector[selectPage]['title'],
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.onError)
          ),
          Text('Proceso realizado con éxito',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.onError)
          ),
        ],
      ),
    );
  }
}
