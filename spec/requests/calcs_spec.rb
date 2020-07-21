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

    context 'Valid case' do
      context 'When operator is "+"' do
        it 'should return 200 status' do
          post '/calcs.json', params: { calc: { operator: '+', a: 1, b: 3 } }.to_json, headers: headers
          expect(response).to have_http_status(200)
        end

        it 'should create a calc object and return json' do
          post '/calcs.json', params: { calc: { operator: '+', a: 1, b: 3 } }.to_json, headers: headers
          expect(json).to eq({ 'result' => "Operation: 1 + 3\nResult: 4\nID: #{Calc.last.id}\nCount: 1\n#{'*'*20}" })
        end
      end

      context 'When operator is "-"' do
        it 'should return 200 status' do
          post '/calcs.json', params: { calc: { operator: '-', a: 1, b: 3 } }.to_json, headers: headers
          expect(response).to have_http_status(200)
        end

        it 'should create a calc object and return json' do
          post '/calcs.json', params: { calc: { operator: '-', a: 1, b: 3 } }.to_json, headers: headers
          expect(json).to eq({ 'result' => "Operation: 1 - 3\nResult: -2\nID: #{Calc.last.id}\nCount: 1\n#{'*'*20}" })
        end
      end

      context 'When operator is "*"' do
        it 'should return 200 status' do
          post '/calcs.json', params: { calc: { operator: '*', a: 1, b: 3 } }.to_json, headers: headers
          expect(response).to have_http_status(200)
        end

        it 'should create a calc object and return json' do
          post '/calcs.json', params: { calc: { operator: '*', a: 1, b: 3 } }.to_json, headers: headers
          expect(json).to eq({ 'result' => "Operation: 1 * 3\nResult: 3\nID: #{Calc.last.id}\nCount: 1\n#{'*'*20}" })
        end
      end

      context 'When operator is "/"' do
        it 'should return 200 status' do
          post '/calcs.json', params: { calc: { operator: '/', a: 4, b: 2 } }.to_json, headers: headers
          expect(response).to have_http_status(200)
        end

        it 'should create a calc object and return json' do
          post '/calcs.json', params: { calc: { operator: '/', a: 4, b: 2 } }.to_json, headers: headers
          expect(json).to eq({ 'result' => "Operation: 4 / 2\nResult: 2\nID: #{Calc.last.id}\nCount: 1\n#{'*'*20}" })
        end
      end

      context 'When operation was created before' do
        let!(:calc) { create :calc }

        it 'should return 200 status' do
          post '/calcs.json', params: { calc: { operator: '+', a: '1', b: '3' } }.to_json, headers: headers
          expect(response).to have_http_status(200)
        end

        it 'should create a calc object and return json; COUNT IS EQ 2' do
          post '/calcs.json', params: { calc: { operator: '+', a: '1', b: '3' } }.to_json, headers: headers
          calc.reload
          expect(json).to eq({ 'result' => "Operation: 1 + 3\nResult: 4\nID: #{calc.id}\nCount: 2\n#{'*'*20}" })
        end
      end
    end

    context 'Invalid case' do
      context 'when a argument is negative' do
        it 'should return 422 status' do
          post '/calcs.json', params: { calc: { operator: '+', a: '-1', b: '3' } }.to_json, headers: headers
          expect(response).to have_http_status(422)
        end

        it 'should NOT create calc object' do
          post '/calcs.json', params: { calc: { operator: '+', a: '-1', b: '3' } }.to_json, headers: headers

          expect(Calc.count).to eq 0
          expect(json).to eq({ 'errors' => 'error' })
        end
      end

      context 'when a argument is bigger than 100' do
        it 'should return 422 status' do
          post '/calcs.json', params: { calc: { operator: '+', a: '1', b: '101' } }.to_json, headers: headers
          expect(response).to have_http_status(422)
        end

        it 'should NOT create calc object' do
          post '/calcs.json', params: { calc: { operator: '+', a: '1', b: '101' } }.to_json, headers: headers

          expect(Calc.count).to eq 0
          expect(json).to eq({ 'errors' => 'error' })
        end
      end

      context 'when a argument is a float type' do

      end

      context 'when a argument is a text type' do

      end
    end
  end
end
