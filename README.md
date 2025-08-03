<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

# DualSwitch

A lightweight Flutter package that provides a simple and customizable switch widget allowing users to take quick **Approve** or **Reject** actions with ease.

Ideal for use cases like approvals, verifications, moderation, or any binary decision-making UI.

---

## ✨ Features

- Toggle between **Approve** and **Reject** actions.
- Fully customizable colors and labels.
- Optional reset after action.
- Clean and intuitive UI.

---

## 🚀 Getting Started
Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  dual_switch: ^<latest_version>
```

Then, import it:

```dart
import 'package:dual_switch/dual_switch.dart';
```

## 🧰 Usage

Basic Example : 
```dart
DualSwitch(onChanged: (value) {
    debugPrint("value : $value");
},)
```

With Customization : 
```dart
DualSwitch(
    acceptColor: Colors.green,
    rejectColor: Colors.red,
    acceptText: "Accept",
    rejectText: "Reject",
    acceptedText: "Accepted",
    rejectedText: "Rejected",
    reset : true,
    onChanged: (value) {
        debugPrint("value : $value");
    },
)
```

| -------------- | ---------------- | -------------- | --------------------------------------------------------- |
| Parameter      | Type             | Default        | Description                                               |
| -------------- | ---------------- | -------------- | --------------------------------------------------------- |
| `onChanged`    | `Function(bool)` | **required**   | Callback when user makes a selection (`true` or `false`). |
| `acceptColor`  | `Color`          | `Colors.green` | Color for the approve state.                              |
| `rejectColor`  | `Color`          | `Colors.red`   | Color for the reject state.                               |
| `acceptText`   | `String`         | `"Approve"`    | Label for approve button before selection.                |
| `rejectText`   | `String`         | `"Reject"`     | Label for reject button before selection.                 |
| `acceptedText` | `String`         | `"Approved"`   | Label shown after approve is selected.                    |
| `rejectedText` | `String`         | `"Rejected"`   | Label shown after reject is selected.                     |
| `reset`        | `bool`           | `false`        | Whether to reset to neutral state after selection.        |
| -------------- | ---------------- | -------------- | --------------------------------------------------------- |

