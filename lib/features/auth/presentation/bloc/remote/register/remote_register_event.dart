import 'package:clean_architecture_poktani/features/auth/domain/entities/request/register_request_entities.dart';

abstract class RemoteRegisterEvent {
  const RemoteRegisterEvent();
}

class SubmitRegisterEvent extends RemoteRegisterEvent {
  final RegisterRequestEntities registerData;

  const SubmitRegisterEvent({required this.registerData});
}
