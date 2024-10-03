import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const ProposalContractModule = buildModule("ProposalContractModule", (m) => {

  const proposal = m.contract("ProposalContract");

  return { proposal };
});

export default ProposalContractModule;
