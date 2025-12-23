import 'package:notes_tasks/core/features/propasles/service/proposal_service.dart';
import 'package:notes_tasks/modules/propseles/domain/entities/propsal_status.dart';

class UpdateProposalStatusUseCase {
  final ProposalsService _service;
  UpdateProposalStatusUseCase(this._service);

  Future<void> call({
    required String proposalId,
    required ProposalStatus status,
  }) {
    return _service.updateProposalStatus(
      proposalId: proposalId,
      status: status,
    );
  }
}
