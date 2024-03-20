// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

/// A collection of ways to create blank space that make the code easier
/// to read, write, and maintain. It contains horizontal and vertical spacing,
/// as well as customized, preset padding values.
///
// MARGINS
const horizontalMargin2 = SizedBox(width: 2.0);
const horizontalMargin4 = SizedBox(width: 4.0);
const horizontalMargin6 = SizedBox(width: 6.0);
const horizontalMargin8 = SizedBox(width: 8.0);
const horizontalMargin12 = SizedBox(width: 12.0);
const horizontalMargin16 = SizedBox(width: 16.0);
const horizontalMargin24 = SizedBox(width: 24.0);
const horizontalMargin32 = SizedBox(width: 32.0);
const horizontalMargin36 = SizedBox(width: 36.0);
const horizontalMargin48 = SizedBox(width: 48.0);
const horizontalMargin56 = SizedBox(width: 56.0);
const horizontalMargin64 = SizedBox(width: 64.0);

const verticalMargin4 = SizedBox(height: 4.0);
const verticalMargin6 = SizedBox(height: 6.0);
const verticalMargin8 = SizedBox(height: 8.0);
const verticalMargin12 = SizedBox(height: 12.0);
const verticalMargin16 = SizedBox(height: 16.0);
const verticalMargin18 = SizedBox(height: 18.0);
const verticalMargin20 = SizedBox(height: 20.0);
const verticalMargin24 = SizedBox(height: 24.0);
const verticalMargin32 = SizedBox(height: 32.0);
const verticalMargin36 = SizedBox(height: 32.0);
const verticalMargin48 = SizedBox(height: 48.0);
const verticalMargin64 = SizedBox(height: 64.0);

const sliverVerticalMargin4 = SliverToBoxAdapter(child: SizedBox(height: 4.0));
const sliverVerticalMargin8 = SliverToBoxAdapter(child: SizedBox(height: 8.0));
const sliverVerticalMargin12 = SliverToBoxAdapter(child: SizedBox(height: 12.0));
const sliverVerticalMargin16 = SliverToBoxAdapter(child: SizedBox(height: 16.0));
const sliverVerticalMargin24 = SliverToBoxAdapter(child: SizedBox(height: 24.0));
const sliverVerticalMargin32 = SliverToBoxAdapter(child: SizedBox(height: 32.0));
const sliverVerticalMargin48 = SliverToBoxAdapter(child: SizedBox(height: 48.0));

// PADDINGS
const emptyPadding = EdgeInsets.zero;

const allPadding4 = EdgeInsets.all(4.0);
const allPadding8 = EdgeInsets.all(8.0);
const allPadding12 = EdgeInsets.all(12.0);
const allPadding16 = EdgeInsets.all(16.0);
const allPadding24 = EdgeInsets.all(24.0);
const allPadding32 = EdgeInsets.all(32.0);
const allPadding48 = EdgeInsets.all(48.0);

const leftPadding4 = EdgeInsets.only(left: 4.0);
const leftPadding8 = EdgeInsets.only(left: 8.0);
const leftPadding12 = EdgeInsets.only(left: 12.0);
const leftPadding16 = EdgeInsets.only(left: 16.0);
const leftPadding24 = EdgeInsets.only(left: 24.0);
const leftPadding32 = EdgeInsets.only(left: 32.0);
const leftPadding48 = EdgeInsets.only(left: 48.0);

const topPadding1 = EdgeInsets.only(top: 1.0);
const topPadding2 = EdgeInsets.only(top: 2.0);
const topPadding4 = EdgeInsets.only(top: 4.0);
const topPadding8 = EdgeInsets.only(top: 8.0);
const topPadding12 = EdgeInsets.only(top: 12.0);
const topPadding16 = EdgeInsets.only(top: 16.0);
const topPadding24 = EdgeInsets.only(top: 24.0);
const topPadding32 = EdgeInsets.only(top: 32.0);
const topPadding48 = EdgeInsets.only(top: 48.0);

const rightPadding4 = EdgeInsets.only(right: 4.0);
const rightPadding8 = EdgeInsets.only(right: 8.0);
const rightPadding12 = EdgeInsets.only(right: 12.0);
const rightPadding16 = EdgeInsets.only(right: 16.0);
const rightPadding24 = EdgeInsets.only(right: 24.0);
const rightPadding32 = EdgeInsets.only(right: 32.0);
const rightPadding48 = EdgeInsets.only(right: 48.0);

const bottomPadding1 = EdgeInsets.only(bottom: 1.0);
const bottomPadding2 = EdgeInsets.only(bottom: 2.0);
const bottomPadding4 = EdgeInsets.only(bottom: 4.0);
const bottomPadding8 = EdgeInsets.only(bottom: 8.0);
const bottomPadding12 = EdgeInsets.only(bottom: 12.0);
const bottomPadding16 = EdgeInsets.only(bottom: 16.0);
const bottomPadding24 = EdgeInsets.only(bottom: 24.0);
const bottomPadding32 = EdgeInsets.only(bottom: 32.0);
const bottomPadding36 = EdgeInsets.only(bottom: 36.0);
const bottomPadding48 = EdgeInsets.only(bottom: 48.0);

const horizontalPadding2 = EdgeInsets.symmetric(horizontal: 2.0);
const horizontalPadding4 = EdgeInsets.symmetric(horizontal: 4.0);
const horizontalPadding8 = EdgeInsets.symmetric(horizontal: 8.0);
const horizontalPadding12 = EdgeInsets.symmetric(horizontal: 12.0);
const horizontalPadding16 = EdgeInsets.symmetric(horizontal: 16.0);
const horizontalPadding20 = EdgeInsets.symmetric(horizontal: 20.0);
const horizontalPadding24 = EdgeInsets.symmetric(horizontal: 24.0);
const horizontalPadding32 = EdgeInsets.symmetric(horizontal: 32.0);
const horizontalPadding36 = EdgeInsets.symmetric(horizontal: 36.0);
const horizontalPadding48 = EdgeInsets.symmetric(horizontal: 48.0);
const horizontalPadding64 = EdgeInsets.symmetric(horizontal: 64.0);
const horizontalPadding82 = EdgeInsets.symmetric(horizontal: 82.0);
const horizontalPadding106 = EdgeInsets.symmetric(horizontal: 106.0);

const verticalPadding4 = EdgeInsets.symmetric(vertical: 4.0);
const verticalPadding6 = EdgeInsets.symmetric(vertical: 6.0);
const verticalPadding8 = EdgeInsets.symmetric(vertical: 8.0);
const verticalPadding12 = EdgeInsets.symmetric(vertical: 12.0);
const verticalPadding16 = EdgeInsets.symmetric(vertical: 16.0);
const verticalPadding20 = EdgeInsets.symmetric(vertical: 20.0);
const verticalPadding24 = EdgeInsets.symmetric(vertical: 24.0);
const verticalPadding32 = EdgeInsets.symmetric(vertical: 32.0);
const verticalPadding48 = EdgeInsets.symmetric(vertical: 48.0);
const verticalPadding106 = EdgeInsets.symmetric(vertical: 106.0);

// Empty widgets used as fillers where you have to put something to maintain spacing, but you don't have anything of substance to use.
const emptyWidget = SizedBox();
const emptyWideWidget = SizedBox(width: double.infinity);
