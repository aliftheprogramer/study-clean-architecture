# Copilot Instructions for clean_architecture_poktani

## Project Overview
- This is a Flutter project using Clean Architecture principles.
- The codebase is organized into `features`, `core`, and platform-specific folders (`android`, `ios`, etc).
- Each feature (e.g., `field`) is split into `data`, `domain`, and sometimes `presentation` layers.
- Data flows from API services (in `data/source/`) to models, then mapped to domain entities via `toEntity()` extension methods.
- Dependency injection is handled via a service locator (`core/services/services_locator.dart`).

## Key Patterns & Conventions
- **Repository Pattern:** Each feature has a repository interface in `domain/repository/` and an implementation in `data/repository_impl/`.
- **Model <-> Entity Mapping:** Models in `data/model/` implement `toEntity()` methods (often as extensions) to convert to domain entities in `domain/entity/`.
- **Error Handling:** API errors are wrapped in `DataFailed` (see `core/resources/data_state.dart`).
- **Equatable:** Entities extend `Equatable` for value comparison.
- **Functional Programming:** Uses `dartz` for `Either` types in repository methods.

## Developer Workflows
- **Build:** Use standard Flutter commands (`flutter build`, `flutter run`).
- **Test:** Place tests in the `test/` directory. Use `flutter test` to run.
- **Dependency Injection:** Register services in `services_locator.dart` and access via `sl<T>()`.
- **API Integration:** API services are defined in `data/source/` and injected into repositories.

## External Dependencies
- `dio` for HTTP requests
- `dartz` for functional types
- `equatable` for value equality
- `shared_preferences` for local storage

## Example: Model to Entity Mapping
```dart
extension on ResponseAddFieldsModel {
  ResponseAddField toEntity() {
    return ResponseAddField(
      id: id,
      name: name,
      landArea: land_area,
      address: address.toEntity(),
      soilType: soil_type,
      activeCrop: active_crop?.toEntity(),
    );
  }
}
```

## Directory References
- `lib/features/field/data/model/response/field/response_add_fields_model.dart`: Example model
- `lib/features/field/domain/entity/list_field_entity.dart`: Example entity
- `lib/features/field/data/repository_impl/field_repository_impl.dart`: Example repository implementation
- `core/services/services_locator.dart`: Service locator for DI

## Tips for AI Agents
- Always use `toEntity()` for model/entity conversion.
- Use dependency injection via `sl<T>()` for services.
- Follow the Clean Architecture separation strictly: data <-> domain <-> presentation.
- Handle errors using `DataFailed` and `DataSuccess` wrappers.
- Use `dartz`'s `Either` for repository return types.

---

If any section is unclear or missing, please provide feedback to improve these instructions.
