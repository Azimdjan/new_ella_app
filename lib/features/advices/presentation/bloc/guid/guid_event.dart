part of 'guid_bloc.dart';

abstract class GuidEvent extends Equatable {
  const GuidEvent();
}

class GuidLoad extends GuidEvent {
  final num id;

  const GuidLoad(this.id);

  @override
  List<Object> get props => [id];
}

class GuidRefresh extends GuidEvent {
  final num id;

  const GuidRefresh(this.id);

  @override
  List<Object> get props => [id];
}

class GuidSave extends GuidEvent {
  final num id;

  const GuidSave(this.id);

  @override
  List<Object> get props => [id];
}