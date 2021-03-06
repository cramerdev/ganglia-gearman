require 'ganglia/gearman/gearman_server'

describe Ganglia::Gearman::GearmanServer do
  describe '#status' do
    let(:server) { described_class.new }
    subject(:status) { server.status }

    before :each do
      file = open('spec/support/fixtures/status.txt')
      file.stub(:puts)
      server.stub(:socket).and_return(file)
    end

    it { should eql([
      { :function => 'worker_one:ability_one', :total => 1, :running => 2, :available => 3 },
      { :function => 'worker_one:ability_two', :total => 4, :running => 5, :available => 6 },
      { :function => 'worker_two:ability_three', :total => 7, :running => 8, :available => 9 }
    ]) }
  end
end
