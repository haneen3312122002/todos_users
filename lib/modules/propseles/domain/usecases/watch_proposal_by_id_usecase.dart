import 'package:notes_tasks/core/features/propasles/service/proposal_service.dart';
import 'package:notes_tasks/modules/propseles/domain/entities/proposal_entity.dart';

class WatchProposalByIdUseCase {
  final ProposalsService _service;
  WatchProposalByIdUseCase(this._service);

  Stream<ProposalEntity?> call(String proposalId) =>
      _service.watchProposalById(proposalId);
}
