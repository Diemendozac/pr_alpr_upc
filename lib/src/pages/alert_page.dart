import 'package:flutter/material.dart';
import 'package:pr_alpr_upc/src/theme/image_manager.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({super.key});

  @override
  Widget build(BuildContext context) {

    String selectPage = 'success';
    final alertData = ModalRoute.of(context)?.settings.arguments as Map;

    ImageManager imageManager = ImageManager.instance;

    return GestureDetector(
      onTap: Navigator.of(context).pop,
      child: Scaffold(
        backgroundColor: alertData['color'],
        body: Stack(
          children: [
            imageManager.getBackgroundBottomAlertImage(context),
            imageManager.getBackgroundTopAlertImage(context),
            _createAlertSubject(context, alertData, selectPage)
          ],
        ),
      ),
    );
  }

  Widget _createAlertSubject(BuildContext context, Map alertData, String selectPage) {
    return Center(
      child: Container(
      width: MediaQuery.of(context).size.width * 0.8,
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
                alertData['icon'],
                size: 50,
                color: alertData['color']
              ),
            ),
            Text(alertData['title'],
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Theme.of(context).colorScheme.onError)
            ),
            Text(alertData['message'],
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Theme.of(context).colorScheme.onError),
            ),
          ],
        ),
      ),
    );
  }
}
