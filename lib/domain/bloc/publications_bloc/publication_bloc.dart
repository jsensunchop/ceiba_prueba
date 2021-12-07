import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    super.onTransition(transition);
  }

  @override
  Stream<PublicationState> mapEventToState(PublicationEvent event) async* {
    if (event is FetchPublication) {
      yield FetchingPublications();
      try {
        //consuming api
        final data = await userRepo.fetchPosts();

        //instantiate database
        DBProvider.db.database;

        //delete previous saved POSTS Database Table
        DBProvider.db.deleteAllPosts();

        //fill PUBLICACION table with api data
        for (var pub in data) {
          DBProvider.db.createPublication(pub);
        }

        //get the Posts table
        final dataDb1 = await DBProvider.db.getPublications();

        //database successfully fetched
        yield PublicationsFetched(dataDb1);
      } catch (error) {
        ///EVENTO DE ERROR
        yield ErrorFetching();
      }
    }
  }

  PublicationState get initialState => InitialPublicationState();
}
