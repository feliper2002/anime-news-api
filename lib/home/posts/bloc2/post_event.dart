abstract class PostEvent {}

class PostParameters extends PostEvent {
  final int page;
  final int offset;

  PostParameters({this.page = 1, this.offset = 10});
}

class InitialEvent extends PostEvent {}
