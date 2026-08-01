// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ProfilesTable extends Profiles with TableInfo<$ProfilesTable, Profile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
    'date_of_birth',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _experienceMeta = const VerificationMeta(
    'experience',
  );
  @override
  late final GeneratedColumn<String> experience = GeneratedColumn<String>(
    'experience',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _equipmentMeta = const VerificationMeta(
    'equipment',
  );
  @override
  late final GeneratedColumn<String> equipment = GeneratedColumn<String>(
    'equipment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalMeta = const VerificationMeta('goal');
  @override
  late final GeneratedColumn<String> goal = GeneratedColumn<String>(
    'goal',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parqPassedMeta = const VerificationMeta(
    'parqPassed',
  );
  @override
  late final GeneratedColumn<bool> parqPassed = GeneratedColumn<bool>(
    'parq_passed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("parq_passed" IN (0, 1))',
    ),
  );
  static const VerificationMeta _acceptedTermsMeta = const VerificationMeta(
    'acceptedTerms',
  );
  @override
  late final GeneratedColumn<bool> acceptedTerms = GeneratedColumn<bool>(
    'accepted_terms',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("accepted_terms" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    gender,
    dateOfBirth,
    weightKg,
    heightCm,
    experience,
    equipment,
    goal,
    parqPassed,
    acceptedTerms,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Profile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateOfBirthMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    } else if (isInserting) {
      context.missing(_heightCmMeta);
    }
    if (data.containsKey('experience')) {
      context.handle(
        _experienceMeta,
        experience.isAcceptableOrUnknown(data['experience']!, _experienceMeta),
      );
    } else if (isInserting) {
      context.missing(_experienceMeta);
    }
    if (data.containsKey('equipment')) {
      context.handle(
        _equipmentMeta,
        equipment.isAcceptableOrUnknown(data['equipment']!, _equipmentMeta),
      );
    } else if (isInserting) {
      context.missing(_equipmentMeta);
    }
    if (data.containsKey('goal')) {
      context.handle(
        _goalMeta,
        goal.isAcceptableOrUnknown(data['goal']!, _goalMeta),
      );
    } else if (isInserting) {
      context.missing(_goalMeta);
    }
    if (data.containsKey('parq_passed')) {
      context.handle(
        _parqPassedMeta,
        parqPassed.isAcceptableOrUnknown(data['parq_passed']!, _parqPassedMeta),
      );
    } else if (isInserting) {
      context.missing(_parqPassedMeta);
    }
    if (data.containsKey('accepted_terms')) {
      context.handle(
        _acceptedTermsMeta,
        acceptedTerms.isAcceptableOrUnknown(
          data['accepted_terms']!,
          _acceptedTermsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_acceptedTermsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Profile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Profile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      )!,
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_of_birth'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      )!,
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      )!,
      experience: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}experience'],
      )!,
      equipment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment'],
      )!,
      goal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal'],
      )!,
      parqPassed: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}parq_passed'],
      )!,
      acceptedTerms: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}accepted_terms'],
      )!,
    );
  }

  @override
  $ProfilesTable createAlias(String alias) {
    return $ProfilesTable(attachedDatabase, alias);
  }
}

