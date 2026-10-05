import 'package:bloc/bloc.dart';
import '../../../core/errors/app_failure.dart';
import '../../../core/presentation/load_state.dart';
import '../domain/profile_repository.dart';
import '../domain/profile_use_cases.dart';

class ProfileCubit extends Cubit<LoadState<UserProfile>> {
  ProfileCubit(this.getMyProfile) : super(const LoadState());
  final GetMyProfile getMyProfile;
  Future<void> load() async {
    emit(const LoadState(status: LoadStatus.loading));
    try {
      final profile = await getMyProfile();
      if (!isClosed) emit(LoadState(status: LoadStatus.success, data: profile));
    } on AppFailure catch (error) {
      if (!isClosed) emit(LoadState(status: LoadStatus.failure, failure: error));
    }
  }
}
class WorkerProfileCubit extends Cubit<LoadState<UserProfile>> {
  WorkerProfileCubit(this.getProfile) : super(const LoadState());
  final GetProfile getProfile;
  Future<void> load(String id) async {
    emit(const LoadState(status: LoadStatus.loading));
    try {
      final profile = await getProfile(id);
      if (!isClosed) emit(LoadState(status: LoadStatus.success, data: profile));
    } on AppFailure catch (error) {
      if (!isClosed) emit(LoadState(status: LoadStatus.failure, failure: error));
    }
  }
}
class EditProfileCubit extends Cubit<LoadState<UserProfile>> {
  EditProfileCubit(UserProfile profile, this.update, this.updatePhoto)
    : super(LoadState(status: LoadStatus.initial, data: profile));
  final UpdateProfile update;
  final UpdateProfilePhoto updatePhoto;
  Future<void> save(ProfileChanges changes, {String? photoPath}) async {
    if (state.status == LoadStatus.loading) return;
    var profile = state.data!;
    emit(LoadState(status: LoadStatus.loading, data: profile));
    try {
      profile = await update(changes);
      if (photoPath != null) profile = await updatePhoto(photoPath);
      if (!isClosed) emit(LoadState(status: LoadStatus.success, data: profile));
    } on AppFailure catch (error) {
      // Retain the successful text update when a photo upload fails; allow retry.
      if (!isClosed) emit(LoadState(status: LoadStatus.failure, data: profile, failure: error));
    }
  }
}
