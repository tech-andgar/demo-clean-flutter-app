# DEMO AFGR

![coverage][coverage_badge]

---


https://github.com/user-attachments/assets/6b6ef4c9-0b84-41c6-b419-504812ad79a0



## Getting Started 🚀

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Demo AFGR works on iOS, Android, Web, and Windows._

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Working with Translations 🌐

This project relies on flutter_localizations and follows the [Package easy_localization](https://pub.dev/packages/easy_localization).

### Adding Strings

1. To add a new localizable string, open the `en-US.json` file at `lib/resources/langs/en-US.json`.

    ```json
    {
      "feature": {
        "main": {
          "sliverListUrl": {
            "dataEmpty": "Looks a bit empty here! Add your first shortened URLs."
          },
          "title": "Recently shortend URLs"
        }
      }
    }
    ```

2. Then add a new key/value and description

    ```json
    {
      "feature": {
        "main": {
          "sliverListUrl": {
            "dataEmpty": "Looks a bit empty here! Add your first shortened URLs."
          },
          "title": "Recently shortend URLs"
        }
      },
      "widget": {
        "cdsItemListTileShortcutUrl": {
          "iconButton": {
            "onPressed": {
              "msgSnackbar": "Link shortend {linkShortend}\nCopied to your clipboard"
            }
          }
        }
      }
    }
    ```

3. Use the new string

    ```dart
    import 'package:easy_localization/easy_localization.dart';
    import '../generated/locale_keys.g.dart';

    @override
    Widget build(BuildContext context) {
      return Text(LocaleKeys.feature_main_title.tr());
    }
    ```

    or used with named arguments

    ```dart
    import 'package:easy_localization/easy_localization.dart';
    import '../generated/locale_keys.g.dart';

    @override
    Widget build(BuildContext context) {
      return Text(
              LocaleKeys
              .widget_cdsItemListTileShortcutUrl_iconButton_onPressed_msgSnackbar
              .tr(namedArgs: {'linkShortend': 'https://short.link/123abc'})
            );
    }
    ```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
 <array>
  <string>en</string>
  <string>es</string>
 </array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/resources/langs`.

    ```txt
    ├── resources
    │   ├── langs
    │   │   ├── en-US.json
    │   │   └── es-ES.json
    ```

2. Add the translated strings to each `.json` file:

    `es-ES.json`

    ```json
    {
      "feature": {
        "main": {
          "sliverListUrl": {
            "dataEmpty": "¡Parece un poco vacío aquí! Añade tus primeras URLs acortadas."
          },
          "title": "URL acortadas recientemente"
        }
      }
    }
    ```

    `en-US.json`

    ```json
    {
      "feature": {
        "main": {
          "sliverListUrl": {
            "dataEmpty": "Looks a bit empty here! Add your first shortened URLs."
          },
          "title": "Recently shortend URLs"
        }
      },
    }
    ```

### Generating Translations

To use the latest translations changes, you will need to generate them:

1. Generate localizations for the current project:

    ```sh
    dart run easy_localization:generate && dart run easy_localization:generate -f keys -o locale_keys.g.dart
    ```

[coverage_badge]: coverage_badge.svg
