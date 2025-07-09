import 'package:clean_architecture_poktani/features/auth/domain/entities/request/login_request_entities.dart';

abstract class RemoteLoginEvent {
  const RemoteLoginEvent();
}

class SubmitLoginEvent extends RemoteLoginEvent {
  final LoginEntities loginData;

  const SubmitLoginEvent({required this.loginData});
}
