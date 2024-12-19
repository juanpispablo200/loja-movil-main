import 'package:flutter/material.dart';
import 'package:loja_movil/src/presentation/common/loading_icon.widget.dart';

class LoadingView extends StatelessWidget {
  final bool? isLoading;
  final Widget child;
  final Color? backgroundColor;
  final Widget? floatingActionButton;
  final PreferredSizeWidget? appBar;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final Widget? drawer;

  const LoadingView({
    super.key,
    this.isLoading = false,
    required this.child,
    this.backgroundColor,
    this.floatingActionButton,
    this.appBar,
    this.floatingActionButtonLocation = FloatingActionButtonLocation.endFloat,
    this.drawer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      floatingActionButton: floatingActionButton ?? const SizedBox.shrink(),
      floatingActionButtonLocation: floatingActionButtonLocation,
      appBar: appBar,
      drawer: drawer,
      body: Stack(
        children: [
          child,
          if (isLoading!)
            Container(
              color: Colors.black26,
              child: const Center(
                child: LoadingIcon(),
              ),
            )
        ],
      ),
    );
  }
}
