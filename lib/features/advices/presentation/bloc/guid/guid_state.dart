part of 'guid_bloc.dart';

class GuidState extends Equatable {
  final GuidStatus status;
  final bool isSaved;
  final String? errorMessage;
  final GuidEntity? guidList;

  const GuidState({
    required this.status,
    required this.isSaved,
    this.errorMessage,
    this.guidList,
  });

  GuidState copyWith({
    GuidStatus? status,
    bool? isSaved,
    String? errorMessage,
    GuidEntity? guidList,
  }) {
    return GuidState(
      status: status ?? this.status,
      isSaved: isSaved ?? this.isSaved,
      errorMessage: errorMessage ?? this.errorMessage,
      guidList: guidList ?? this.guidList,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isSaved,
        errorMessage,
        guidList,
      ];
}

enum GuidStatus { initial, loading, success, error, refreshing }

extension GuidStatusX on GuidStatus {
  bool get isInitial => this == GuidStatus.initial;

  bool get isLoading => this == GuidStatus.loading;

  bool get isSuccess => this == GuidStatus.success;

  bool get isError => this == GuidStatus.error;

  bool get isRefreshing => this == GuidStatus.refreshing;
}
