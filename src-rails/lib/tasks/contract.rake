namespace :contract do
  desc "Update contract status"
  task update_status: :environment do
    contracts_to_finish = Contract.not_finished_need_to_be_updated
    contracts_to_finish.each do |contract|
      contract.update_attribute(:status, :finished)
    end

    contracts_to_pend  = Contract.not_pending_need_to_be_updated
    contracts_to_pend.each do |contract|
      contract.update_attribute(:status, :pending)
    end

    contracts_to_activate = Contract.not_activated_need_to_be_updated
    contracts_to_activate.each do |contract|
      contract.update_attribute(:status, :active)
    end
  end

end
