require 'ganglia/gearman/ganglia_connection'

describe Ganglia::Gearman::GangliaConnection do
  describe 'report' do
    let(:metrics) { [
      { :function => 'worker_one:ability_one', :total => 1, :running => 2, :available => 3 },
      { :function => 'worker_one:ability_two', :total => 4, :running => 5, :available => 6 },
      { :function => 'worker_two:ability_three', :total => 7, :running => 8, :available => 9 }
    ] }

    before :each do
      Ganglia::GMetric.stub(:send)
    end

    it 'should send 3 metrics for each function' do
      Ganglia::GMetric.should_receive(:send).exactly(metrics.length * 3).times
    end
  end
end
