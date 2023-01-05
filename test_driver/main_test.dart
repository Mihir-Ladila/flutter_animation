import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Test Launch App',
    () {
      late FlutterDriver driver;

      setUpAll(
        () async {
          driver = await FlutterDriver.connect();
        },
      );

      tearDownAll(
        () async {
          if (driver != null) {
            driver.close();
          }
        },
      );

      test(
        'launch',
        () async {
          SerializableFinder message =
              find.text('You have pushed the button this many times:');

          await driver.waitFor(message);
        },
      );
    },
  );
}
