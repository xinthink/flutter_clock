// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';

import 'package:flutter_clock_helper/customizer.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'sundial.dart';

void main() {
  // A temporary measure until Platform supports web and TargetPlatform supports
  // macOS.
  if (!kIsWeb && Platform.isMacOS) {
    // TODO(gspencergoog): Update this when TargetPlatform includes macOS.
    // https://github.com/flutter/flutter/issues/31366
    // See https://github.com/flutter/flutter/wiki/Desktop-shells#target-platform-override.
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }

  // This creates a clock that enables you to customize it.
  //
  // The [ClockCustomizer] takes in a [ClockBuilder] that consists of:
  //  - A clock widget (in this case, [AnalogClock])
  //  - A model (provided to you by [ClockModel])
  // For more information, see the flutter_clock_helper package.
  //
  // Your job is to edit [AnalogClock], or replace it with your own clock
  // widget. (Look in analog_clock.dart for more details!)
  runApp(ClockCustomizer((ClockModel model) => Builder(
    builder: (context) {
      final theme = Theme.of(context);
      final isDark = theme.brightness == Brightness.dark;
      return Theme(
        data: theme.copyWith(
          primaryTextTheme: theme.primaryTextTheme.copyWith(
            title: theme.primaryTextTheme.title.copyWith(
              color: isDark ? kPrimaryTextColorDark : kPrimaryTextColor,
            ),
            subtitle: theme.primaryTextTheme.subtitle.copyWith(
              color: isDark ? kSecondaryTextColorDark : kSecondaryTextColor,
            ),
            caption: theme.primaryTextTheme.caption.copyWith(
              color: isDark ? kTipsTextColorDark : kTipsTextColor,
            ),
          ),
        ),
        child: Sundial(model: model),
    );
  })));
}

const kPrimaryTextColor = Colors.black;
const kSecondaryTextColor = const Color(0xb2000000);
const kTipsTextColor = Colors.black45;
const kPrimaryTextColorDark = Colors.white;
const kSecondaryTextColorDark = Colors.white70;
const kTipsTextColorDark = Colors.white70;
