// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Exercise _$ExerciseFromJson(Map<String, dynamic> json) => Exercise(
      id: json['id'] as String,
      name: json['name'] as String,
      primaryMuscles: (json['primaryMuscles'] as List<dynamic>)
          .map((e) => $enumDecode(_$MuscleEnumMap, e))
          .toList(),
      secondaryMuscles: (json['secondaryMuscles'] as List<dynamic>)
          .map((e) => $enumDecode(_$MuscleEnumMap, e))
          .toList(),
      level: $enumDecode(_$LevelEnumMap, json['level']),
      category: $enumDecode(_$ExerciseCategoryEnumMap, json['category']),
      instructions: (json['instructions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      tips: (json['tips'] as List<dynamic>?)?.map((e) => e as String).toList(),
      force: $enumDecodeNullable(_$ForceEnumMap, json['force']),
      mechanicType:
          $enumDecodeNullable(_$MechanicTypeEnumMap, json['mechanic']),
      equipment: $enumDecodeNullable(_$EquipmentEnumMap, json['equipment']),
      description: json['description'] as String?,
      aliases:
          (json['aliases'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ExerciseToJson(Exercise instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('aliases', instance.aliases);
  val['primaryMuscles'] =
      instance.primaryMuscles.map((e) => _$MuscleEnumMap[e]!).toList();
  val['secondaryMuscles'] =
      instance.secondaryMuscles.map((e) => _$MuscleEnumMap[e]!).toList();
  val['force'] = _$ForceEnumMap[instance.force];
  val['level'] = _$LevelEnumMap[instance.level]!;
  writeNotNull('mechanic', _$MechanicTypeEnumMap[instance.mechanicType]);
  writeNotNull('equipment', _$EquipmentEnumMap[instance.equipment]);
  val['category'] = _$ExerciseCategoryEnumMap[instance.category]!;
  val['instructions'] = instance.instructions;
  writeNotNull('description', instance.description);
  writeNotNull('tips', instance.tips);
  return val;
}

const _$MuscleEnumMap = {
  Muscle.abdominals: 'abdominals',
  Muscle.hamstrings: 'hamstrings',
  Muscle.calves: 'calves',
  Muscle.shoulders: 'shoulders',
  Muscle.adductors: 'adductors',
  Muscle.glutes: 'glutes',
  Muscle.quadriceps: 'quadriceps',
  Muscle.biceps: 'biceps',
  Muscle.forearms: 'forearms',
  Muscle.abductors: 'abductors',
  Muscle.triceps: 'triceps',
  Muscle.chest: 'chest',
  Muscle.lowerBack: 'lower back',
  Muscle.traps: 'traps',
  Muscle.middleBack: 'middle back',
  Muscle.lats: 'lats',
  Muscle.neck: 'neck',
};

const _$LevelEnumMap = {
  Level.beginner: 'beginner',
  Level.intermediate: 'intermediate',
  Level.advanced: 'advanced',
  Level.expert: 'expert',
};

const _$ExerciseCategoryEnumMap = {
  ExerciseCategory.strength: 'strength',
  ExerciseCategory.stretching: 'stretching',
  ExerciseCategory.plyometrics: 'plyometrics',
  ExerciseCategory.strongman: 'strongman',
  ExerciseCategory.powerlifting: 'powerlifting',
  ExerciseCategory.cardio: 'cardio',
  ExerciseCategory.olympicWeightlifting: 'olympic weightlifting',
  ExerciseCategory.crossfit: 'crossfit',
  ExerciseCategory.weightedBodyweight: 'weighted bodyweight',
  ExerciseCategory.assistedBodyweight: 'assisted bodyweight',
};

const _$ForceEnumMap = {
  Force.pull: 'pull',
  Force.push: 'push',
  Force.static: 'static',
};

const _$MechanicTypeEnumMap = {
  MechanicType.compound: 'compound',
  MechanicType.isolation: 'isolation',
};

const _$EquipmentEnumMap = {
  Equipment.body: 'body only',
  Equipment.machine: 'machine',
  Equipment.kettlebells: 'kettlebells',
  Equipment.dumbbell: 'dumbbell',
  Equipment.cable: 'cable',
  Equipment.barbell: 'barbell',
  Equipment.bands: 'bands',
  Equipment.medicineBall: 'medicine ball',
  Equipment.exerciseBall: 'exercise ball',
  Equipment.eZCurlBar: 'e-z curl bar',
  Equipment.foamRoll: 'foam roll',
  Equipment.other: 'other',
};
