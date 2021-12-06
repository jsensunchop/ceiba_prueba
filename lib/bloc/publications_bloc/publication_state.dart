part of 'publication_bloc.dart';


abstract class PublicationState extends Equatable {}

class InitialPublicationState extends PublicationState{
  @override
  List<Object> get props => [];
}

class PublicationsFetched extends PublicationState {
  final List<PostResponse> posts;

  PublicationsFetched(this.posts);

  @override
  List<Object> get props => [posts];
}

class FetchingPublications extends PublicationState{
  @override
  List<Object> get props => [];


}class Fetching extends PublicationState{
  @override
  List<Object> get props => [];
}