require 'rails_helper'

RSpec.describe Plane, type: :model do

 let!(:plane){ Plane.new }

  context 'valid' do
    #share state across explames
    #----------------------------------------------------------------------
    describe "when empty plane and single sit" do
      before(:all) do
        @plane = Plane.new
      end

      it 'first 26  must be on A windows' do
        (0..25).each do | index |
           index_aux = index+1
           #puts "index: #{index}, val: #{val}"
           expect(@plane.get_one_sit).to eq('A' + "#{index_aux}")
          end
        end

      it 'last 26  must be on F windows' do
        (0..25).each do | index |
         index_aux = index+1
         #puts "index: #{index}, val: #{val}"
         expect(@plane.get_one_sit).to eq('F' + "#{index_aux}")
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

      it 'first 26 tow-sits must be A and B' do
        (0..25).each do |index|
          index_aux=index+1
          expect(@plane.get_tow_sits).to eq(['E' + "#{index_aux}",'F' + "#{index_aux}" ])
        end
      end

    end

  end


end
