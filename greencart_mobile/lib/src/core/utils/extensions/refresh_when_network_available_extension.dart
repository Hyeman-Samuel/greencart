import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Copied from https://github.com/bamlab/riverpod_community_extensions

/// A stream provider that listens to network connectivity changes.
final connectivityStreamProvider = StreamProvider(
  (Ref ref) => Connectivity().onConnectivityChanged.distinct(),
);

/// Adds network-aware refresh functionality to
/// AutoDisposeFutureProviderRef<T> objects.
/// This extension uses the connectivity_plus package to listen for network
/// status changes and refreshes the provider when the network becomes
/// available if it's in error state.
///
/// See [refreshWhenNetworkAvailable]
extension RefreshWhenNetworkAvailableExtension<T>
    on AutoDisposeFutureProviderRef<T> {
  /// Refreshes the provider when the network becomes available after being
  /// unavailable, if the provider is in error state.
  ///
  /// Example usages:
  ///
  /// without codegen:
  /// ```dart
  /// final myProvider = FutureProvider.autoDispose<int>((MyProviderRef ref) async {
  ///   ref.refreshWhenNetworkAvailable();
  ///   final result = await fetchData(); // Assume fetchData is a function that fetches data over the network.
  ///   return result;
  /// });
  /// ```
  ///
  /// with codegen:
  /// ```dart
  /// @riverpod
  /// Future<int> myProvider(Ref ref) async {
  ///   ref.refreshWhenNetworkAvailable();
  ///   final result = await fetchData();
  ///   return result;
  /// }
  /// ```
  void refreshWhenNetworkAvailable() {
    var isNetworkAvailable = false;
    const validResults = [
      ConnectivityResult.mobile,
      ConnectivityResult.wifi,
      ConnectivityResult.ethernet,
      ConnectivityResult.vpn,
      ConnectivityResult.other,
    ];

    listen(connectivityStreamProvider, (_, connectivityResults) {
      connectivityResults.whenData((data) {
        final currentlyAvailable =
            data.any((result) => validResults.contains(result));
        if (currentlyAvailable && !isNetworkAvailable) {
          isNetworkAvailable = true;
          if (state.hasError) {
            invalidateSelf();
          }
        } else {
          isNetworkAvailable = false;
        }
      });
    });
  }
}
