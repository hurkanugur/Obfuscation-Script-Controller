import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:obfuscation_controller/app/presentation/editor/view/editor_view.dart';
import 'package:obfuscation_controller/app/presentation/home/view/home_view.dart';
import 'package:obfuscation_controller/app/presentation/launch/view/launch_view.dart';
import 'package:obfuscation_controller/core/router/enum/router_type.dart';

extension RouterExtension on BuildContext {
  /// This method returns the main app navigation key.
  static final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  /// This method returns the current active context.
  static BuildContext get context => _navigatorKey.currentContext!;

  /// Static instance of [GoRouter] for application-wide routing.
  static final GoRouter goRouter = GoRouter(
    navigatorKey: _navigatorKey,
    routes: <RouteBase>[
      GoRoute(
        path: RouterType.launch.relativePath,
        pageBuilder: (BuildContext context, GoRouterState state) => CupertinoPage<void>(
          key: state.pageKey,
          child: const LaunchView(),
        ),
        routes: <RouteBase>[
          GoRoute(
            path: RouterType.home.relativePath,
            pageBuilder: (BuildContext context, GoRouterState state) => CupertinoPage<void>(
              key: state.pageKey,
              child: const HomeView(),
            ),
          ),
          GoRoute(
            path: RouterType.editor.relativePath,
            pageBuilder: (BuildContext context, GoRouterState state) => CupertinoPage<void>(
              key: state.pageKey,
              child: const EditorView(),
            ),
          )
        ],
      ),
    ],
  );

  /// Opens a new page using the GoRouter.
  void goTo({required RouterType routerType}) => GoRouter.of(this).go(routerType.absolutePath);

  /// Closes the current page using the GoRouter.
  void goBack() => GoRouter.of(this).pop();

  /// Retrieves the current location from the router.
  String getCurrentLocation() {
    final RouteMatch lastMatch = goRouter.routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch ? lastMatch.matches : goRouter.routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }
}
