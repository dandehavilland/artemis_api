require "test_helper"

class CompletionTest < Minitest::Test
  def setup
    get_client
    get_facility

    stub_request(:get, "http://localhost:3000/api/v3/facilities/#{@facility.id}/completions")
      .to_return(body: {data: [{id: '1', type: 'completions', attributes: {id: 1, action_type: 'start'}}, {id: '2', type: 'completions', attributes: {id: 2, action_type: 'move'}}]}.to_json)

    stub_request(:get, "http://localhost:3000/api/v3/facilities/#{@facility.id}/completions/2")
      .to_return(body: {data: {id: '2', type: 'completions', attributes: {id: 2, action_type: 'move'}}}.to_json)
  end

  def test_finding_all_completions
    completions = ArtemisApi::Completion.find_all(facility_id: @facility.id, client: @client)
    assert_equal 2, completions.count
  end

  def test_finding_a_specific_completion
    completion = ArtemisApi::Completion.find(id: 2, facility_id: @facility.id, client: @client)
    assert_equal 'move', completion.action_type
  end
end
