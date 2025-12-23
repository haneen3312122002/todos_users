import 'package:notes_tasks/core/features/propasles/service/proposal_service.dart';
import 'package:notes_tasks/modules/propseles/domain/entities/proposal_entity.dart';

class WatchJobProposalsUseCase {
  final ProposalsService _service;
  WatchJobProposalsUseCase(this._service);

  Stream<List<ProposalEntity>> call(String jobId) =>
      _service.watchJobProposals(jobId);
}
