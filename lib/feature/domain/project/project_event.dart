abstract class ProjectEvent {}

class ProjectLoad extends ProjectEvent {
  final String query;

  ProjectLoad(this.query);
}

class ProjectLoadMore extends ProjectEvent {
  final String query;

  ProjectLoadMore(this.query);
}