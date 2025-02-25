import 'package:app_models/app_models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitts/utils/data_loading_status.dart';
import 'package:formz/formz.dart';
import 'package:workouts_repository/workouts_repository.dart';

part 'workout_details_event.dart';
part 'workout_details_state.dart';

/// {@template workout_details_bloc}
/// BLoC for the WorkoutDetailsPage.
/// {@endtemplate}
class WorkoutDetailsBloc
    extends Bloc<WorkoutDetailsEvent, WorkoutDetailsState> {
  /// {@macro workout_details_bloc}
  WorkoutDetailsBloc({
    required String workoutTemplateId,
    required WorkoutsRepository workoutsRepository,
  })  : _workoutsRepository = workoutsRepository,
        _workoutTemplateId = workoutTemplateId,
        super(const WorkoutDetailsState()) {
    on<WorkoutTemplateSubscriptionRequested>(
      _onWorkoutTemplatesSubscriptionRequested,
    );
    on<WorkoutTemplateDeleteTemplate>(
      _onWorkoutTemplateDeleteTemplate,
    );
  }

  final String _workoutTemplateId;
  final WorkoutsRepository _workoutsRepository;

  Future<void> _onWorkoutTemplatesSubscriptionRequested(
    WorkoutTemplateSubscriptionRequested event,
    Emitter<WorkoutDetailsState> emit,
  ) async {
    await emit.forEach<WorkoutTemplate?>(
      _workoutsRepository.getWorkoutTemplateById(
        workoutTemplateId: _workoutTemplateId,
      ),
      onData: (workoutTemplate) {
        return state.copyWith(
          workoutTemplate: workoutTemplate,
          status: DataLoadingStatus.success,
        );
      },
      onError: (_, __) => state.copyWith(
        status: DataLoadingStatus.error,
      ),
    );
  }

  Future<void> _onWorkoutTemplateDeleteTemplate(
    WorkoutTemplateDeleteTemplate event,
    Emitter<WorkoutDetailsState> emit,
  ) async {
    try {
      emit(state.copyWith(deleteStatus: FormzStatus.submissionInProgress));
      await _workoutsRepository.deleteWorkoutTemplate(
        workoutTemplateId: _workoutTemplateId,
      );
      emit(state.copyWith(deleteStatus: FormzStatus.submissionSuccess));
    } catch (e, st) {
      emit(state.copyWith(deleteStatus: FormzStatus.submissionFailure));
      addError(e, st);
    }
  }
}
