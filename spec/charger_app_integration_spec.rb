require 'spec_helper'
require 'charger_app'

RSpec.describe 'integration' do
  let(:meter_values) do
    <<-JSON
      [
        { "id": "1", "charge_session_id": "1", "amount_of_charge": "130", "rate_of_charge": "1300" },
        { "id": "2", "charge_session_id": "1", "amount_of_charge": "903", "rate_of_charge": "2600" },
        { "id": "3", "charge_session_id": "1", "amount_of_charge": "2195", "rate_of_charge": "3600" },
        { "id": "4", "charge_session_id": "1", "amount_of_charge": "3187", "rate_of_charge": "4700" },
        { "id": "5", "charge_session_id": "2", "amount_of_charge": "50", "rate_of_charge": "100" },
        { "id": "6", "charge_session_id": "2", "amount_of_charge": "523", "rate_of_charge": "200" },
        { "id": "7", "charge_session_id": "2", "amount_of_charge": "1054", "rate_of_charge": "300" },
        { "id": "8", "charge_session_id": "2", "amount_of_charge": "1287", "rate_of_charge": "600" },
        { "id": "9", "charge_session_id": "3", "amount_of_charge": "17", "rate_of_charge": "5711" },
        { "id": "10", "charge_session_id": "3", "amount_of_charge": "103", "rate_of_charge": "6310" },
        { "id": "11", "charge_session_id": "3", "amount_of_charge": "195", "rate_of_charge": "5930" },
        { "id": "12", "charge_session_id": "3", "amount_of_charge": "287", "rate_of_charge": "5660" },
        { "id": "13", "charge_session_id": "4", "amount_of_charge": "456", "rate_of_charge": "1000" },
        { "id": "14", "charge_session_id": "4", "amount_of_charge": "1258", "rate_of_charge": "2000" },
        { "id": "15", "charge_session_id": "4", "amount_of_charge": "2554", "rate_of_charge": "4300" },
        { "id": "16", "charge_session_id": "4", "amount_of_charge": "2988", "rate_of_charge": "3300" }
      ]
    JSON
  end

  let(:charge_sessions) do
    <<-JSON
      [
        { "id": "1", "user": "Gordon Cote" },
        { "id": "2", "user": "Lorna Phillips" },
        { "id": "3", "user": "Lorna Phillips" },
        { "id": "4", "user": "Esmai Merritt" }
      ]
    JSON
  end

  let(:expected_result_json) do
    <<-JSON
      [
        { "user": "Gordon Cote", "session_count": "1", "total_charge_amount": "3.19 kWh", "average_rate_of_charge": "3.05 kW" },
        { "user": "Lorna Phillips", "session_count": "2", "total_charge_amount": "1.57 kWh", "average_rate_of_charge": "3.10 kW"},
        { "user": "Esmai Merritt", "session_count": "1", "total_charge_amount": "2.99 kWh", "average_rate_of_charge": "2.65 kW"}
      ]
    JSON
  end

  describe ChargerApp do
    subject(:result) do
      json_result = ChargerApp.call(meter_values, charge_sessions)

      JSON.parse(json_result)
    end

    it 'outputs JSON in expected form' do
      expect(result).to eq JSON.parse(expected_result_json)
    end

    it 'has users who charged' do
      expect(result[0]['user']).to eq('Gordon Cote')
      expect(result[1]['user']).to eq('Lorna Phillips')
      expect(result[2]['user']).to eq('Esmai Merritt')
    end

    it 'has session count for each user' do
      expect(result[0]['session_count']).to eq('1')
      expect(result[1]['session_count']).to eq('2')
      expect(result[2]['session_count']).to eq('1')
    end

    it 'has kilowatt_total for each user' do
      expect(result[0]['total_charge_amount']).to eq('3.19 kWh')
      expect(result[1]['total_charge_amount']).to eq('1.57 kWh')
      expect(result[2]['total_charge_amount']).to eq('2.99 kWh')
    end

    it 'has average charge speed for each user' do
      expect(result[0]['average_rate_of_charge']).to eq('3.05 kW')
      expect(result[1]['average_rate_of_charge']).to eq('3.10 kW')
      expect(result[2]['average_rate_of_charge']).to eq('2.65 kW')
    end
  end
end