class Profile extends DataClass implements Insertable<Profile> {
  final int id;
  final String gender;
  final DateTime dateOfBirth;
  final double weightKg;
  final double heightCm;
  final String experience;
  final String equipment;
  final String goal;
  final bool parqPassed;
  final bool acceptedTerms;
  const Profile({
    required this.id,
    required this.gender,
    required this.dateOfBirth,
    required this.weightKg,
    required this.heightCm,
    required this.experience,
    required this.equipment,
    required this.goal,
    required this.parqPassed,
    required this.acceptedTerms,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['gender'] = Variable<String>(gender);
    map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    map['weight_kg'] = Variable<double>(weightKg);
    map['height_cm'] = Variable<double>(heightCm);
    map['experience'] = Variable<String>(experience);
    map['equipment'] = Variable<String>(equipment);
    map['goal'] = Variable<String>(goal);
    map['parq_passed'] = Variable<bool>(parqPassed);
    map['accepted_terms'] = Variable<bool>(acceptedTerms);
    return map;
  }

  ProfilesCompanion toCompanion(bool nullToAbsent) {
    return ProfilesCompanion(
      id: Value(id),
      gender: Value(gender),
      dateOfBirth: Value(dateOfBirth),
      weightKg: Value(weightKg),
      heightCm: Value(heightCm),
      experience: Value(experience),
      equipment: Value(equipment),
      goal: Value(goal),
      parqPassed: Value(parqPassed),
      acceptedTerms: Value(acceptedTerms),
    );
  }

  factory Profile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Profile(
      id: serializer.fromJson<int>(json['id']),
      gender: serializer.fromJson<String>(json['gender']),
      dateOfBirth: serializer.fromJson<DateTime>(json['dateOfBirth']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      heightCm: serializer.fromJson<double>(json['heightCm']),
      experience: serializer.fromJson<String>(json['experience']),
      equipment: serializer.fromJson<String>(json['equipment']),
      goal: serializer.fromJson<String>(json['goal']),
      parqPassed: serializer.fromJson<bool>(json['parqPassed']),
      acceptedTerms: serializer.fromJson<bool>(json['acceptedTerms']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gender': serializer.toJson<String>(gender),
      'dateOfBirth': serializer.toJson<DateTime>(dateOfBirth),
      'weightKg': serializer.toJson<double>(weightKg),
      'heightCm': serializer.toJson<double>(heightCm),
      'experience': serializer.toJson<String>(experience),
      'equipment': serializer.toJson<String>(equipment),
      'goal': serializer.toJson<String>(goal),
      'parqPassed': serializer.toJson<bool>(parqPassed),
      'acceptedTerms': serializer.toJson<bool>(acceptedTerms),
    };
  }

  Profile copyWith({
    int? id,
    String? gender,
    DateTime? dateOfBirth,
    double? weightKg,
    double? heightCm,
    String? experience,
    String? equipment,
    String? goal,
    bool? parqPassed,
    bool? acceptedTerms,
  }) => Profile(
    id: id ?? this.id,
    gender: gender ?? this.gender,
    dateOfBirth: dateOfBirth ?? this.dateOfBirth,
    weightKg: weightKg ?? this.weightKg,
    heightCm: heightCm ?? this.heightCm,
    experience: experience ?? this.experience,
    equipment: equipment ?? this.equipment,
    goal: goal ?? this.goal,
    parqPassed: parqPassed ?? this.parqPassed,
    acceptedTerms: acceptedTerms ?? this.acceptedTerms,
  );
  Profile copyWithCompanion(ProfilesCompanion data) {
    return Profile(
      id: data.id.present ? data.id.value : this.id,
      gender: data.gender.present ? data.gender.value : this.gender,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      experience: data.experience.present
          ? data.experience.value
          : this.experience,
      equipment: data.equipment.present ? data.equipment.value : this.equipment,
      goal: data.goal.present ? data.goal.value : this.goal,
      parqPassed: data.parqPassed.present
          ? data.parqPassed.value
          : this.parqPassed,
      acceptedTerms: data.acceptedTerms.present
          ? data.acceptedTerms.value
          : this.acceptedTerms,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Profile(')
          ..write('id: $id, ')
          ..write('gender: $gender, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('weightKg: $weightKg, ')
          ..write('heightCm: $heightCm, ')
          ..write('experience: $experience, ')
          ..write('equipment: $equipment, ')
          ..write('goal: $goal, ')
          ..write('parqPassed: $parqPassed, ')
          ..write('acceptedTerms: $acceptedTerms')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    gender,
    dateOfBirth,
    weightKg,
    heightCm,
    experience,
    equipment,
    goal,
    parqPassed,
    acceptedTerms,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Profile &&
          other.id == this.id &&
          other.gender == this.gender &&
          other.dateOfBirth == this.dateOfBirth &&
          other.weightKg == this.weightKg &&
          other.heightCm == this.heightCm &&
          other.experience == this.experience &&
          other.equipment == this.equipment &&
          other.goal == this.goal &&
          other.parqPassed == this.parqPassed &&
          other.acceptedTerms == this.acceptedTerms);
}

class ProfilesCompanion extends UpdateCompanion<Profile> {
  final Value<int> id;
  final Value<String> gender;
  final Value<DateTime> dateOfBirth;
  final Value<double> weightKg;
  final Value<double> heightCm;
  final Value<String> experience;
  final Value<String> equipment;
  final Value<String> goal;
  final Value<bool> parqPassed;
  final Value<bool> acceptedTerms;
  const ProfilesCompanion({
    this.id = const Value.absent(),
    this.gender = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.experience = const Value.absent(),
    this.equipment = const Value.absent(),
    this.goal = const Value.absent(),
    this.parqPassed = const Value.absent(),
    this.acceptedTerms = const Value.absent(),
  });
  ProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String gender,
    required DateTime dateOfBirth,
    required double weightKg,
    required double heightCm,
    required String experience,
    required String equipment,
    required String goal,
    required bool parqPassed,
    required bool acceptedTerms,
  }) : gender = Value(gender),
       dateOfBirth = Value(dateOfBirth),
       weightKg = Value(weightKg),
       heightCm = Value(heightCm),
       experience = Value(experience),
       equipment = Value(equipment),
       goal = Value(goal),
       parqPassed = Value(parqPassed),
       acceptedTerms = Value(acceptedTerms);
  static Insertable<Profile> custom({
    Expression<int>? id,
    Expression<String>? gender,
    Expression<DateTime>? dateOfBirth,
    Expression<double>? weightKg,
    Expression<double>? heightCm,
    Expression<String>? experience,
    Expression<String>? equipment,
    Expression<String>? goal,
    Expression<bool>? parqPassed,
    Expression<bool>? acceptedTerms,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gender != null) 'gender': gender,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (weightKg != null) 'weight_kg': weightKg,
      if (heightCm != null) 'height_cm': heightCm,
      if (experience != null) 'experience': experience,
      if (equipment != null) 'equipment': equipment,
      if (goal != null) 'goal': goal,
      if (parqPassed != null) 'parq_passed': parqPassed,
      if (acceptedTerms != null) 'accepted_terms': acceptedTerms,
    });
  }

  ProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? gender,
    Value<DateTime>? dateOfBirth,
    Value<double>? weightKg,
    Value<double>? heightCm,
    Value<String>? experience,
    Value<String>? equipment,
    Value<String>? goal,
    Value<bool>? parqPassed,
    Value<bool>? acceptedTerms,
  }) {
    return ProfilesCompanion(
      id: id ?? this.id,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      weightKg: weightKg ?? this.weightKg,
      heightCm: heightCm ?? this.heightCm,
      experience: experience ?? this.experience,
      equipment: equipment ?? this.equipment,
      goal: goal ?? this.goal,
      parqPassed: parqPassed ?? this.parqPassed,
      acceptedTerms: acceptedTerms ?? this.acceptedTerms,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (experience.present) {
      map['experience'] = Variable<String>(experience.value);
    }
    if (equipment.present) {
      map['equipment'] = Variable<String>(equipment.value);
    }
    if (goal.present) {
      map['goal'] = Variable<String>(goal.value);
    }
    if (parqPassed.present) {
      map['parq_passed'] = Variable<bool>(parqPassed.value);
    }
    if (acceptedTerms.present) {
      map['accepted_terms'] = Variable<bool>(acceptedTerms.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfilesCompanion(')
          ..write('id: $id, ')
          ..write('gender: $gender, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('weightKg: $weightKg, ')
          ..write('heightCm: $heightCm, ')
          ..write('experience: $experience, ')
          ..write('equipment: $equipment, ')
          ..write('goal: $goal, ')
          ..write('parqPassed: $parqPassed, ')
          ..write('acceptedTerms: $acceptedTerms')
          ..write(')'))
        .toString();
  }
}

class $ResultsTable extends Results with TableInfo<$ResultsTable, Result> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ResultsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _videoPathMeta = const VerificationMeta(
    'videoPath',
  );
  @override
  late final GeneratedColumn<String> videoPath = GeneratedColumn<String>(
    'video_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyweightKgMeta = const VerificationMeta(
    'bodyweightKg',
  );
  @override
  late final GeneratedColumn<double> bodyweightKg = GeneratedColumn<double>(
    'bodyweight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    exerciseId,
    value,
    date,
    note,
    videoPath,
    bodyweightKg,
    heightCm,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'results';
  @override
  VerificationContext validateIntegrity(
    Insertable<Result> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('video_path')) {
      context.handle(
        _videoPathMeta,
        videoPath.isAcceptableOrUnknown(data['video_path']!, _videoPathMeta),
      );
    }
    if (data.containsKey('bodyweight_kg')) {
      context.handle(
        _bodyweightKgMeta,
        bodyweightKg.isAcceptableOrUnknown(
          data['bodyweight_kg']!,
          _bodyweightKgMeta,
        ),
      );
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Result map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Result(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      videoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}video_path'],
      ),
      bodyweightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bodyweight_kg'],
      ),
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      ),
    );
  }

  @override
  $ResultsTable createAlias(String alias) {
    return $ResultsTable(attachedDatabase, alias);
  }
}

