require 'ganglia/gearman'

describe Ganglia::Gearman do
  subject(:ganglia_gearman) { Ganglia::Gearman.new }

  describe '#initialize' do
    it 'should set default gearman host' do
      ganglia_gearman.instance_variable_get(:@gearman_host).should == '127.0.0.1'
    end

    it 'should set default gearman port' do
      ganglia_gearman.instance_variable_get(:@gearman_port).should == 4730
    end

    it 'should set default gmond host' do
      ganglia_gearman.instance_variable_get(:@gmond_host).should == '127.0.0.1'
    end

    it 'should set default gmond port' do
      ganglia_gearman.instance_variable_get(:@gmond_port).should == 8649
    end
  end

  describe '#report' do
    xit 'should send the status to ganglia (TODO: stub the connections)' do
      ganglia_gearman.report.should be_true
    end
  end
end
