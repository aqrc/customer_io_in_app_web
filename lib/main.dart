import 'package:customer_io_in_app_web/customer_io/customer_io_service_web.dart';
import 'package:flutter/material.dart';

import 'customer_io/customer_io_route_observer.dart';

const _siteIdKey = 'SITE_ID';

void main() {
  if (!const bool.hasEnvironment(_siteIdKey)) {
    _handleMissingArgs();
    return;
  }

  const siteId = String.fromEnvironment(_siteIdKey);
  CustomerIOService.shared.setKey(siteId: siteId);
  CustomerIOService.shared.identify('SomeUserId');

  runApp(const MyApp());
}

void _handleMissingArgs() {
  const errorMessage = "Use --dart-define=$_siteIdKey=<your-site-id> "
      "with `flutter run` command to define CustomerIO's site id";
  print(errorMessage);
  runApp(const MaterialApp(
      home: Material(
        child: Center(
    child: SelectableText(errorMessage),
  ),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(deepness: 1),
      navigatorObservers: [CustomerIORouteObserver()],
    );
  }
}

class MyHomePage extends StatelessWidget {
  final int deepness;

  const MyHomePage({super.key, required this.deepness});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page $deepness'),
      ),
      body: Center(
        child: Text('Page $deepness'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final nextDeepness = deepness + 1;
          Navigator.of(context).push(MaterialPageRoute(
            settings: RouteSettings(name: 'page$nextDeepness'),
            builder: (context) {
              return MyHomePage(deepness: nextDeepness);
            },
          ));
        },
        tooltip: 'New Page',
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
