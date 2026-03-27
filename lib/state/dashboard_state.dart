import 'package:flutter/material.dart';

class DashboardState {
  final int selectIndex;
  final List<Widget> pages;


  const DashboardState({
    required this.selectIndex,
    required this.pages,
  });

  DashboardState copyWith({
    int? selectIndex,
    List<Widget>? pages,
  }) {
    return DashboardState(
      selectIndex: selectIndex ?? this.selectIndex,
      pages: pages ?? this.pages,
    );
  }
}