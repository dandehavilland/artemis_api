module ArtemisApi
  class Facility < ArtemisApi::Model
    json_type 'facilities'

    def self.find(id:, client:, include: nil, force: false)
      client.find_one(self.json_type, id, include: include, force: force)
    end

    def self.find_all(client:, include: nil)
      client.find_all(self.json_type, include: include)
    end

    def zones
      ArtemisApi::Zone.find_all(id, client)
    end

    def find_zone(zone_id)
      ArtemisApi::Zone.find(zone_id, id, client)
    end

    def batches
      ArtemisApi::Batch.find_all(facility_id: id, client: client)
    end

    def find_batch(batch_id)
      ArtemisApi::Batch.find(id: batch_id, facility_id: id, client: client)
    end
  end
end
