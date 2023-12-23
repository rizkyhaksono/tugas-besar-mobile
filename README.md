# Push Puzzle

This repo made for Tugas Besar Praktikum Mobile

## Overview Game

<img width="600" src="https://user-images.githubusercontent.com/1584153/234482219-4cd323d9-67a0-47b4-af91-87308240276e.gif">

## Usage

```
flutter run
```

## Architecture

For stage data, [lib/utilty/stage_master_data.dart](/lib/utils/stage_master_data.dart) is referenced, and stages are generated as text data.

```dart
############
#     ## p #
#   o .. o #
############
```

The core logic of the game is located under lib/src and is mainly processed here and designed to be executable in CUI.

[lib/src/stage_state.dart](/lib/src/stage_state.dart) is the main process that manages the stage state, and [lib/src/push_game.dart](/lib/src/push_game.dart) is designed to encompass it.

Update positions of walls, characters, luggage, etc. as game conditions change.

```dart
############
#     ##   #
#  op .. o #
############
```

The other files under the lib are the Flutter and Flame processes for displaying on the screen as GUI.

## Getting Started

As for the content of the game, it is quite simple.

The stage is cleared by moving the character and carrying the luggage to the goal.

### Input Reference

| Joypad |          input          | Direction |
| ------ | :---------------------: | :-------: |
| UP     | LogicalKeyboardKey keyW |    UP     |
| Left   | LogicalKeyboardKey keyA |   Left    |
| right  | LogicalKeyboardKey keyD |   right   |
| Down   | LogicalKeyboardKey keyS |   Down    |
