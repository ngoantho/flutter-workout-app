// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  WorkoutDao? _workoutDaoInstance;

  ExerciseResultDao? _exerciseResultDaoInstance;

  ExerciseDao? _exerciseDaoInstance;

  WorkoutPlanDao? _workoutPlanDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `exercise_result` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `workout_id` INTEGER, `actualOutput` INTEGER NOT NULL, `targetOutput` INTEGER NOT NULL, `exerciseName` TEXT NOT NULL, `measurementUnit` INTEGER NOT NULL, FOREIGN KEY (`workout_id`) REFERENCES `workout` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `exercise` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `workout_plan_id` INTEGER, `name` TEXT NOT NULL, `target` INTEGER NOT NULL, `unit` INTEGER NOT NULL, FOREIGN KEY (`workout_plan_id`) REFERENCES `workout_plan` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `workout_plan` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `workout` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `workout_day` INTEGER NOT NULL, `workout_month` INTEGER NOT NULL, `workout_year` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  WorkoutDao get workoutDao {
    return _workoutDaoInstance ??= _$WorkoutDao(database, changeListener);
  }

  @override
  ExerciseResultDao get exerciseResultDao {
    return _exerciseResultDaoInstance ??=
        _$ExerciseResultDao(database, changeListener);
  }

  @override
  ExerciseDao get exerciseDao {
    return _exerciseDaoInstance ??= _$ExerciseDao(database, changeListener);
  }

  @override
  WorkoutPlanDao get workoutPlanDao {
    return _workoutPlanDaoInstance ??=
        _$WorkoutPlanDao(database, changeListener);
  }
}

class _$WorkoutDao extends WorkoutDao {
  _$WorkoutDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _workoutInsertionAdapter = InsertionAdapter(
            database,
            'workout',
            (Workout item) => <String, Object?>{
                  'id': item.id,
                  'workout_day': item.workoutDay,
                  'workout_month': item.workoutMonth,
                  'workout_year': item.workoutYear
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Workout> _workoutInsertionAdapter;

  @override
  Future<List<Workout>> getAllWorkouts() async {
    return _queryAdapter.queryList('SELECT * FROM workout',
        mapper: (Map<String, Object?> row) => Workout(
            id: row['id'] as int?,
            workoutDay: row['workout_day'] as int,
            workoutMonth: row['workout_month'] as int,
            workoutYear: row['workout_year'] as int));
  }

  @override
  Future<List<Workout>> getWorkoutsByDate(
    int day,
    int month,
    int year,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM workout WHERE workout_day = ?1 AND workout_month = ?2 AND workout_year = ?3',
        mapper: (Map<String, Object?> row) => Workout(id: row['id'] as int?, workoutDay: row['workout_day'] as int, workoutMonth: row['workout_month'] as int, workoutYear: row['workout_year'] as int),
        arguments: [day, month, year]);
  }

  @override
  Future<int> addWorkout(Workout workout) {
    return _workoutInsertionAdapter.insertAndReturnId(
        workout, OnConflictStrategy.abort);
  }
}

class _$ExerciseResultDao extends ExerciseResultDao {
  _$ExerciseResultDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _exerciseResultInsertionAdapter = InsertionAdapter(
            database,
            'exercise_result',
            (ExerciseResult item) => <String, Object?>{
                  'id': item.id,
                  'workout_id': item.workoutId,
                  'actualOutput': item.actualOutput,
                  'targetOutput': item.targetOutput,
                  'exerciseName': item.exerciseName,
                  'measurementUnit': item.measurementUnit.index
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ExerciseResult> _exerciseResultInsertionAdapter;

  @override
  Future<List<ExerciseResult>> getExerciseResultsByWorkoutId(
      int workoutId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM exercise_result WHERE workout_id = ?1',
        mapper: (Map<String, Object?> row) => ExerciseResult(
            id: row['id'] as int?,
            workoutId: row['workout_id'] as int?,
            actualOutput: row['actualOutput'] as int,
            targetOutput: row['targetOutput'] as int,
            exerciseName: row['exerciseName'] as String,
            measurementUnit:
                MeasurementUnit.values[row['measurementUnit'] as int]),
        arguments: [workoutId]);
  }

  @override
  Future<int> addExerciseResult(ExerciseResult exerciseResult) {
    return _exerciseResultInsertionAdapter.insertAndReturnId(
        exerciseResult, OnConflictStrategy.abort);
  }
}

class _$ExerciseDao extends ExerciseDao {
  _$ExerciseDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _exerciseInsertionAdapter = InsertionAdapter(
            database,
            'exercise',
            (Exercise item) => <String, Object?>{
                  'id': item.id,
                  'workout_plan_id': item.workoutPlanId,
                  'name': item.name,
                  'target': item.target,
                  'unit': item.unit.index
                }),
        _exerciseDeletionAdapter = DeletionAdapter(
            database,
            'exercise',
            ['id'],
            (Exercise item) => <String, Object?>{
                  'id': item.id,
                  'workout_plan_id': item.workoutPlanId,
                  'name': item.name,
                  'target': item.target,
                  'unit': item.unit.index
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Exercise> _exerciseInsertionAdapter;

  final DeletionAdapter<Exercise> _exerciseDeletionAdapter;

  @override
  Future<List<Exercise>> getExercisesByWorkoutPlanId(int workoutPlanId) async {
    return _queryAdapter.queryList(
        'SELECT * FROM exercise WHERE workout_plan_id = ?1',
        mapper: (Map<String, Object?> row) => Exercise(
            id: row['id'] as int?,
            workoutPlanId: row['workout_plan_id'] as int?,
            name: row['name'] as String,
            target: row['target'] as int,
            unit: MeasurementUnit.values[row['unit'] as int]),
        arguments: [workoutPlanId]);
  }

  @override
  Future<int> addExercise(Exercise exercise) {
    return _exerciseInsertionAdapter.insertAndReturnId(
        exercise, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteExercise(Exercise exercise) async {
    await _exerciseDeletionAdapter.delete(exercise);
  }
}

class _$WorkoutPlanDao extends WorkoutPlanDao {
  _$WorkoutPlanDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _workoutPlanInsertionAdapter = InsertionAdapter(
            database,
            'workout_plan',
            (WorkoutPlan item) =>
                <String, Object?>{'id': item.id, 'name': item.name}),
        _workoutPlanDeletionAdapter = DeletionAdapter(
            database,
            'workout_plan',
            ['id'],
            (WorkoutPlan item) =>
                <String, Object?>{'id': item.id, 'name': item.name});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<WorkoutPlan> _workoutPlanInsertionAdapter;

  final DeletionAdapter<WorkoutPlan> _workoutPlanDeletionAdapter;

  @override
  Future<List<WorkoutPlan>> getAllWorkoutPlans() async {
    return _queryAdapter.queryList('SELECT * FROM workout_plan',
        mapper: (Map<String, Object?> row) =>
            WorkoutPlan(id: row['id'] as int?, name: row['name'] as String));
  }

  @override
  Future<int?> getWorkoutPlanByName(String name) async {
    return _queryAdapter.query('SELECT id FROM workout_plan WHERE name = ?1',
        mapper: (Map<String, Object?> row) => row.values.first as int,
        arguments: [name]);
  }

  @override
  Future<int> addWorkoutPlan(WorkoutPlan workoutPlan) {
    return _workoutPlanInsertionAdapter.insertAndReturnId(
        workoutPlan, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteWorkoutPlan(WorkoutPlan workoutPlan) async {
    await _workoutPlanDeletionAdapter.delete(workoutPlan);
  }
}
