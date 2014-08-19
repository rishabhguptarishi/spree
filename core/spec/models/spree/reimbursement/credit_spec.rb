require 'spec_helper'

module Spree
  describe Reimbursement::Credit do
    context 'class methods' do
      describe '.total_amount_reimbursed_for' do
        subject { Spree::Reimbursement::Credit.total_amount_reimbursed_for(reimbursement) }

        let(:reimbursement) { create(:reimbursement) }
        let(:credit_double) { double(amount: 99.99) }

        before { reimbursement.stub(:credits).and_return([credit_double, credit_double])}

        it 'should sum the amounts of all of the reimbursements credits' do
          subject.should eq BigDecimal.new('199.98')
        end
      end
    end

    describe '#description' do
      let(:credit) { Spree::Reimbursement::Credit.new(amount: 100, creditable: mock_model(Spree::PaymentMethod::Check)) }

      it "should be the creditable's class name" do
        credit.description.should eq 'Check'
      end
    end

    describe '#display_amount' do
      let(:credit) { Spree::Reimbursement::Credit.new(amount: 100) }

      it 'should be a money object' do
        credit.display_amount.should eq Spree::Money.new(100, currency: "USD")
      end
    end
  end
end