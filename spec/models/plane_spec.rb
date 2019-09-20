require 'rails_helper'

RSpec.describe Plane, type: :model do

 let!(:plane){ Plane.new }

  context 'valid' do
    #share state across explames
    #----------------------------------------------------------------------
    describe "when empty plane" do
      before(:all) do
        @plane = Plane.new
      end

      it 'first 52 one-sit should be front to bottom' do
        (0..25).each do | index |
           index_aux = index+1
           expect(@plane.get_one_sit).to eq('A' + "#{index_aux}")
           expect(@plane.get_one_sit).to eq('F' + "#{index_aux}")
          end
        end

      describe "and no windows sits" do

        it 'get-tow-sits should get B and C sits or D and E' do
          (0..25).each do |index|
            index_aux = index+1
            expect(@plane.get_tow_sits).to eq(['B' + "#{index_aux}",'C' + "#{index_aux}"])
            expect(@plane.get_tow_sits).to eq(['D'+ "#{index_aux}", 'E' + "#{index_aux}"])
          end
        end

      end
    end
    #----------------------------------------------------------------------

    describe 'when empty plane and 2 sits' do

      before(:all) do
        @plane = Plane.new
      end

      it 'first 26 tow-sits must be A and B' do
        (0..25).each do |index|
          index_aux=index+1
          expect(@plane.get_tow_sits).to eq(['A' + "#{index_aux}",'B' + "#{index_aux}" ])
          expect(@plane.get_tow_sits).to eq(['E' + "#{index_aux}",'F' + "#{index_aux}" ])
        end
      end

      it 'after no windows sits, should get  C and D' do
        (0..25).each do |index|
          index_aux = index +1
          expect(@plane.get_tow_sits).to eq(['C' + "#{index_aux}", 'D' + "#{index_aux}"])
        end
      end

    end

    describe 'and try get-three-sits' do
      before(:all) do
        @plane = Plane.new
      end

      it 'should get A,B,C' do
        (0..25).each do |index|
          index_aux = index +1
          expect(@plane.get_three_sits).to eq(['A' + "#{index_aux}", 'B' + "#{index_aux}",#
                                               'C' + "#{index_aux}"])
          expect(@plane.get_three_sits).to eq(['D' + "#{index_aux}", 'E' + "#{index_aux}",#
                                               'F' + "#{index_aux}"])
        end
      end

    end

    describe 'expected values' do
      before {@plane = Plane.new}

      it "expected values" do
        expected_values =  ["A1",['E1','F1'],['A2','B2','C2'],['A2','B2','C2'],['A3','B3']]
        expect(@plane.get_one_sit).to eq(expected_values[0])
        expect(@plane.get_tow_sits).to eq(expected_values[1])
        expect(@plane.get_three_sits).to eq(expected_values[2])
        expect(@plane.get_three_sits).to eq(expected_values[3])
      end
    end

    describe 'four-sits' do
      before {@plane = Plane.new}

      it "should put them balanced across row " do
        #todo valifa front to left
        @plane.get_one_sit
        (0..25).each do
          sits_expected = Array.new
          sits_row2 = Array.new
          sits = @plane.get_four_sits
          sits_expected << sits[0].first + (sits[0][1,2].to_i + 1).to_s
          sits_expected << sits[1].first + (sits[1][1,2].to_i + 1).to_s
          sits_row2 << sits.at(2) << sits.at(3)
        #  puts "row2" + sits_row2.inspect
        #  puts "expect" + sits_expected.inspect
          expect(sits_row2).to eq(sits_expected)
        end
      end
    end

  end

end