class Result extends DataClass implements Insertable<Result> {
  final String id;
  final String exerciseId;
  final double value;
  final DateTime date;
  final String? note;
  final String? videoPath;
  final double? bodyweightKg;
  final double? heightCm;
  const Result({
    required this.id,
    required this.exerciseId,
    required this.value,
    required this.date,
    this.note,
    this.videoPath,
    this.bodyweightKg,
    this.heightCm,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['value'] = Variable<double>(value);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || videoPath != null) {
      map['video_path'] = Variable<String>(videoPath);
    }
    if (!nullToAbsent || bodyweightKg != null) {
      map['bodyweight_kg'] = Variable<double>(bodyweightKg);
    }
    if (!nullToAbsent || heightCm != null) {
      map['height_cm'] = Variable<double>(heightCm);
    }
    return map;
  }

  ResultsCompanion toCompanion(bool nullToAbsent) {
    return ResultsCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      value: Value(value),
      date: Value(date),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      videoPath: videoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(videoPath),
      bodyweightKg: bodyweightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyweightKg),
      heightCm: heightCm == null && nullToAbsent
          ? const Value.absent()
          : Value(heightCm),
    );
  }

  factory Result.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Result(
      id: serializer.fromJson<String>(json['id']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      value: serializer.fromJson<double>(json['value']),
      date: serializer.fromJson<DateTime>(json['date']),
      note: serializer.fromJson<String?>(json['note']),
      videoPath: serializer.fromJson<String?>(json['videoPath']),
      bodyweightKg: serializer.fromJson<double?>(json['bodyweightKg']),
      heightCm: serializer.fromJson<double?>(json['heightCm']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'value': serializer.toJson<double>(value),
      'date': serializer.toJson<DateTime>(date),
      'note': serializer.toJson<String?>(note),
      'videoPath': serializer.toJson<String?>(videoPath),
      'bodyweightKg': serializer.toJson<double?>(bodyweightKg),
      'heightCm': serializer.toJson<double?>(heightCm),
    };
  }

  Result copyWith({
    String? id,
    String? exerciseId,
    double? value,
    DateTime? date,
    Value<String?> note = const Value.absent(),
    Value<String?> videoPath = const Value.absent(),
    Value<double?> bodyweightKg = const Value.absent(),
    Value<double?> heightCm = const Value.absent(),
  }) => Result(
    id: id ?? this.id,
    exerciseId: exerciseId ?? this.exerciseId,
    value: value ?? this.value,
    date: date ?? this.date,
    note: note.present ? note.value : this.note,
    videoPath: videoPath.present ? videoPath.value : this.videoPath,
    bodyweightKg: bodyweightKg.present ? bodyweightKg.value : this.bodyweightKg,
    heightCm: heightCm.present ? heightCm.value : this.heightCm,
  );
  Result copyWithCompanion(ResultsCompanion data) {
    return Result(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      value: data.value.present ? data.value.value : this.value,
      date: data.date.present ? data.date.value : this.date,
      note: data.note.present ? data.note.value : this.note,
      videoPath: data.videoPath.present ? data.videoPath.value : this.videoPath,
      bodyweightKg: data.bodyweightKg.present
          ? data.bodyweightKg.value
          : this.bodyweightKg,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Result(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('value: $value, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('videoPath: $videoPath, ')
          ..write('bodyweightKg: $bodyweightKg, ')
          ..write('heightCm: $heightCm')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    exerciseId,
    value,
    date,
    note,
    videoPath,
    bodyweightKg,
    heightCm,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Result &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.value == this.value &&
          other.date == this.date &&
          other.note == this.note &&
          other.videoPath == this.videoPath &&
          other.bodyweightKg == this.bodyweightKg &&
          other.heightCm == this.heightCm);
}

class ResultsCompanion extends UpdateCompanion<Result> {
  final Value<String> id;
  final Value<String> exerciseId;
  final Value<double> value;
  final Value<DateTime> date;
  final Value<String?> note;
  final Value<String?> videoPath;
  final Value<double?> bodyweightKg;
  final Value<double?> heightCm;
  final Value<int> rowid;
  const ResultsCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.value = const Value.absent(),
    this.date = const Value.absent(),
    this.note = const Value.absent(),
    this.videoPath = const Value.absent(),
    this.bodyweightKg = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ResultsCompanion.insert({
    required String id,
    required String exerciseId,
    required double value,
    required DateTime date,
    this.note = const Value.absent(),
    this.videoPath = const Value.absent(),
    this.bodyweightKg = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       exerciseId = Value(exerciseId),
       value = Value(value),
       date = Value(date);
  static Insertable<Result> custom({
    Expression<String>? id,
    Expression<String>? exerciseId,
    Expression<double>? value,
    Expression<DateTime>? date,
    Expression<String>? note,
    Expression<String>? videoPath,
    Expression<double>? bodyweightKg,
    Expression<double>? heightCm,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (value != null) 'value': value,
      if (date != null) 'date': date,
      if (note != null) 'note': note,
      if (videoPath != null) 'video_path': videoPath,
      if (bodyweightKg != null) 'bodyweight_kg': bodyweightKg,
      if (heightCm != null) 'height_cm': heightCm,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ResultsCompanion copyWith({
    Value<String>? id,
    Value<String>? exerciseId,
    Value<double>? value,
    Value<DateTime>? date,
    Value<String?>? note,
    Value<String?>? videoPath,
    Value<double?>? bodyweightKg,
    Value<double?>? heightCm,
    Value<int>? rowid,
  }) {
    return ResultsCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      value: value ?? this.value,
      date: date ?? this.date,
      note: note ?? this.note,
      videoPath: videoPath ?? this.videoPath,
      bodyweightKg: bodyweightKg ?? this.bodyweightKg,
      heightCm: heightCm ?? this.heightCm,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (videoPath.present) {
      map['video_path'] = Variable<String>(videoPath.value);
    }
    if (bodyweightKg.present) {
      map['bodyweight_kg'] = Variable<double>(bodyweightKg.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ResultsCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('value: $value, ')
          ..write('date: $date, ')
          ..write('note: $note, ')
          ..write('videoPath: $videoPath, ')
          ..write('bodyweightKg: $bodyweightKg, ')
          ..write('heightCm: $heightCm, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SettingsRowsTable extends SettingsRows
    with TableInfo<$SettingsRowsTable, SettingsRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _unitsMeta = const VerificationMeta('units');
  @override
  late final GeneratedColumn<String> units = GeneratedColumn<String>(
    'units',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _languageCodeMeta = const VerificationMeta(
    'languageCode',
  );
  @override
  late final GeneratedColumn<String> languageCode = GeneratedColumn<String>(
    'language_code',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scaleTypeMeta = const VerificationMeta(
    'scaleType',
  );
  @override
  late final GeneratedColumn<String> scaleType = GeneratedColumn<String>(
    'scale_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
    'notifications_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notifications_enabled" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    units,
    themeMode,
    languageCode,
    scaleType,
    notificationsEnabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<SettingsRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('units')) {
      context.handle(
        _unitsMeta,
        units.isAcceptableOrUnknown(data['units']!, _unitsMeta),
      );
    } else if (isInserting) {
      context.missing(_unitsMeta);
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    } else if (isInserting) {
      context.missing(_themeModeMeta);
    }
    if (data.containsKey('language_code')) {
      context.handle(
        _languageCodeMeta,
        languageCode.isAcceptableOrUnknown(
          data['language_code']!,
          _languageCodeMeta,
        ),
      );
    }
    if (data.containsKey('scale_type')) {
      context.handle(
        _scaleTypeMeta,
        scaleType.isAcceptableOrUnknown(data['scale_type']!, _scaleTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_scaleTypeMeta);
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
        _notificationsEnabledMeta,
        notificationsEnabled.isAcceptableOrUnknown(
          data['notifications_enabled']!,
          _notificationsEnabledMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_notificationsEnabledMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SettingsRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      units: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}units'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      languageCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language_code'],
      ),
      scaleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scale_type'],
      )!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notifications_enabled'],
      )!,
    );
  }

  @override
  $SettingsRowsTable createAlias(String alias) {
    return $SettingsRowsTable(attachedDatabase, alias);
  }
}

class SettingsRow extends DataClass implements Insertable<SettingsRow> {
  final int id;
  final String units;
  final String themeMode;
  final String? languageCode;
  final String scaleType;
  final bool notificationsEnabled;
  const SettingsRow({
    required this.id,
    required this.units,
    required this.themeMode,
    this.languageCode,
    required this.scaleType,
    required this.notificationsEnabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['units'] = Variable<String>(units);
    map['theme_mode'] = Variable<String>(themeMode);
    if (!nullToAbsent || languageCode != null) {
      map['language_code'] = Variable<String>(languageCode);
    }
    map['scale_type'] = Variable<String>(scaleType);
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    return map;
  }

  SettingsRowsCompanion toCompanion(bool nullToAbsent) {
    return SettingsRowsCompanion(
      id: Value(id),
      units: Value(units),
      themeMode: Value(themeMode),
      languageCode: languageCode == null && nullToAbsent
          ? const Value.absent()
          : Value(languageCode),
      scaleType: Value(scaleType),
      notificationsEnabled: Value(notificationsEnabled),
    );
  }

  factory SettingsRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsRow(
      id: serializer.fromJson<int>(json['id']),
      units: serializer.fromJson<String>(json['units']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      languageCode: serializer.fromJson<String?>(json['languageCode']),
      scaleType: serializer.fromJson<String>(json['scaleType']),
      notificationsEnabled: serializer.fromJson<bool>(
        json['notificationsEnabled'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'units': serializer.toJson<String>(units),
      'themeMode': serializer.toJson<String>(themeMode),
      'languageCode': serializer.toJson<String?>(languageCode),
      'scaleType': serializer.toJson<String>(scaleType),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
    };
  }

  SettingsRow copyWith({
    int? id,
    String? units,
    String? themeMode,
    Value<String?> languageCode = const Value.absent(),
    String? scaleType,
    bool? notificationsEnabled,
  }) => SettingsRow(
    id: id ?? this.id,
    units: units ?? this.units,
    themeMode: themeMode ?? this.themeMode,
    languageCode: languageCode.present ? languageCode.value : this.languageCode,
    scaleType: scaleType ?? this.scaleType,
    notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
  );
  SettingsRow copyWithCompanion(SettingsRowsCompanion data) {
    return SettingsRow(
      id: data.id.present ? data.id.value : this.id,
      units: data.units.present ? data.units.value : this.units,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      languageCode: data.languageCode.present
          ? data.languageCode.value
          : this.languageCode,
      scaleType: data.scaleType.present ? data.scaleType.value : this.scaleType,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SettingsRow(')
          ..write('id: $id, ')
          ..write('units: $units, ')
          ..write('themeMode: $themeMode, ')
          ..write('languageCode: $languageCode, ')
          ..write('scaleType: $scaleType, ')
          ..write('notificationsEnabled: $notificationsEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    units,
    themeMode,
    languageCode,
    scaleType,
    notificationsEnabled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsRow &&
          other.id == this.id &&
          other.units == this.units &&
          other.themeMode == this.themeMode &&
          other.languageCode == this.languageCode &&
          other.scaleType == this.scaleType &&
          other.notificationsEnabled == this.notificationsEnabled);
}

class SettingsRowsCompanion extends UpdateCompanion<SettingsRow> {
  final Value<int> id;
  final Value<String> units;
  final Value<String> themeMode;
  final Value<String?> languageCode;
  final Value<String> scaleType;
  final Value<bool> notificationsEnabled;
  const SettingsRowsCompanion({
    this.id = const Value.absent(),
    this.units = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.languageCode = const Value.absent(),
    this.scaleType = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
  });
  SettingsRowsCompanion.insert({
    this.id = const Value.absent(),
    required String units,
    required String themeMode,
    this.languageCode = const Value.absent(),
    required String scaleType,
    required bool notificationsEnabled,
  }) : units = Value(units),
       themeMode = Value(themeMode),
       scaleType = Value(scaleType),
       notificationsEnabled = Value(notificationsEnabled);
  static Insertable<SettingsRow> custom({
    Expression<int>? id,
    Expression<String>? units,
    Expression<String>? themeMode,
    Expression<String>? languageCode,
    Expression<String>? scaleType,
    Expression<bool>? notificationsEnabled,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (units != null) 'units': units,
      if (themeMode != null) 'theme_mode': themeMode,
      if (languageCode != null) 'language_code': languageCode,
      if (scaleType != null) 'scale_type': scaleType,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
    });
  }

  SettingsRowsCompanion copyWith({
    Value<int>? id,
    Value<String>? units,
    Value<String>? themeMode,
    Value<String?>? languageCode,
    Value<String>? scaleType,
    Value<bool>? notificationsEnabled,
  }) {
    return SettingsRowsCompanion(
      id: id ?? this.id,
      units: units ?? this.units,
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
      scaleType: scaleType ?? this.scaleType,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (units.present) {
      map['units'] = Variable<String>(units.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (languageCode.present) {
      map['language_code'] = Variable<String>(languageCode.value);
    }
    if (scaleType.present) {
      map['scale_type'] = Variable<String>(scaleType.value);
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsRowsCompanion(')
          ..write('id: $id, ')
          ..write('units: $units, ')
          ..write('themeMode: $themeMode, ')
          ..write('languageCode: $languageCode, ')
          ..write('scaleType: $scaleType, ')
          ..write('notificationsEnabled: $notificationsEnabled')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ProfilesTable profiles = $ProfilesTable(this);
  late final $ResultsTable results = $ResultsTable(this);
  late final $SettingsRowsTable settingsRows = $SettingsRowsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    profiles,
    results,
    settingsRows,
  ];
}

typedef $$ProfilesTableCreateCompanionBuilder =
    ProfilesCompanion Function({
      Value<int> id,
      required String gender,
      required DateTime dateOfBirth,
      required double weightKg,
      required double heightCm,
      required String experience,
      required String equipment,
      required String goal,
      required bool parqPassed,
      required bool acceptedTerms,
    });
typedef $$ProfilesTableUpdateCompanionBuilder =
    ProfilesCompanion Function({
      Value<int> id,
      Value<String> gender,
      Value<DateTime> dateOfBirth,
      Value<double> weightKg,
      Value<double> heightCm,
      Value<String> experience,
      Value<String> equipment,
      Value<String> goal,
      Value<bool> parqPassed,
      Value<bool> acceptedTerms,
    });

class $$ProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get experience => $composableBuilder(
    column: $table.experience,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get parqPassed => $composableBuilder(
    column: $table.parqPassed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get acceptedTerms => $composableBuilder(
    column: $table.acceptedTerms,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get experience => $composableBuilder(
    column: $table.experience,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equipment => $composableBuilder(
    column: $table.equipment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goal => $composableBuilder(
    column: $table.goal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get parqPassed => $composableBuilder(
    column: $table.parqPassed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get acceptedTerms => $composableBuilder(
    column: $table.acceptedTerms,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfilesTable> {
  $$ProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<String> get experience => $composableBuilder(
    column: $table.experience,
    builder: (column) => column,
  );

  GeneratedColumn<String> get equipment =>
      $composableBuilder(column: $table.equipment, builder: (column) => column);

  GeneratedColumn<String> get goal =>
      $composableBuilder(column: $table.goal, builder: (column) => column);

  GeneratedColumn<bool> get parqPassed => $composableBuilder(
    column: $table.parqPassed,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get acceptedTerms => $composableBuilder(
    column: $table.acceptedTerms,
    builder: (column) => column,
  );
}

class $$ProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfilesTable,
          Profile,
          $$ProfilesTableFilterComposer,
          $$ProfilesTableOrderingComposer,
          $$ProfilesTableAnnotationComposer,
          $$ProfilesTableCreateCompanionBuilder,
          $$ProfilesTableUpdateCompanionBuilder,
          (Profile, BaseReferences<_$AppDatabase, $ProfilesTable, Profile>),
          Profile,
          PrefetchHooks Function()
        > {
  $$ProfilesTableTableManager(_$AppDatabase db, $ProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> gender = const Value.absent(),
                Value<DateTime> dateOfBirth = const Value.absent(),
                Value<double> weightKg = const Value.absent(),
                Value<double> heightCm = const Value.absent(),
                Value<String> experience = const Value.absent(),
                Value<String> equipment = const Value.absent(),
                Value<String> goal = const Value.absent(),
                Value<bool> parqPassed = const Value.absent(),
                Value<bool> acceptedTerms = const Value.absent(),
              }) => ProfilesCompanion(
                id: id,
                gender: gender,
                dateOfBirth: dateOfBirth,
                weightKg: weightKg,
                heightCm: heightCm,
                experience: experience,
                equipment: equipment,
                goal: goal,
                parqPassed: parqPassed,
                acceptedTerms: acceptedTerms,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String gender,
                required DateTime dateOfBirth,
                required double weightKg,
                required double heightCm,
                required String experience,
                required String equipment,
                required String goal,
                required bool parqPassed,
                required bool acceptedTerms,
              }) => ProfilesCompanion.insert(
                id: id,
                gender: gender,
                dateOfBirth: dateOfBirth,
                weightKg: weightKg,
                heightCm: heightCm,
                experience: experience,
                equipment: equipment,
                goal: goal,
                parqPassed: parqPassed,
                acceptedTerms: acceptedTerms,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfilesTable,
      Profile,
      $$ProfilesTableFilterComposer,
      $$ProfilesTableOrderingComposer,
      $$ProfilesTableAnnotationComposer,
      $$ProfilesTableCreateCompanionBuilder,
      $$ProfilesTableUpdateCompanionBuilder,
      (Profile, BaseReferences<_$AppDatabase, $ProfilesTable, Profile>),
      Profile,
      PrefetchHooks Function()
    >;
typedef $$ResultsTableCreateCompanionBuilder =
    ResultsCompanion Function({
      required String id,
      required String exerciseId,
      required double value,
      required DateTime date,
      Value<String?> note,
      Value<String?> videoPath,
      Value<double?> bodyweightKg,
      Value<double?> heightCm,
      Value<int> rowid,
    });
typedef $$ResultsTableUpdateCompanionBuilder =
    ResultsCompanion Function({
      Value<String> id,
      Value<String> exerciseId,
      Value<double> value,
      Value<DateTime> date,
      Value<String?> note,
      Value<String?> videoPath,
      Value<double?> bodyweightKg,
      Value<double?> heightCm,
      Value<int> rowid,
    });

class $$ResultsTableFilterComposer
    extends Composer<_$AppDatabase, $ResultsTable> {
  $$ResultsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get videoPath => $composableBuilder(
    column: $table.videoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bodyweightKg => $composableBuilder(
    column: $table.bodyweightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ResultsTableOrderingComposer
    extends Composer<_$AppDatabase, $ResultsTable> {
  $$ResultsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get videoPath => $composableBuilder(
    column: $table.videoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bodyweightKg => $composableBuilder(
    column: $table.bodyweightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ResultsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ResultsTable> {
  $$ResultsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<String> get videoPath =>
      $composableBuilder(column: $table.videoPath, builder: (column) => column);

  GeneratedColumn<double> get bodyweightKg => $composableBuilder(
    column: $table.bodyweightKg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);
}

class $$ResultsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ResultsTable,
          Result,
          $$ResultsTableFilterComposer,
          $$ResultsTableOrderingComposer,
          $$ResultsTableAnnotationComposer,
          $$ResultsTableCreateCompanionBuilder,
          $$ResultsTableUpdateCompanionBuilder,
          (Result, BaseReferences<_$AppDatabase, $ResultsTable, Result>),
          Result,
          PrefetchHooks Function()
        > {
  $$ResultsTableTableManager(_$AppDatabase db, $ResultsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ResultsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ResultsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ResultsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> videoPath = const Value.absent(),
                Value<double?> bodyweightKg = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ResultsCompanion(
                id: id,
                exerciseId: exerciseId,
                value: value,
                date: date,
                note: note,
                videoPath: videoPath,
                bodyweightKg: bodyweightKg,
                heightCm: heightCm,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String exerciseId,
                required double value,
                required DateTime date,
                Value<String?> note = const Value.absent(),
                Value<String?> videoPath = const Value.absent(),
                Value<double?> bodyweightKg = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ResultsCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                value: value,
                date: date,
                note: note,
                videoPath: videoPath,
                bodyweightKg: bodyweightKg,
                heightCm: heightCm,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ResultsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ResultsTable,
      Result,
      $$ResultsTableFilterComposer,
      $$ResultsTableOrderingComposer,
      $$ResultsTableAnnotationComposer,
      $$ResultsTableCreateCompanionBuilder,
      $$ResultsTableUpdateCompanionBuilder,
      (Result, BaseReferences<_$AppDatabase, $ResultsTable, Result>),
      Result,
      PrefetchHooks Function()
    >;
typedef $$SettingsRowsTableCreateCompanionBuilder =
    SettingsRowsCompanion Function({
      Value<int> id,
      required String units,
      required String themeMode,
      Value<String?> languageCode,
      required String scaleType,
      required bool notificationsEnabled,
    });
typedef $$SettingsRowsTableUpdateCompanionBuilder =
    SettingsRowsCompanion Function({
      Value<int> id,
      Value<String> units,
      Value<String> themeMode,
      Value<String?> languageCode,
      Value<String> scaleType,
      Value<bool> notificationsEnabled,
    });

class $$SettingsRowsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsRowsTable> {
  $$SettingsRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get units => $composableBuilder(
    column: $table.units,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scaleType => $composableBuilder(
    column: $table.scaleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsRowsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsRowsTable> {
  $$SettingsRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get units => $composableBuilder(
    column: $table.units,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scaleType => $composableBuilder(
    column: $table.scaleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsRowsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsRowsTable> {
  $$SettingsRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get units =>
      $composableBuilder(column: $table.units, builder: (column) => column);

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get languageCode => $composableBuilder(
    column: $table.languageCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scaleType =>
      $composableBuilder(column: $table.scaleType, builder: (column) => column);

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => column,
  );
}

class $$SettingsRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsRowsTable,
          SettingsRow,
          $$SettingsRowsTableFilterComposer,
          $$SettingsRowsTableOrderingComposer,
          $$SettingsRowsTableAnnotationComposer,
          $$SettingsRowsTableCreateCompanionBuilder,
          $$SettingsRowsTableUpdateCompanionBuilder,
          (
            SettingsRow,
            BaseReferences<_$AppDatabase, $SettingsRowsTable, SettingsRow>,
          ),
          SettingsRow,
          PrefetchHooks Function()
        > {
  $$SettingsRowsTableTableManager(_$AppDatabase db, $SettingsRowsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> units = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String?> languageCode = const Value.absent(),
                Value<String> scaleType = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
              }) => SettingsRowsCompanion(
                id: id,
                units: units,
                themeMode: themeMode,
                languageCode: languageCode,
                scaleType: scaleType,
                notificationsEnabled: notificationsEnabled,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String units,
                required String themeMode,
                Value<String?> languageCode = const Value.absent(),
                required String scaleType,
                required bool notificationsEnabled,
              }) => SettingsRowsCompanion.insert(
                id: id,
                units: units,
                themeMode: themeMode,
                languageCode: languageCode,
                scaleType: scaleType,
                notificationsEnabled: notificationsEnabled,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsRowsTable,
      SettingsRow,
      $$SettingsRowsTableFilterComposer,
      $$SettingsRowsTableOrderingComposer,
      $$SettingsRowsTableAnnotationComposer,
      $$SettingsRowsTableCreateCompanionBuilder,
      $$SettingsRowsTableUpdateCompanionBuilder,
      (
        SettingsRow,
        BaseReferences<_$AppDatabase, $SettingsRowsTable, SettingsRow>,
      ),
      SettingsRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ProfilesTableTableManager get profiles =>
      $$ProfilesTableTableManager(_db, _db.profiles);
  $$ResultsTableTableManager get results =>
      $$ResultsTableTableManager(_db, _db.results);
  $$SettingsRowsTableTableManager get settingsRows =>
      $$SettingsRowsTableTableManager(_db, _db.settingsRows);
}
