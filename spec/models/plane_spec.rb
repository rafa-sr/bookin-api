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

      it 'first 26 one-sit  must be on A windows' do
        (0..25).each do | index |
           index_aux = index+1
           #puts "index: #{index}, val: #{val}"
           expect(@plane.get_one_sit).to eq('A' + "#{index_aux}")
          end
        end

      it 'after no A windows sits, next 26 one-sit  must be on F windows' do
        (0..25).each do | index |
         index_aux = index+1
         #puts "index: #{index}, val: #{val}"
         expect(@plane.get_one_sit).to eq('F' + "#{index_aux}")
        end
      end

      describe "and no windows sits" do

        it 'get-tow-sits should get B and C sits' do
          (0..25).each do |index|
            index_aux = index+1
            expect(@plane.get_tow_sits).to eq(['B' + "#{index_aux}",'C' + "#{index_aux}"])
          end
        end

        it 'and left side is full, get-tow-sit should get D and E sits ' do
          (0..25).each do |index|
            index_aux = index+1
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
        end
      end

      it 'after no A sits, next 26 tow-sits must be E and F' do
        (0..25).each do |index|
          index_aux=index+1
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

  end

end
