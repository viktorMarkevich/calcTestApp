require 'rails_helper'

RSpec.describe 'Calcs', type: :request do
  let(:json) { JSON.parse(response.body) }

  describe 'GET /calcs' do
    it 'works! (now write some real specs)' do
      get '/calcs'
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /calcs' do
    let(:headers) {{ 'Content-Type' => 'application/json' }}

    context 'When valid request' do
      it 'should return 200 status' do
        post '/calcs.json', params: { calc: { operator: '+', a: 1, b: 3 } }.to_json, headers: headers
        expect(response).to have_http_status(200)
      end

      it 'should create a calc object and return json' do
        post '/calcs.json', params: { calc: { operator: '+', a: 1, b: 3 } }.to_json, headers: headers
        expect(json).to eq({ 'result' => "Operation: 1 + 3\nResult: 4\nID: #{Calc.last.id}\nCount: 1\n#{'*'*20}" })
      end
    end
  end
end
