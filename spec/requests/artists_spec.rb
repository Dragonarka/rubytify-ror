require 'rails_helper'

RSpec.describe "Artists", type: :request do
  
  describe "GET /api/v1/artists" do
    before { get '/api/v1/artists' }

    it 'returns artists' do
      result = JSON(response.body)
      expect(result).not_to be_empty
      expect(result.size).to eq(10) 
  end

  it 'returns status code 200' do
    expect(response).to have_http_status(200)
  end

end
end
