import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

OpacityEffect customOpacityEffect = OpacityEffect.fadeOut(
  EffectController(
    duration: 0.6,
    reverseDuration: 0.6,
    infinite: true,
  ),
);

ColorEffect customColorEffect = ColorEffect(
  Colors.blue,
  EffectController(
    duration: 0.8,
    curve: Curves.bounceIn,
    reverseDuration: 0.8,
    infinite: true,
    startDelay: 0.0,
    atMaxDuration: 0.0,
    atMinDuration: 0.0,
  ),
);
