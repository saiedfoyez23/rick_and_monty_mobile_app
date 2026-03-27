import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rick_and_morty_mobile_app/controller/dashboard_controller.dart';
import 'package:rick_and_morty_mobile_app/provider/providers.dart';
import 'package:rick_and_morty_mobile_app/state/dashboard_state.dart';


class DashboardView extends ConsumerWidget {
  const DashboardView({super.key, required this.selectIndex});
  final int selectIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(dashboardProvider(selectIndex));
    final controller = ref.read(dashboardProvider(selectIndex).notifier);

    return Scaffold(
      body: state.pages[state.selectIndex],
      bottomNavigationBar: _bottomBar(state, controller),
    );
  }


  Widget _bottomBar(DashboardState state, DashboardController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 7),
      height: 65,
      decoration: BoxDecoration(
        color: const Color(0xFF1A1C2C),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 40),
          _navItem(icon: Icons.home, index: 0, state: state, controller: controller),
          _navItem(icon: Icons.grid_view_rounded, index: 1, state: state, controller: controller),

          FloatingActionButton(
            onPressed: () {},
            backgroundColor: const Color(0xFF6C5CE7),
            child: const Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required int index,
    required DashboardState state,
    required DashboardController controller,
  }) {
    final isSelected = state.selectIndex == index;

    return InkWell(
      onTap: () {
        controller.changeIndex(index);
      },
      child: Icon(
        icon,
        size: 26,
        color: isSelected ? Colors.white : Colors.white38,
      ),
    );
  }
}