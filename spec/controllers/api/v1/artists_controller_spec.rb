require 'rails_helper'

describe Api::V1::ArtistsController do
    describe 'index' do
        let(:artist) {create(:artist)}

        it 'returns artists' do
            artist
            get :index
            result = JSON(response.body)
            expect(result).not_to be_empty
            expect(result['artists'].size).to eq(1)          
        end
    end
end