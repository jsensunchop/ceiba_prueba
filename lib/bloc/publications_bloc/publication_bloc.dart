import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_tecnica/data/provider/db_provider.dart';
import 'package:prueba_tecnica/data/repositories/user_repo.dart';
import 'package:prueba_tecnica/domain/entities/post_response.dart';
import 'package:prueba_tecnica/domain/entities/publications_response.dart';


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
        DBProvider.db.database;
        print(data.length);

        for (var pub in data) {
          DBProvider.db.createPublication(pub);
        }
        final data_db1 = await DBProvider.db.getPublications();

        yield PublicationsFetched(data_db1);
      } catch (error) {
        yield Fetching();
        print(error);
      }
    }
  }

  PublicationState get initialState => InitialPublicationState();
}
