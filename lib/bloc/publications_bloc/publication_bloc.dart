import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica/data/provider/db_dao.dart';
import 'package:prueba_tecnica/data/provider/db_provider.dart';
import 'package:prueba_tecnica/data/repositories/user_repo.dart';
import 'package:prueba_tecnica/domain/entities/post_response.dart';


part 'publication_event.dart';

part 'publication_state.dart';

class PublicationBloc extends Bloc<PublicationEvent, PublicationState> {
  PublicationBloc(this.userRepo) : super(InitialPublicationState());

  final UserRepo userRepo ;


  @override
  void onTransition(Transition<PublicationEvent, PublicationState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<PublicationState> mapEventToState(PublicationEvent event) async* {
    if (event is FetchPublication) {
      yield FetchingPublications();
      try {
        final data = await userRepo.fetchPosts();
        DBProvider.db.createPost(data[0]);
        yield PublicationsFetched(data);
      } catch (error) {
        yield Fetching();
        print(error);
      }
    }
  }

  PublicationState get initialState => InitialPublicationState();
}
