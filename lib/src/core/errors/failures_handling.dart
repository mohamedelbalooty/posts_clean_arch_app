import 'package:tdd_app/src/core/errors/failures.dart';

class FailuresHandling {
  String onHandlingFailures({required Failure failure}) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Error occurred, please try again !';
      case CacheFailure:
        return 'No data available !';
      case OfflineFailure:
        return 'Check your internet connection !';
      default:
        return 'Something went wrong occurred, try again later !';
    }
  }
}
